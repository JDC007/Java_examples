
' Grand Prix - segment.bmx

Import "constants.bmx"
Import "prop.bmx"

Type TSegment
	Const TUNNEL_NEXT_MID_PROP_COUNT:Int = 50
	Const SEGMENT_COUNT:Int = 40
	
	Global gMinZ:Float
	Global gMaxZ:Float
	Global gSegmentData:Float[,]
	Global gSegmentIndex:Int
	Global gFirstSegment:TSegment
	Global gLastSegment:TSegment
	Global gSignSide:Int = 1
	Global gHorizonYOffset:Float = 0
	
	Field fZ:Float
	Field fDXFraction:Float
	Field fDX:Float
	Field fDY:Float
	
	Field fTunnel:Int
	Field fTunnelPropCounter:Int
	Field fDistanceInSegment:Float
	Field fLength:Float
	Field fIndex:Int
	Field fCornerSignCreated:Int
	Field fNext:TSegment
	
	Function Create:TSegment(pZ:Float,pDXFraction:Float,pDYFraction:Float,pLength:Float,pIndex:Int)
		Local segment:TSegment = New TSegment
		segment.fZ = pZ
		segment.fDXFraction = pDXFraction
		segment.fDX = pDXFraction*TConstants.MAX_SEGMENT_DX
		segment.fDY = pDYFraction*TConstants.MAX_SEGMENT_DY
		
		If (pIndex >= 30 And pIndex <= 32) Then
			segment.fTunnel = True
			segment.fTunnelPropCounter = TUNNEL_NEXT_MID_PROP_COUNT
			
			If (pIndex = 30) Then
				TProp.Create(pZ,0,TProp.PROP_TUNNEL_START)
			End If
		Else
			segment.fTunnel = False
		End If
		
		If (Not(segment.fTunnel)) Then
			If (pDYFraction <= -0.3) Then
				TProp.Create(gMaxZ*1.2,0,TProp.PROP_BANNER_YELLOW)
				TProp.Create(gMaxZ*1.6,0,TProp.PROP_BANNER_YELLOW)
				TProp.Create(gMaxZ*2.0,0,TProp.PROP_BANNER_YELLOW)
			Else If (pIndex Mod 4 = 1) Then
				If (pIndex Mod 8 = 1) Then
					TProp.Create(gMaxZ+pLength/2,0,TProp.PROP_BANNER_TIRES)
				Else
					TProp.Create(gMaxZ+pLength/2,0,TProp.PROP_BANNER_COMMODORE)
				End If
			End If
			
			If (pIndex Mod 3 = 1) Then
				If (pIndex = 0) Then
					gSignSide = 1
				End If
				
				Int sign:Int = TProp.PROP_SIGN_TEST
				If (pIndex Mod 2 = 0) Then
					sign = TProp.PROP_SIGN_FG
				End If
				
				If (pLength <= 100) Then
					TProp.Create(gMaxZ+pLength*0.5,gSignSide*TConstants.ROAD_WIDTH*0.8,sign)
					gSignSide :* -1
				Else
					TProp.Create(gMaxZ+pLength*0.33,gSignSide*TConstants.ROAD_WIDTH*0.8,sign)
					TProp.Create(gMaxZ+pLength*0.66,-gSignSide*TConstants.ROAD_WIDTH*0.8,sign)
				End If
			End If
		End If
		segment.fDistanceInSegment = 0
		segment.fLength = pLength
		segment.fIndex = pIndex
		segment.fCornerSignCreated = False
		segment.fNext = Null
		Return(segment)
	End Function
	
	Function init(pGridStartZ:Float,pGridStepZ:Float)
		readSegmentData()
		createDummySegment()
		createStartSegment(pGridStartZ+pGridStepZ)
		gHorizonYOffset = 0
		gSignSide = 1
	End Function
	
	Function removeAll()
		gFirstSegment = Null
		gLastSegment = Null
	End Function
		
	Function readSegmentData()
		RestoreData track
		gSegmentData = New Float[SEGMENT_COUNT,3]
		For Local i:Int = 0 To SEGMENT_COUNT-1
			' read segmenty dx
			ReadData gSegmentData[i,0]
			
			' read segmenty dy
			ReadData gSegmentData[i,1]
			
			' read segment length
			ReadData gSegmentData[i,2]
		Next
		gSegmentIndex = 0
	End Function
	
	Function createDummySegment()
		gFirstSegment = TSegment.Create(0,0,0,0,-1)
		gLastSegment = gFirstSegment
	End Function
	
	Function createStartSegment(pStartBannerZ:Float)
		gLastSegment.fNext = TSegment.Create(gMaxZ/2,gSegmentData[gSegmentIndex,0],gSegmentData[gSegmentIndex,1],gSegmentData[gSegmentIndex,2],gSegmentIndex)
		gLastSegment = gLastSegment.fNext
		gSegmentIndex :+ 1
		TProp.Create(pStartBannerZ,0,TProp.PROP_BANNER_START)
	End Function
	
	Function updateAll(pSpeed:Float)
		Local segment:TSegment = gFirstSegment
		While (segment <> Null)
			segment.update(pSpeed)
			segment = segment.fNext
		Wend
	End Function
	
	Function checkLap:Int()
		If (gFirstSegment.fNext <> Null) Then
			If (gFirstSegment.fNext.fZ <= 0) Then
			
				Local index:Int = gFirstSegment.fIndex
				gHorizonYOffset = gHorizonYOffset + gFirstSegment.getHorizonYOffset()
				gFirstSegment = gFirstSegment.fNext
				
				Return(index = SEGMENT_COUNT-1)
			End If
		End If
		Return(False)
	End Function
	
	Function checkNext()
		If (gLastSegment.fLength <= 0) Then
			If (gLastSegment.fTunnel) Then
				If (gLastSegment.fIndex = 32) Then
					TProp.Create(gMaxZ-gLastSegment.fLength,0,TProp.PROP_TUNNEL_END)
				End If
			End If
		
			gLastSegment.fNext = TSegment.Create(gMaxZ,gSegmentData[gSegmentIndex,0],gSegmentData[gSegmentIndex,1],gSegmentData[gSegmentIndex,2],gSegmentIndex)
			gLastSegment = gLastSegment.fNext
			gSegmentIndex :+ 1
			If (gSegmentIndex = 1) Then
				TProp.Create(gMaxZ,0,TProp.PROP_BANNER_START)
			End If
			If (gSegmentIndex >= SEGMENT_COUNT) Then
				gSegmentIndex = 0
			End If
		End If
	End Function
	
	Method getHorizonYOffset:Float()
		Return(fDistanceInSegment*fDY*5000)
	End Method
	
	Method update(pSpeed:Float)
		If (fTunnel) Then
			If (fLength > 0) Then
				fTunnelPropCounter :- pSpeed
				If (fTunnelPropCounter <= 0) Then
					fTunnelPropCounter = TUNNEL_NEXT_MID_PROP_COUNT
					TProp.Create(gMaxZ,0,TProp.PROP_TUNNEL_MID)
				End If
			End If
		End If
	
		If (fZ > 0) Then
			fZ :- pSpeed
			If (fZ < 0) Then
				fZ = 0
			End If
		Else
			fDistanceInSegment	:+ pSpeed
		End If
		
		fLength :- pSpeed
		
		If (fLength < 10) Then
			If (Not(fCornerSignCreated)) Then
				Local nextDXFraction:Float = getNextSegmentDXFraction()
				If (nextDXFraction > 0.5) Then
					TProp.Create(gMaxZ,-TConstants.ROAD_WIDTH*0.7,TProp.PROP_CORNER_SIGN)
				Else If (nextDXFraction < -0.5) Then
					TProp.Create(gMaxZ,TConstants.ROAD_WIDTH*0.7,TProp.PROP_CORNER_SIGN)
				End If
				fCornerSignCreated = True
			End If
		End If
	End Method
	
	Method getNextSegmentDXFraction:Float()
		Local nextIndex:Int = fIndex+1 
		If (nextIndex >= SEGMENT_COUNT) Then
			nextIndex = 0
		End If
		Return(gSegmentData[nextIndex,0])
	End Method
	
	Method getNextSegmentDYFraction:Float()
		Local nextIndex:Int = fIndex+1 
		If (nextIndex >= SEGMENT_COUNT) Then
			nextIndex = 0
		End If
		Return(gSegmentData[nextIndex,1])
	End Method
