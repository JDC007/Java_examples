
' Grand Prix - gamemode.bmx

SuperStrict

Import "aspect.bmx"
Import "constants.bmx"
Import "segment.bmx"
Import "car.bmx"
Import "prop.bmx"
Import "cloud.bmx"
Import "horizon.bmx"
Import "score.bmx"

Type TGameMode
	Const STATE_TITLE:Int = 0
	Const STATE_START:Int = 1
	Const STATE_ACTION:Int = 2
	Const STATE_GAME_OVER:Int = 3
	
	Const START_COUNT_DOWN:Int = 300
	Const START_COUNT_DOWN_REPEATS:Int = 4
	Const CHECKPOINT_TIME_FIRST_LAP:Int = 90
	Const CHECKPOINT_TIME_BONUS_1:Int = 80
	Const CHECKPOINT_TIME_BONUS_2:Int = 70
	Const CHECKPOINT_TIME_BONUS_3:Int = 60
	Const NEW_PLAYER_CAR_TIME:Int = 3
	Const GAME_OVER_FADE_SPEED:Float = 0.005
	Const CLOUD_COUNT:Int = 10
	Const BUSH_COUNT_AT_START:Int = 20
	Const MIN_ENEMY_TIME:Int = 20
	Const MAX_ENEMY_TIME:Int = 140
	Const MAX_ENEMY_COUNT:Int = 5
	
	Const LAP_COUNT_BRONZE:Int = 6
	Const LAP_COUNT_SILVER:Int = 7
	Const LAP_COUNT_GOLD:Int = 8

	Const TROPHY_NONE:Int = -1
	Const TROPHY_BRONZE:Int = 0
	Const TROPHY_SILVER:Int = 1
	Const TROPHY_GOLD:Int = 2
	
	Global gGfxRoad:TImage
	Global gGfxTrophies:TImage
	Global gGfxSelectCar:TImage
	Global gGfxSelectCarRect:TImage

	Global gFont32:TImageFont
	Global gFont64:TImageFont

	Global gSndTitleMusic:TSound
	Global gSndRaceMusic:TSound
	Global gSndLap:TSound
	Global gSndStart1:TSound
	Global gSndStart2:TSound
		
	Global gChnMusic:TChannel
	
	Global gState:Int
	Global gZMap:Float[]
	Global gScale:Float[]
	Global gPlayer:TCar = Null
	Global gPlayerX:Float
	Global gPlayerSegmentDX:Float
	Global gPlayerSpeed:Float
	Global gEnemyTimer:Float = MAX_ENEMY_TIME
	Global gEnemyLane:Int = -1
	Global gBushTimer:Float = 0
	Global gHorizon1:THorizon
	Global gHorizon2:THorizon
	Global gHorizon3:THorizon
	Global gHorizonYOffset:Float
	Global gTextureOffset:Float = 0
	Global gStartCountDown:Int
	Global gStartCountDownRepeats:Int
	Global gGameOverAlpha:Float
	Global gCheckpointTimer:Int
	Global gNewPlayerCarTimer:Int
	Global gTime:Int
	Global gLaps:Int
	Global gPlayerDistance:Float
	Global gWindowed:Int = True
	Global gTrophy:Int
	Global gMusicEnabled:Int = True
	Global gSelectedMusic:TSound
	Global gPlayerCarColor:Int = TCar.PLAYER_CAR_COLOR_RED
	
	Function init()
		HideMouse()
		
		initZMapAndScaling()

		TEntity.gMinZ = gZMap[0]
		TEntity.gMaxZ = gZMap[TConstants.HORIZON_HEIGHT-1]
		TCar.gEnemyMinZ = TEntity.gMinZ-TEntity.gMaxZ/3.0
		TSegment.gMinZ = gZMap[0]
		TSegment.gMaxZ = gZMap[TConstants.HORIZON_HEIGHT-1]

		gSndTitleMusic = LoadSound("Music/nfo.ogg",SOUND_LOOP)
		gSndRaceMusic = LoadSound("Music/mutant.ogg",SOUND_LOOP)
		gSndLap = LoadSound("Sounds/lap.wav")
		gSndStart1 = LoadSound("Sounds/start1.wav")
		gSndStart2 = LoadSound("Sounds/start2.wav")

		gChnMusic = AllocChannel()
		gChnMusic.SetVolume(TConstants.SOUND_VOLUME*TConstants.MUSIC_VOLUME_MODIFIER)	
		
		TScore.gHiScore = 0

		switchToState(STATE_TITLE)
	End Function
	
	Function resetGraphics()
		If (gWindowed) Then
			Graphics(TConstants.SCREEN_WIDTH,TConstants.SCREEN_HEIGHT,0)
			SetAspectResolution(TConstants.SCREEN_WIDTH,TConstants.SCREEN_HEIGHT,ASPECT_LETTERBOX_BORDER)
		Else
			Graphics(DesktopWidth(),DesktopHeight(),32)
			SetAspectResolution(TConstants.SCREEN_WIDTH,TConstants.SCREEN_HEIGHT,ASPECT_LETTERBOX_BORDER)
		End If
		SetClsColor(0,0,0)
		SetAspectColor(64,64,64)
		loadGraphics()
	End Function
	
	Function loadGraphics()
		gFont32 = LoadImageFont("Fonts/Retroville_NC.ttf",20)
		gFont64 = LoadImageFont("Fonts/Retroville_NC.ttf",60)

		gGfxRoad = LoadAnimImage("Graphics/road.png",800,1,0,2,0)
		gGfxTrophies = LoadAnimImage("Graphics/trophies.png",18,24,0,3)
		gGfxSelectCar = LoadAnimImage("Graphics/select_car.png",100,41,0,4)
		gGfxSelectCarRect = LoadImage("Graphics/select_car_rect.png")

		SetImageHandle(gGfxRoad,ImageWidth(gGfxRoad)/2,0)

		THorizon.loadGraphics()
		TProp.loadGraphics()
		TProp.loadSounds()

		TCloud.loadGraphics()
		TCar.loadGraphics()
		TCar.loadSounds()
	End Function
	
	Function initZMapAndScaling()
		gZMap = New Float[TConstants.HORIZON_HEIGHT]
		gScale = New Float[TConstants.HORIZON_HEIGHT]
	
		For Local i:Int = 0 To TConstants.HORIZON_HEIGHT-1
			gZMap[i] = -1.0 / Float(i - (TConstants.HORIZON_HEIGHT*1.05)) * 1000
			gScale[i] = 1.0 / (-1.0 / Float(i - (TConstants.HORIZON_HEIGHT*1.05)))
		Next

		' normalize scaling so that scale 1.0 is used at y = 84
		Local correct:Float = 1.0 / gScale[84]
		For Local i:Int = 0 To TConstants.HORIZON_HEIGHT-1
			gScale[i] :* correct
		Next
	End Function
	
	Function playMusic(pMusic:TSound,pChannel:TChannel)
		gSelectedMusic = pMusic
		If (gMusicEnabled) Then
			PlaySound(pMusic,pChannel)
		End If
	End Function
	
	Function stopMusic()
		If (ChannelPlaying(gChnMusic)) Then
			StopChannel(gChnMusic)
			gSelectedMusic = Null
		End If
	End Function

	Function toggleMusic()
		gMusicEnabled = Not(gMusicEnabled)
		If (gMusicEnabled) Then
			PlaySound(gSelectedMusic,gChnMusic)
		Else
			StopChannel(gChnMusic)
		End If
	End Function

	Function switchToState(pState:Int)
		If (pState <> STATE_ACTION) Then
			FlushKeys()
		End If
		
		stopMusic()
		
		Select (pState)
			Case STATE_TITLE
				removeAllGameObjects()
				
				SetClsColor(0,0,0)
				playMusic(gSndTitleMusic,gChnMusic)
						
			Case STATE_START
				SetClsColor(34,141,203)
				
				TSegment.init(TCar.GRID_START_Z,TCar.GRID_STEP_Z)
				
				gPlayer = TCar.createStartingGrid(gPlayerCarColor)
				
				gPlayerX = gPlayer.fX
				gPlayerSegmentDX = gPlayer.fSegmentDX
				gPlayerSpeed = gPlayer.fSpeed

				createClouds()
				createBushes()
				
				gHorizonYOffset = 0
				
				createHorizons()
				
				gStartCountDown = START_COUNT_DOWN*2
				gStartCountDownRepeats = START_COUNT_DOWN_REPEATS
				gCheckpointTimer = CHECKPOINT_TIME_FIRST_LAP
				gNewPlayerCarTimer = 0
				gLaps = 0
				TScore.reset()
				gTrophy = TROPHY_NONE
			
			Case STATE_ACTION
				gTime = MilliSecs()
				playMusic(gSndRaceMusic,gChnMusic)
	
			Case STATE_GAME_OVER
				TCar.removeAll()
				
				gGameOverAlpha = 0
		End Select
		
		gState = pState
	End Function
	
	Function createClouds()
		For Local i:Int = 1 To CLOUD_COUNT
			TCloud.Create()
		Next
	End Function
	
	Function createBushes()
		For Local i:Int = 0 To BUSH_COUNT_AT_START
			If (Rand(1,2) = 1) Then
				TProp.Create(Rnd(TEntity.gMinZ,TEntity.gMaxZ),-(Rnd(TConstants.ROAD_WIDTH*0.55,TConstants.ROAD_WIDTH*3)),TProp.PROP_BUSH_1)
			Else
				TProp.Create(Rnd(TEntity.gMinZ,TEntity.gMaxZ),Rnd(TConstants.ROAD_WIDTH*0.55,TConstants.ROAD_WIDTH*3),TProp.PROP_BUSH_1)
			End If	
		Next
	End Function
	
	Function createHorizons()
		gHorizon1 = THorizon.Create(THorizon.gGfx1,2800)
		gHorizon2 = THorizon.Create(THorizon.gGfx2,3300)
		gHorizon3 = THorizon.Create(THorizon.gGfx3,3800)
	End Function
	
	Function removeAllGameObjects()
		TEntity.removeAll()
		TCloud.removeAll()
		TSegment.removeAll()
		removeHorizons()
		TCar.gEnemyCount = 0
	End Function
	
	Function removeHorizons()
		gHorizon1 = Null
		gHorizon2 = Null
		gHorizon3 = Null
	End Function
	
	Function update:Int()
		Local myContinue:Int = True
		
		' toggle music
		If (KeyHit(KEY_M)) Then
			toggleMusic()
		End If

		If (gState = STATE_START) Then
			gHorizonYOffset = TSegment.gHorizonYOffset+TSegment.gFirstSegment.getHorizonYOffset()
			
			TEntity.updateDepthSortAll()
			TCloud.updateAll(gPlayerX,gPlayerSegmentDX,gHorizonYOffset)
			updateHorizons(0)
			
			gStartCountDown :- 1
			If (gStartCountDown <= 0) Then
				gStartCountDownRepeats :- 1
				
				If (TProp.gBannerStart <> Null) Then
					Local chnStart:TChannel
				
					Select (gStartCountDownRepeats)
						Case 3
							TProp.gBannerStart.fGfx = TProp.gGfxBannerStart1
							chnStart = PlaySound(gSndStart1)
						Case 2
							TProp.gBannerStart.fGfx = TProp.gGfxBannerStart2
							chnStart = PlaySound(gSndStart1)
						Case 1
							TProp.gBannerStart.fGfx = TProp.gGfxBannerStart3	
							chnStart = PlaySound(gSndStart2)
					End Select
					chnStart.SetVolume(TConstants.SOUND_VOLUME)
				End If
				
				If (gStartCountDownRepeats <= 1) Then
					switchToState(STATE_ACTION)
				End If
				
				gStartCountDown = START_COUNT_DOWN
			End If
		End If

		If (gState = STATE_ACTION) Then
			If (gPlayer <> Null) Then
				gPlayerX = gPlayer.fX
				gPlayerSegmentDX = gPlayer.fSegmentDX
				gPlayerSpeed = gPlayer.fSpeed
				
				gPlayerDistance :+ gPlayerSpeed
				If (gPlayerDistance > 100) Then
					TScore.add(TScore.SCORE_100_METERS)
					gPlayerDistance :- 100
				End If
				
				If (Not(gPlayer.fActive)) Then
					gPlayer = Null
				End If
			Else
				gPlayerSpeed = 0
			
				If (gNewPlayerCarTimer = 0) Then
					gNewPlayerCarTimer = NEW_PLAYER_CAR_TIME
				End If	
			End If
			
			TEntity.removeInactive()
			
			updateBushTimer(gPlayerSpeed)
		
			TEntity.updateAll(gPlayerSpeed)
			TEntity.updateDepthSortAll()
			updateTextureOffset(gPlayerSpeed)
			TSegment.updateAll(gPlayerSpeed)
			TCloud.updateAll(gPlayerSpeed,gPlayerSegmentDX,gHorizonYOffset)
	
			If (gPlayer <> Null) Then
				If (TSegment.checkLap()) Then
					gLaps :+ 1
					
					Local chnLap:TChannel = PlaySound(gSndLap)
					chnLap.SetVolume(TConstants.SOUND_VOLUME)

					TScore.add(TScore.SCORE_PER_SECOND*gCheckpointTimer)
					
					' add time to checkpoint timer
					Select gLaps
						Case 1
							gCheckpointTimer :+ CHECKPOINT_TIME_BONUS_1
						Case 2
							gCheckpointTimer :+ CHECKPOINT_TIME_BONUS_2
						Default
							gCheckpointTimer :+ CHECKPOINT_TIME_BONUS_3
					End Select
					
					' get trophy
					Select gLaps
						Case LAP_COUNT_BRONZE
							gTrophy = TROPHY_BRONZE
						Case LAP_COUNT_SILVER
							gTrophy = TROPHY_SILVER
						Case LAP_COUNT_GOLD
							gTrophy = TROPHY_GOLD
					End Select
				End If
			End If
	
			TSegment.checkNext()
					
			updateEnemyTimer(gPlayerSpeed)
			updateHorizons(gPlayerSpeed)
			
			gHorizonYOffset = TSegment.gHorizonYOffset+TSegment.gFirstSegment.getHorizonYOffset()
			
			' update clouds
			If (gPlayer <> Null) Then
				TCloud.gHorizontalSpeed = gPlayer.fSegmentDX*gPlayerSpeed
				TCloud.gHorizonYOffset = gHorizonYOffset
			Else
				TCloud.gHorizontalSpeed = 0
			End If
			
			' update timers
			Local newTime:Int = MilliSecs()
			If ((newTime - gTime) >= 1000) Then
				If (gNewPlayerCarTimer > 0) Then
					gNewPlayerCarTimer :- 1
					If (gNewPlayerCarTimer <= 0) Then
						gNewPlayerCarTimer = 0
						If (gPlayer = Null) Then
							gPlayer = TCar.Create(TCar.PLAYER_Z,0,True,gPlayerCarColor)
						End If
					End If
				End If
				
				gCheckpointTimer :- 1
				If (gCheckpointTimer <= 0) Then
					gCheckpointTimer = 0
					switchToState(STATE_GAME_OVER)
				End If
				gTime :+ 1000
			End If
		End If

		' back to title screen from game
		If ((gState = STATE_ACTION) Or (gState = STATE_START)) Then
			If (KeyHit(KEY_ESCAPE)) Then
				switchToState(STATE_TITLE)
			End If
		End If
		
		If (gState = STATE_GAME_OVER) Then
			If (gGameOverAlpha < 1) Then
				gGameOverAlpha :+ GAME_OVER_FADE_SPEED
				If (gGameOverAlpha > 1) Then
					gGameOverAlpha = 1
				End If
			End If
			
			' to title screen from game over
			If (KeyHit(KEY_ESCAPE) Or KeyHit(KEY_SPACE) Or KeyHit(KEY_UP)) Then
				switchToState(STATE_TITLE)
			End If
		End If

		If (gState = STATE_TITLE) Then
			' starting game or quitting from title screen
			If (KeyHit(KEY_SPACE) Or KeyHit(KEY_UP) Or KeyHit(KEY_A)) Then
				switchToState(STATE_START)
			Else If (KeyHit(KEY_ESCAPE)) Then
				ShowMouse()
				myContinue = False
			End If
			
			' toggle full screen/windowed
			If (KeyHit(KEY_W)) Then
				gWindowed = Not(gWindowed)
				resetGraphics()
			End If
			
			' select car
			If (KeyHit(KEY_LEFT) Or KeyHit(KEY_COMMA)) Then
				gPlayerCarColor :- 1
				If (gPlayerCarColor < 0) Then
					gPlayerCarColor = 3
				End If
			Else If (KeyHit(KEY_RIGHT) Or KeyHit(KEY_PERIOD)) Then
				gPlayerCarColor :+ 1
				If (gPlayerCarColor > 3) Then
					gPlayerCarColor = 0
				End If
			End If
		End If
		
		' quitting by clicking on x
		If (AppTerminate()) Then
			ShowMouse()
			myContinue = False
		End If
		
		Return(myContinue)
	End Function
	
	Function updateBushTimer(pSpeed:Float)
		' bushes
		gBushTimer :- pSpeed
		If (gBushTimer <= 0) Then
			' assuming lastsegment is never null when this is checked
			If (Not(TSegment.gLastSegment.fTunnel)) Then
				If (Rand(1,2) = 1) Then
					TProp.Create(gZMap[TConstants.HORIZON_HEIGHT-1],-(Rnd(TConstants.ROAD_WIDTH*0.55,TConstants.ROAD_WIDTH*3)),TProp.PROP_BUSH_1)
				Else
					TProp.Create(gZMap[TConstants.HORIZON_HEIGHT-1],Rnd(TConstants.ROAD_WIDTH*0.55,TConstants.ROAD_WIDTH*3),TProp.PROP_BUSH_1)
				End If
			End If	
			gBushTimer :+ Rand(gZMap[TConstants.HORIZON_HEIGHT-1]/30,gZMap[TConstants.HORIZON_HEIGHT-1]/15)
		End If
	End Function
	
	Function updateEnemyTimer(pSpeed:Float)
		gEnemyTimer :- pSpeed
		If (gEnemyTimer <= 0) Then
			If (TCar.gEnemyCount < MAX_ENEMY_COUNT) Then
				TCar.Create(gZMap[TConstants.HORIZON_HEIGHT-1],gEnemyLane*Rand(TConstants.ROAD_WIDTH*0.1,TConstants.ROAD_WIDTH*0.4),False)
			End If
			gEnemyTimer = Rand(MIN_ENEMY_TIME,MAX_ENEMY_TIME)
			If (Rnd(1,10) < 9) Then
				gEnemyLane :* -1
			End If
		End If
	End Function

	Function updateTextureOffset(pSpeed:Float)
		gTextureOffset :+ pSpeed
		If (gTextureOffset > 4) Then
			gTextureOffset :- 4
		End If
	End Function
	
	Function updateHorizons(pSpeed:Float)
		If (gPlayer <> Null) Then
			gHorizon1.update(gPlayer.fSegmentDX,gHorizonYOffset,pSpeed)
			gHorizon2.update(gPlayer.fSegmentDX,gHorizonYOffset,pSpeed)
			gHorizon3.update(gPlayer.fSegmentDX,gHorizonYOffset,pSpeed)
		End If
	End Function

	Function draw()
		Cls
		
		If (gState = STATE_TITLE) Then
			Rem
			SetColor(255,255,255)
			SetAlpha(0.2)
			DrawLine(TConstants.SCREEN_WIDTH/2,0,TConstants.SCREEN_WIDTH/2,TConstants.SCREEN_HEIGHT)
			DrawLine(TConstants.SCREEN_WIDTH/4,0,TConstants.SCREEN_WIDTH/4,TConstants.SCREEN_HEIGHT)
			DrawLine(TConstants.SCREEN_WIDTH*0.75,0,TConstants.SCREEN_WIDTH*0.75,TConstants.SCREEN_HEIGHT)
			End Rem
			
			SetScale(1,1)
			SetAlpha(1)
			SetBlend(ALPHABLEND)
			
			SetImageFont(gFont64)
			SetColor(255,255,255)
			DrawText("GRAND PRIX",155,40)
			
			SetImageFont(gFont32)
			SetColor(255,255,255)
			DrawText("code & gfx: robbert prins",225,130)
			DrawText("music: coda (coda.s3m.us)",225,170)
			
			SetColor(255,255,255)
			DrawText(LAP_COUNT_BRONZE+" laps = bronze",80,235)
			DrawText(LAP_COUNT_SILVER+" laps = silver",80,275)
			DrawText(LAP_COUNT_GOLD+  " laps = gold",80,315)
			
			DrawImage(gGfxTrophies,310,235,TROPHY_BRONZE)
			DrawImage(gGfxTrophies,310,275,TROPHY_SILVER)
			DrawImage(gGfxTrophies,310,315,TROPHY_GOLD)
			
			SetColor(155,155,255)
			DrawText("controls: arrow keys",400,235)
			DrawText("w = full screen / windowed",400,275)
			DrawText("m = music on / off",400,315)
			
			SetColor(255,255,0)
			DrawText("press left-right to select car",190,365)
			DrawText("press space or up-arrow to start",170,TConstants.SCREEN_HEIGHT-110)
			
			SetColor(255,255,255)
			
			For Local i:Int=0 To 3
				DrawImage(gGfxSelectCar,160+i*125,420,i)
				If (gPlayerCarColor = i) Then
					DrawImage(gGfxSelectCarRect,155+i*125,415)
				End If
			Next
			
			DrawText("FOPPYGAMES 2013",270,TConstants.SCREEN_HEIGHT-50)
		End If
		
		If ((gState = STATE_ACTION) Or (gState = STATE_START) Or (gState = STATE_GAME_OVER)) Then
			drawHorizons()
			
			TCloud.drawAll()
		
			' initial vertical position of drawing of road
			Local screenY:Float = TConstants.SCREEN_HEIGHT
			Local previousY:Float = TConstants.SCREEN_HEIGHT+1
			Local smallestScreenY:Float = screenY+1
			
			' initial horizontal position of drawing of road
			Local screenX:Float = TConstants.SCREEN_WIDTH/2 - gPlayerX*gScale[1]
			
			' correction to always make road point to horizontal center of horizon
			Local perspectiveDX:Float = (TConstants.SCREEN_WIDTH/2-screenX)/TConstants.HORIZON_HEIGHT
			
			Local segment:TSegment = TSegment.gFirstSegment
			Local nextEntity:TEntity = TEntity.gFirst
			
			' for turns
			Local dDX:Float = 0
			
			' for hills
			Local dDY:Float = 0
			
			Local roadFloats:Float[,]
			roadFloats = New Float[TConstants.HORIZON_HEIGHT,4] ' 0=z, 1=screenX, 2=screenY, 3=slope
			
			Local roadInts:Int[,]
			roadInts = New Int[TConstants.HORIZON_HEIGHT,6]     ' 0=draw, 1=screenY, 2=offsetY, 3=grassColor, 4=roadFrame, 5=tunnel
			
			For Local i:Int = 0 To TConstants.HORIZON_HEIGHT-1
				Local z:Float = gZMap[i]
				
				' store z
				roadFloats[i,0] = z
				
				If (segment.fNext <> Null) Then
					If (z > segment.fNext.fZ) Then
						segment = segment.fNext
					End If
				End If
				
				While ((nextEntity <> Null) And (z > nextEntity.fZ))
					nextEntity.fScreenY = screenY
					nextEntity.fRoadX = screenX
					nextEntity.fScale = gScale[i]
					nextEntity.setSegmentDX(segment.fDX,segment.fDXFraction)
					nextEntity.setSegmentDY(segment.fDY)
					nextEntity = nextEntity.fNext
				Wend
				
				If (screenY < smallestScreenY) Then
					' draw: yes
					roadInts[i,0] = 1
				
					' store screenY
					roadInts[i,1] = Int(screenY)
				
					' store screenX
					roadFloats[i,1] = screenX
				
					' store scaleX
					roadFloats[i,2] = gScale[i]
				
					' store slope
					roadFloats[i,3] = dDY
		
					Local offsetY:Int = 1
					If (Int(screenY) < (Int(previousY)-1))
						offsetY = Int(previousY)-Int(screenY)
					End If
					
					' store offsetY
					roadInts[i,2] = offsetY
					
					Local grassColor:Int = 100
					Local roadFrame:Int = 1
					
					If (((z + gTextureOffset) Mod 4) > 2) Then
						grassColor = 110
						roadFrame = 0
					End If
					
					' store grassColor and roadFrame
					roadInts[i,3] = grassColor
					roadInts[i,4] = roadFrame
					
					' in tunnel, color grass black
					If (segment.fTunnel) Then
						roadInts[i,3] = 0
					End If
					
					' tunnel?
					roadInts[i,5] = segment.fTunnel
				Else
					' draw: no
					roadInts[i,0] = 0
				End If
				
				previousY = screenY
				
				If (screenY < smallestScreenY) Then
					smallestScreenY = screenY
				End If
					
				dDY :+ segment.fDY * gZMap[i] * (gZMap[i]/5.0) * (gScale[0]-gScale[i])
				
				screenY :- 1+dDY
				
				dDX :+ segment.fDX * gZMap[i] * (gZMap[i]/10.0) * ((gScale[0]-gScale[i])*1.2)
				
				screenX :+ dDX
				screenX :+ perspectiveDX
			Next
			
			' draw black at end of tunnel if end prop not yet in view
			If (TSegment.gLastSegment.fTunnel) Then
				SetScale(1,1)
				SetColor(0,0,0)
				Local height:Float = TProp.TUNNEL_OPENING_HEIGHT * gScale[TConstants.HORIZON_HEIGHT-1]
				DrawRect(0,TConstants.HORIZON_Y+gHorizonYOffset-height-5,TConstants.SCREEN_WIDTH,height+10)
			End If
			
			' draw road from back to front
			Local entity:TEntity = TEntity.gLast
			For Local i:Int = TConstants.HORIZON_HEIGHT-1 To 0 Step -1
				While ((entity <> Null) And (entity.fZ > roadFloats[i,0]))
					If (entity.fZ >= gZMap[0]) Then
						entity.setSlope(roadFloats[i,3])
						entity.setInTunnel(roadInts[i,5])
						entity.drawShadow()
						entity.draw()
					End If
					entity = entity.fPrevious
				Wend
				
				If (roadInts[i,0]) Then
					
					SetScale(1,1)
					SetColor(0,roadInts[i,3],0)
					
					DrawRect(0,roadInts[i,1],TConstants.SCREEN_WIDTH,roadInts[i,2])
						
					SetScale(roadFloats[i,2],1)
					If (roadInts[i,5]) Then
						SetColor(70,80,100)
					Else
						SetColor(255,255,255)
					End If
						
					For Local j:Int=1 To roadInts[i,2]
						DrawImage(gGfxRoad,roadFloats[i,1],roadInts[i,1]+(j-1),roadInts[i,4])
					Next
				End If
			Next
		End If
		
		If ((gState = STATE_ACTION) Or (gState = STATE_START)) Then
			drawHUD()
		End If
		
		If (gState = STATE_GAME_OVER) Then
			SetScale(1,1)
			SetAlpha(gGameOverAlpha)
			SetBlend(ALPHABLEND)
			SetColor(0,0,0)
			
			DrawRect(0,0,TConstants.SCREEN_WIDTH,TConstants.SCREEN_HEIGHT)
			
			SetAlpha(1)
			
			drawHUD()
			
			SetAlpha(gGameOverAlpha)
			
			SetImageFont(gFont64)
			SetColor(255,255,255)
			
			' game completed
			If (gTrophy = TROPHY_GOLD) Then
				DrawText("GAME COMPLETED",55,TConstants.SCREEN_HEIGHT*0.3)
			' game not completed
			Else
				DrawText("GAME OVER",185,TConstants.SCREEN_HEIGHT*0.3)
			End If
			
			SetImageFont(gFont32)
			
			' trophy won
			If (gTrophy <> TROPHY_NONE) Then
				' display congratulations
				Local name:String = ""
				Select gTrophy
					Case TROPHY_BRONZE
						name = "bronze"
					Case TROPHY_SILVER
						name = "silver"
					Case TROPHY_GOLD
						name = "gold"
				End Select
				DrawImage(gGfxTrophies,TConstants.SCREEN_WIDTH/2-ImageWidth(gGfxTrophies)/2,TConstants.SCREEN_HEIGHT*0.5,gTrophy)
				DrawText("congratulations, you won the "+name+" cup!",130,TConstants.SCREEN_HEIGHT*0.6)
			End If
			
			SetAlpha(1)
		End If
		
		' hack to solve problem with left and right 1-pixel columns not clipped in full screen mode
		If (Not(gWindowed)) Then
			SetColor(0,0,0)
			DrawRect(-1,0,1,TConstants.SCREEN_HEIGHT)
		End If
	
		Flip
	End Function
	
	Function drawHUD()
		SetScale(1,1)
		SetColor(255,255,255)
		SetImageFont(gFont32)
		SetBlend(ALPHABLEND)
	
		DrawText("SCORE",550-(5*14)/2,20)
		DrawText(TScore.gScore,550-(Len(String(TScore.gScore))*14)/2,50)
		
		DrawText("HI-SCORE",230-(8*14)/2,20)
		DrawText(TScore.gHiScore,230-(Len(String(TScore.gHiScore))*14)/2,50)

		' trophy
		If (gTrophy <> TROPHY_NONE) Then
			DrawImage(gGfxTrophies,72,85,gTrophy)
		End If
		
		SetColor(120,230,255)
		DrawText("LAPS",80-(4*14)/2,20)
		DrawText(gLaps,80-(Len(String(gLaps))*14)/2,50)
		
		Local speed:String
		If (gPlayer <> Null) Then
		 	speed = String(Int((gPlayer.fSpeed/TCar.TOP_SPEED)*350))
		Else
			speed = "0"
		End If
		DrawText("SPEED",TConstants.SCREEN_WIDTH-90-(5*14)/2,20)
		DrawText(speed,TConstants.SCREEN_WIDTH-110-(Len(speed)*14),50)
		DrawText(" km/h",TConstants.SCREEN_WIDTH-90,50)
		
		SetColor(255,255,0)
		DrawText("TIME",TConstants.SCREEN_WIDTH/2-(4*14)/2,20)
		If (gCheckPointTimer > 10) Then
			DrawText(gCheckpointTimer,TConstants.SCREEN_WIDTH/2-(Len(String(gCheckpointTimer))*14)/2,50)
		Else
			SetImageFont(gFont64)
			DrawText(gCheckpointTimer,TConstants.SCREEN_WIDTH/2-(Len(String(gCheckpointTimer))*42)/2,40)
		End If
	End Function
	
	Function drawHorizons()
		gHorizon1.draw()
		gHorizon2.draw()
		gHorizon3.draw()
	End Function
End Type

