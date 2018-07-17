
' Grand Prix - cloud.bmx

SuperStrict

Import "constants.bmx"
Import "entity.bmx"

Type TCloud
	Global gGfxCloud1:TImage
	
	Global gFirst:TCloud = Null
	Global gLast:TCloud = Null
	Global gHorizontalSpeed:Float
	Global gHorizonYOffset:Float

	Field fZ:Float
	Field fX:Float
	Field fScale:Float
	Field fGfx:TImage
	Field fHeight:Int
	Field fSpeed:Float
	Field fAlpha:Float
	Field fPrevious:TCloud = Null
	Field fNext:TCloud = Null

	Function Create:TCloud()
		Local cloud:TCloud = New TCloud
		
		cloud.fX = Rnd(-TConstants.SCREEN_WIDTH,2*TConstants.SCREEN_WIDTH)
		cloud.fZ = Rnd(TEntity.gMaxZ*0.60,TEntity.gMaxZ*0.9)
		cloud.fGfx = gGfxCloud1
		cloud.fHeight = (1-(cloud.fZ-TEntity.gMinZ)/(TEntity.gMaxZ-TEntity.gMinZ))*TConstants.SCREEN_HEIGHT*0.5
		cloud.fScale = 1-(cloud.fZ-TEntity.gMinZ)/(TEntity.gMaxZ-TEntity.gMinZ)
		cloud.fSpeed = 5000 + (TEntity.gMaxZ-cloud.fZ)*60 '4000 310
		cloud.fAlpha = 1
		If (cloud.fZ > TEntity.gMaxZ*0.7) Then
			cloud.fAlpha = 1-(cloud.fZ-TEntity.gMaxZ*0.7)/(TEntity.gMaxZ*0.3)
			If (cloud.fAlpha < 0.5) Then
				cloud.fAlpha = 0.5
			End If
		End If
		
		cloud.addToListDepthSorted()
		
		Return(cloud)
	End Function
	
	Function loadGraphics()
		gGfxCloud1 = LoadImage("Graphics/cloud1.png")
		
		SetImageHandle(gGfxCloud1,ImageWidth(gGfxCloud1)/2,ImageHeight(gGfxCloud1))
	End Function
	
	Function updateAll(pPlayerSpeed:Float,pPlayerSegmentDX:Float,pHorizonYOffset:Float)
	
		gHorizontalSpeed = pPlayerSegmentDX*pPlayerSpeed
		gHorizonYOffset = pHorizonYOffset
			
		Local cloud:TCloud = TCloud.gFirst
		While (cloud <> Null)
			cloud.update()
			cloud = cloud.fNext
		Wend
	End Function

	Function drawAll()
		Local cloud:TCloud = TCloud.gLast
		While (cloud <> Null)
			cloud.draw()
			cloud = cloud.fPrevious
		Wend
	End Function
	
	Function removeAll()
		TCloud.gFirst = Null
		TCloud.gLast = Null
	End Function
	
	Method addToListDepthSorted()
		If (gFirst = Null) Then
			gFirst = Self
			gLast = Self
		Else
			Local check:TCloud = gLast
			
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

	Method update()
		fX :- gHorizontalSpeed*fSpeed
		
		If (fX < -TConstants.SCREEN_WIDTH) Then
			fX = TConstants.SCREEN_WIDTH*2
		End If
		
		If (fX > TConstants.SCREEN_WIDTH*2) Then
			fX = -TConstants.SCREEN_WIDTH
		End If
	End Method
	
	Method draw()
		SetBlend(ALPHABLEND)
		SetScale(fScale,fScale)
		SetColor(255,255,255)
		SetAlpha(fAlpha)
		DrawImage(fGfx,fX,TConstants.HORIZON_Y-fHeight+gHorizonYOffset)
		SetAlpha(1)
		SetBlend(MASKBLEND)
	End Method
	
	Method hittable:Int()
		Return(False)
	End Method
End Type















