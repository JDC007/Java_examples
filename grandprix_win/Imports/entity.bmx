
' Grand Prix - entity.bmx

SuperStrict

Import "constants.bmx"

Type TEntity
	Global gFirst:TEntity = Null
	Global gLast:TEntity = Null
	
	Global gMinZ:Float
	Global gMaxZ:Float

	Field fActive:Int
	Field fUpdateDepthSort:Int
	Field fZ:Float
	Field fX:Float
	Field fScreenY:Float
	Field fScale:Float
	Field fRoadX:Float
	Field fSegmentDX:Float
	Field fSegmentDY:Float
	Field fOldZ:Float
	Field fWidth:Float
	Field fLength:Float
	Field fPrevious:TEntity = Null
	Field fNext:TEntity = Null
	
	Function updateAll(pScrollSpeed:Float)
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			entity.update(pScrollSpeed)
			entity = entity.fNext
		Wend
	End Function
	
	Function removeInactive()
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			If (Not(entity.fActive)) Then
				Local nextEntity:TEntity = entity.fNext
				entity.removeFromList()
				entity = nextEntity
			Else
				entity = entity.fNext
			End If
		Wend
	End Function
	
	Function removeAll()
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			entity.clear()
			entity = entity.fNext
		Wend
		
		TEntity.gFirst = Null
		TEntity.gLast = Null
	End Function
	
	Function updateDepthSortAll()
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			If (entity.fUpdateDepthSort) Then
				Local nextEntity:TEntity = entity.fNext
				entity.updateDepthSort()
				entity = nextEntity
			Else
				entity = entity.fNext
			End If
		Wend
	End Function
	
	Method New()
		Self.addToListDepthSorted()
	End Method
	
	Method init(pZ:Float,pX:Float,pUpdateDepthSort:Int)
		fZ = pZ
		fX = pX
		fOldZ = fZ
		fUpdateDepthSort = pUpdateDepthSort
		fActive = True
	End Method
	
	Method setSegmentDX(pSegmentDX:Float,pSegmentDXFraction:Float)
		fSegmentDX = pSegmentDX
	End Method
	
	Method setSegmentDY(pSegmentDY:Float)
		fSegmentDY = pSegmentDY
	End Method

	Method addToListDepthSorted()
		If (gFirst = Null) Then
			gFirst = Self
			gLast = Self
		Else
			Local check:TEntity = gLast
			
			While ((check <> Null) And (check.fZ > fZ))
				check = check.fPrevious
			Wend
			
			If (check = Null) Then
				gFirst.fPrevious = Self
				fNext = gFirst
				gFirst = Self
			Else
				If (check.fNext <> Null) Then
					check.fNext.fPrevious = Self
				Else
					gLast = Self
				End If
				fPrevious = check
				fNext = check.fNext
				check.fNext = Self
			End If
		End If
	End Method

	Method update(pScrollSpeed:Float)
		fOldZ = fZ
		fZ :- pScrollSpeed
		If (fZ < gMinZ) Then
			deactivate()
		End If
	End Method
	
	Method deactivate()
		clear()
		
		fActive = False
	End Method
	
	Method clear()
	End Method
	
	Method draw() Abstract
	
	Method drawShadow()
	End Method
		
	Method removeFromList()
		' not first
		If (fPrevious <> Null) Then
			' forward bridge
			fPrevious.fNext = fNext
		' first
		Else
			' next is now new first
			gFirst = fNext
		End If
		
		' not last
		If (fNext <> Null) Then
			' backward bridge
			fNext.fPrevious = fPrevious
		' last
		Else
			' previous is now new last
			gLast = fPrevious
		End If
	End Method
	
	Method updateDepthSort()
		If ((fPrevious <> Null) And (fPrevious.fZ > fZ)) Then
			updateDepthSortDown()
		Else If ((fNext <> Null) And (fNext.fZ < fZ)) Then
			updateDepthSortUp()
		End If
	End Method
	
	Method updateDepthSortDown()
		Local check:TEntity = fPrevious
		removeFromList()
		While ((check <> Null) And (check.fZ > fZ))
			check = check.fPrevious
		Wend
		If (check = Null) Then
			gFirst.fPrevious = Self
			fPrevious = Null
			fNext = gFirst
			gFirst = Self
		Else
			check.fNext.fPrevious = Self
			fNext = check.fNext
			check.fNext = Self
			fPrevious = check
		End If
	End Method
	
	Method updateDepthSortUp()
		Local check:TEntity = fNext
		removeFromList()
		While ((check <> Null) And (check.fZ < fZ))
			check = check.fNext
		Wend
		If (check = Null) Then
			gLast.fNext = Self
			fPrevious = gLast
			fNext = Null
			gLast = Self
		Else
			check.fPrevious.fNext = Self
			fPrevious = check.fPrevious
			check.fPrevious = Self
			fNext = check
		End If
	End Method
	
	Method getSpeed:Float()
		Return(0)
	End Method
	
	Method isHuman:Int()
		Return(False)
	End Method
	
	Method isOil:Int()
		Return(False)
	End Method
	
	Method isCar:Int()
		Return(False)
	End Method

	Method isTunnelStart:Int()
		Return(False)
	End Method

	Method checkCollisions(pLookAhead:Int)
	End Method
	
	Method receiveHit:Float(pSpeed:Float,pZ:Float,pLength:Float)
		Return(pSpeed)
	End Method
	
	Method hittable:Int()
		Return(True)
	End Method
	
	Method setSlope(pSlope:Float)
	End Method
	
	Method setInTunnel(pInTunnel:Int)
	End Method
End Type















