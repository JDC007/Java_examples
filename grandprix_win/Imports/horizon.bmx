
' Grand Prix - horizon.bmx

SuperStrict

Import "constants.bmx"

Type THorizon
	'Const MAX_DRAW_Y_OFFSET:Float = 50

	Global gGfx1:TImage
	Global gGfx2:TImage
	Global gGfx3:TImage
	
	Field fGfx:TImage
	Field fHorizonDrawOffset:Int
	Field fHorizonDrawX:Float
	Field fHorizonDrawY:Int
	Field fHorizonDrawDX:Float
	Field fHorizonDrawYOffset:Float
	Field fSpeed:Float
	Field fYOffsetFactor:Float
	
	Function loadGraphics()
		gGfx1 = LoadImage("Graphics/horizon1.png",FILTEREDIMAGE)
		gGfx2 = LoadImage("Graphics/horizon2.png",FILTEREDIMAGE)
		gGfx3 = LoadImage("Graphics/horizon3.png",FILTEREDIMAGE)
	End Function
	
	Function Create:THorizon(pGfx:TImage,pSpeed:Float)
		Local horizon:THorizon = New THorizon
		horizon.fGfx = pGfx
		horizon.fSpeed = pSpeed
		horizon.fHorizonDrawOffset = ImageWidth(horizon.fGfx)
		horizon.init()
		Return(horizon)
	End Function
	
	Method init()
		fYOffsetFactor = fSpeed/2500.0
		fHorizonDrawX = 0
		fHorizonDrawY = TConstants.HORIZON_Y-104
		update(0,0,0)
	End Method
	
	Method update(pPlayerSegmentDX:Float,pYOffset:Float,pPlayerSpeed:Float)
		fHorizonDrawDX = (9*fHorizonDrawDX + pPlayerSegmentDX*fSpeed*pPlayerSpeed*2) / 10.0 '3200
		fHorizonDrawX :- fHorizonDrawDX
		If (fHorizonDrawX < 0) Then
			fHorizonDrawX :+ TConstants.SCREEN_WIDTH
		Else If (fHorizonDrawX >= TConstants.SCREEN_WIDTH) Then
			fHorizonDrawX :- TConstants.SCREEN_WIDTH
		End If
		fHorizonDrawYOffset = pYOffset*fYOffsetFactor
	End Method

	Method draw()
		SetColor(255,255,255)
		DrawImage(fGfx,Floor(fHorizonDrawX),Floor(fHorizonDrawY+fHorizonDrawYOffset))
		DrawImage(fGfx,Floor(fHorizonDrawX-fHorizonDrawOffset),Floor(fHorizonDrawY+fHorizonDrawYOffset))
	End Method
End Type















