
' Grand Prix
' Foppygames 2012-2013

SuperStrict

' ##############################################################################
' imports
' ##############################################################################

Import "Imports/aspect.bmx"
Import "Imports/constants.bmx"
Import "Imports/gamemode.bmx"

' ##############################################################################
' ideas
' ##############################################################################

Rem

todo:

...

End Rem

' ====================================================================================================
' setup program
' ====================================================================================================

AppTitle = "Grand Prix"

TGameMode.resetGraphics()

SeedRnd(MilliSecs())

' ====================================================================================================
' globals
' ====================================================================================================

Global gFpsCountTargetTime:Int = MilliSecs() + 1000
Global gRenderFrames:Int = 0
Global gRenderFPS:Int = 0
Global gLogicFrames:Int = 0
Global gLogicFPS:Int = 0
Global gLastTime:Int = MilliSecs()/5
Global gNumTicks:Int
Global gTempMS:Int
Global gLastNumTicks:Int = 1
Global gContinue:Int

'===================================================================================================
' main loop
'===================================================================================================

gContinue = True

TGameMode.init()

While (gContinue)
	' logic frame speed control
	Repeat 
		gTempMS = MilliSecs()/5
		If (gTempMS < gLastTime) Then 
			gLastTime = gTempMS - gLastNumTicks
		End If
		gNumTicks = gTempMS - gLastTime 
	Until gNumTicks > 0 
	gLastTime = gTempMS 
	If (gNumTicks > 20) Then
		gNumTicks = gLastNumTicks
	End If
	gLastNumTicks = gNumTicks

	' logic
	For Local i:Int = 1 To gNumTicks	
		gContinue = TGameMode.update()
		If (Not(gContinue)) Then
			i = gNumTicks
		End If
		gLogicFrames :+ 1
	Next
		
	' drawing
	TGameMode.draw()
Wend

EndGraphics


