
' Grand Prix - score.bmx

SuperStrict

Type TScore
	Const SCORE_PER_SECOND:Int = 10 ' (score per second remaining after completing lap)
	Const SCORE_100_METERS:Int = 1
	Const SCORE_OVERTAKING:Int = 5

	Global gScore:Int
	Global gHiScore:Int
	Global gNewHiScore:Int
	
	Function reset()
		gScore = 0
		gNewHiScore = False		
	End Function
	
	Function add(pPoints:Int)
		gScore :+ pPoints
		If (gScore > gHiScore) Then
			gHiScore = gScore
			gNewHiScore = True
		End If
	End Function	
End Type