End Type

' three data columns:
' DX (left/right), DY (up/down), LENGTH (length of segment)
#track
DefData  0.0 , 0.0 ,100
DefData -0.15,-0.6 , 70 ' down
DefData -0.25, 0.0 ,100
DefData  0.6 , 0.6 , 70 ' back up (should always get back to same level, or horizon will remain at wrong height...)
DefData  0.0 , 0.0 , 20
DefData -0.5 , 0.0 , 40
DefData  1   , 0.0 , 35
DefData -1   , 0.0 , 35
DefData -0.25, 0.0 , 60
DefData  0.5 , 0.0 , 30
DefData -0.25, 0.0 , 60
DefData  0.0 , 0.0 ,100
DefData -1   , 0.0 , 30
DefData  1   , 0.0 , 30
DefData  0.0 , 0.0 , 10
DefData  0.25, 0.0 , 40
DefData  1   , 0.0 ,340
DefData  0.25, 0.0 , 40
DefData  0.0 , 0.0 ,100
DefData  0.0 , 0.0 ,100
DefData  0.0 , 0.0 , 20
DefData -0.25,-0.1 ,120 ' down
DefData  0.25, 0.1 ,120 ' back up
DefData  0.0 , 0.0 ,100
DefData -0.5 , 0.0 , 20
DefData  0.05, 0.0 ,100
DefData  0.0 , 0.0 ,100
DefData  0.25, 0.0 , 40
DefData  1   , 0.0 ,340
DefData  0.0 , 0.0 , 50
DefData -0.7 , 0.0 ,300
DefData -0.25, 0.0 , 50
DefData  0.25, 0.0 , 60
DefData  0.05, 0.0 , 90
DefData -0.05, 0.0 , 70
DefData  0.0 , 0.5 ,100 ' up
DefData  0.0 , 0.0 ,200
DefData  0.0 ,-0.5 ,100 ' back down
DefData  0.0 , 0.0 , 60
DefData  0.0 , 0.0 , 60
