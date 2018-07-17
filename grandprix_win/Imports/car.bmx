
' Grand Prix - car.bmx

SuperStrict

Import "entity.bmx"
Import "prop.bmx"
Import "score.bmx"

Type TCar Extends TEntity
	Const TOP_SPEED:Float = 0.325
	Const STEER_CHANGE:Float = 0.0958
	Const AI_STEER_CHANGE:Float = 0.07
	Const STEER_RETURN_FACTOR:Float = 0.9935
	Const MAX_STEER:Float = 10.0
	Const BRAKE:Float = 0.0006
	Const IDLE_BRAKE:Float = 0.00004
	Const GEARS:Int = 5
	Const PLAYER_Z:Int = 5
	Const MIN_FRONT_WHEEL_OFFSET_Y:Float = 10
	Const MAX_FRONT_WHEEL_OFFSET_Y:Float = 30
	Const SLOPE_TO_FRONT_WHEEL_DY_FACTOR:Int = 80
	Const MAX_FRONT_WHEEL_DY_FACTOR:Int = 5
	Const AI_MAX_SPEED_DECREASE:Float = TOP_SPEED*0.12
	Const TARGET_X_MARGIN:Int = 50
	Const CAR_WIDTH:Int = 180
	Const CAR_LENGTH:Float = 0.8
	Const MAX_DISTANCE_FROM_CENTER:Int = TConstants.ROAD_WIDTH*2
	Const SIDE_BUMP_MIN_DISTANCE:Int = TConstants.ROAD_WIDTH*0.35
	Const SIDE_BUMP_MAX_DISTANCE:Int = SIDE_BUMP_MIN_DISTANCE+TConstants.ROAD_WIDTH*0.1
	Const OFFROAD_BUMP_MIN_DISTANCE:Int = SIDE_BUMP_MIN_DISTANCE+CAR_WIDTH
	Const SIDE_BUMP_TIME:Int = 4
	Const SIDE_BUMP_SLOWDOWN:Float = 0.00012
	Const OFFROAD_BUMP_SLOWDOWN:Float = 0.006
	Const MIN_SLOWDOWN_SPEED:Float = TOP_SPEED*0.4
	Const MAX_APPLIED_DRIFT:Float = 10
	Const MAX_EXHAUST_FLASH_TIME:Int = 5000
	Const MIN_EXHAUST_FLASH_TIME:Int = 100
	Const GOLDEN_COLOR_TIME:Int = 15
	Const DAMAGE_SMOKING:Int = 3
	Const SMOKING_TIME:Int = 700
	Const SMOKE_TIME:Int = 20
	Const GRID_SIZE:Int = 8
	Const GRID_PLAYER_POS:Int = 7
	Const GRID_STEP_Z:Float = CAR_LENGTH * 3
	Const GRID_START_Z:Float = PLAYER_Z + (GRID_PLAYER_POS-1)*GRID_STEP_Z
	
	Const PLAYER_CAR_COLOR_GREEN:Int = 0
	Const PLAYER_CAR_COLOR_YELLOW:Int = 1
	Const PLAYER_CAR_COLOR_RED:Int = 2
	Const PLAYER_CAR_COLOR_BLACK:Int = 3
	
	Global gGfxWheelFront:TImage
	Global gGfxWheelRear:TImage
	Global gGfxShadow:TImage
	Global gGfxExhaustFlash:TImage

	Global gSndEngine1:TSound
	Global gSndEngine2:TSound
	Global gSndBump:TSound
	Global gSndGrassBump:TSound
	Global gSndSkid:TSound ' from: http://opengameart.org/content/car-tire-squeal-skid-loop
	Global gSndExplosion:TSound
	Global gSndExhaustFlash:TSound
	Global gSndPlok:TSound
	Global gSndCrash:TSound

	Global gWheelFrontWidth:Int
	Global gWheelFrontHeight:Int
	Global gWheelRearWidth:Int
	Global gWheelRearHeight:Int
	Global gNewestEnemy:TCar
	Global gNextEnemyZ:TCar
	Global gEnemyCount:Int
	Global gEnemyMinZ:Float
	
	Field fChnEngine1:TChannel
	Field fChnEngine2:TChannel
	Field fChnSkid:TChannel
	
	Field fHuman:Int
	Field fSpeed:Float
	Field fAccFactor:Float
	Field fSteer:Float
	Field fSteerResult:Float
	Field fDX:Float
	Field fOutwardForce:Float
	Field fColorR:Int
	Field fColorG:Int
	Field fColorB:Int
	Field fSideBumpTime:Float
	Field fLeftWheelBump:Int
	Field fRightWheelBump:Int
	Field fTargetSpeedFactor:Float
	Field fTargetSpeed:Float
	Field fTargetX:Float
	Field fDistanceToPlayer:Float
	Field fWheelColor:Float
	Field fSlope:Float
	Field fInTunnel:Int
	Field fSoundRateModifier:Float
	Field fJumping:Int
	Field fJumpDY:Float
	Field fJumpY:Float
	Field fWingWidthModifier:Float
	Field fWingYOffsetModifier:Float
	Field fAICollisionWarning:Int
	Field fDrift:Float
	Field fDriftFraction:Float
	Field fDrawRearLWheelX:Float
	Field fDrawRearRWheelX:Float
	Field fExhaustFlashTimer:Int
	Field fExhaustFlashScale:Float
	Field fGolden:Int
	Field fGoldenColorTimer:Int
	Field fDamage:Int
	Field fSmokingTimer:Int
	Field fSmokeTimer:Int
	Field fScoreCounted:Int
	
	Field fSteerChange:Float
	Field fSteerReturnFactor:Float
	Field fTopSpeed:Float
	Field fMaxSteer:Float
	
	Function Create:TCar(pZ:Float,pX:Float,pHuman:Int=False,pPlayerCarColor:Int=PLAYER_CAR_COLOR_RED)
		Local car:TCar = New TCar
		car.init(pZ,pX,True)
		car.fSpeed = 0
		car.fAccFactor = 1
		car.fHuman = pHuman
		car.fWidth = CAR_WIDTH
		car.fLength = CAR_LENGTH
		car.fWheelColor = 150
		car.fDrift = 0
		car.fExhaustFlashTimer = Rand(MIN_EXHAUST_FLASH_TIME,MAX_EXHAUST_FLASH_TIME)
		car.fExhaustFlashScale = 0
		car.fGolden = False
		car.fDamage = Rand(0,DAMAGE_SMOKING-1)
		car.fScoreCounted = False
		car.fInTunnel = False
		car.fTopSpeed = TOP_SPEED
		car.fMaxSteer = MAX_STEER
		
		If (car.fHuman) Then
			car.fChnEngine1 = AllocChannel()
			car.fChnEngine2 = AllocChannel()
			car.fChnSkid = AllocChannel()
			car.fChnEngine1.SetVolume(TConstants.SOUND_VOLUME)
			car.fChnEngine2.SetVolume(TConstants.SOUND_VOLUME)
			car.fChnSkid.SetVolume(0)
			
			' selected color determines color and certain driving parameters
			Select (pPlayerCarColor)
				Case PLAYER_CAR_COLOR_GREEN
					car.fColorR = 0
					car.fColorG = 255
					car.fColorB = 0
					
					car.fSteerChange = STEER_CHANGE * 0.70
					car.fSteerReturnFactor = STEER_RETURN_FACTOR - (1-STEER_RETURN_FACTOR)*0.40
					car.fTopSpeed = TOP_SPEED*0.90
					car.fMaxSteer = MAX_STEER*0.80
				
				Case PLAYER_CAR_COLOR_YELLOW
					car.fColorR = 255
					car.fColorG = 230
					car.fColorB = 20
					
					car.fSteerChange = STEER_CHANGE * 0.85
					car.fSteerReturnFactor = STEER_RETURN_FACTOR - (1-STEER_RETURN_FACTOR)*0.20
					car.fTopSpeed = TOP_SPEED*0.95
					car.fMaxSteer = MAX_STEER*0.90

				Case PLAYER_CAR_COLOR_RED
					car.fColorR = 255
					car.fColorG = 0
					car.fColorB = 30
					
					car.fSteerChange = STEER_CHANGE
					car.fSteerReturnFactor = STEER_RETURN_FACTOR
					car.fTopSpeed = TOP_SPEED
					car.fMaxSteer = MAX_STEER
					
				Case PLAYER_CAR_COLOR_BLACK
					car.fColorR = 10
					car.fColorG = 10
					car.fColorB = 10
					
					car.fSteerChange = STEER_CHANGE * 1.40
					car.fSteerReturnFactor = STEER_RETURN_FACTOR + (1-STEER_RETURN_FACTOR)*0.30
					car.fTopSpeed = TOP_SPEED*1.10
					car.fMaxSteer = MAX_STEER*1.20

			End Select
			
			car.fWingWidthModifier = 1.2
			car.fWingYOffsetModifier = 1
			
			PlaySound(gSndEngine1,car.fChnEngine1)
			PlaySound(gSndEngine2,car.fChnEngine2)
			PlaySound(gSndSkid,car.fChnSkid)
		Else
			If (Rand(0,99) < 85) Then
				' average speed
				car.fTargetSpeedFactor = Rnd(0.55,0.95)
			Else If (Rand(0,9) < 6) Then
				' low speed
				car.fTargetSpeedFactor = Rnd(0.35,0.55)
			Else
				' high speed
				car.fTargetSpeedFactor = Rnd(0.95,1.15)
			End If
			
			car.fSoundRateModifier = Rnd(0.7,1.2)
			
			' the mysterious driver in his or her golden car
			If (Rand(20) > 18) Then
				car.fGolden = True
				
				' driving at tremendous speeds
				car.fTargetSpeedFactor = Rnd(0.99,1.17)
				car.fSoundRateModifier = 1.3
			End If
		
			car.fAccFactor = car.fTargetSpeedFactor * Rnd(0.9,1.3)
			car.fTargetX = pX
			car.fChnEngine1 = AllocChannel()
			car.fChnEngine1.SetVolume(0)
			car.fSpeed = car.fTopSpeed*car.fTargetSpeedFactor*0.7
			car.fColorR = Rnd(255)
			car.fColorG = Rnd(255)
			car.fColorB = Rnd(255)
			car.fDistanceToPlayer = Abs(PLAYER_Z-car.fZ)
			car.fWingWidthModifier = Rnd(0.9,1.4)
			car.fWingYOffsetModifier = Rnd(0.8,1.2)
		
			PlaySound(gSndEngine2,car.fChnEngine1)
			
			gNewestEnemy = car
			gEnemyCount :+ 1
		End If
		
		Return(car)
	End Function
	
	Function removeAll()
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			If (entity.isCar()) Then
				Local nextEntity:TEntity = entity.fNext
				entity.clear()
				entity.removeFromList()
				entity = nextEntity
			Else
				entity = entity.fNext
			End If
		Wend
		gEnemyCount = 0
	End Function

	Function loadGraphics()
		gGfxWheelFront = LoadImage("Graphics/wheel_front.png")
		gGfxWheelRear = LoadImage("Graphics/wheel_rear.png")
		gGfxShadow = LoadImage("Graphics/car_shadow.png")
		gGfxExhaustFlash = LoadImage("Graphics/exhaust_flash.png")

		SetImageHandle(gGfxShadow,ImageWidth(gGfxShadow)/2,ImageHeight(gGfxShadow)/2)
		SetImageHandle(gGfxExhaustFlash,ImageWidth(gGfxExhaustFlash)/2,ImageHeight(gGfxExhaustFlash)/2)

		gWheelFrontWidth = ImageWidth(gGfxWheelFront)
		gWheelFrontHeight = ImageHeight(gGfxWheelFront)
		gWheelRearWidth = ImageWidth(gGfxWheelRear)
		gWheelRearHeight = ImageHeight(gGfxWheelRear)
	End Function

	Function loadSounds()
		gSndEngine1 = LoadSound("Sounds/engine5.wav",SOUND_LOOP)
		gSndEngine2 = LoadSound("Sounds/engine3.wav",SOUND_LOOP)
		gSndBump = LoadSound("Sounds/bump.wav")
		gSndGrassBump = LoadSound("Sounds/grassbump.wav")
		gSndSkid = LoadSound("Sounds/skid3.wav",SOUND_LOOP)
		gSndExplosion = LoadSound("Sounds/explosion2.wav")
		gSndExhaustFlash = LoadSound("Sounds/exhaust_flash.wav")
		gSndPlok = LoadSound("Sounds/plok.wav")
		gSndCrash = LoadSound("Sounds/crash.wav")
	End Function
	
	Function createStartingGrid:TCar(pPlayerCarColor:Int)
		Local player:TCar = Null
		Local side:Int = 1
		For Local i:Int=1 To GRID_SIZE
			side :* -1
			If (i <> GRID_PLAYER_POS) Then
				Local enemy:TCar = TCar.Create(GRID_START_Z-GRID_STEP_Z*(i-1),side*TConstants.ROAD_WIDTH/4)
				enemy.fSpeed = 0
			Else
				player = TCar.Create(TCar.PLAYER_Z,side*TConstants.ROAD_WIDTH/4,True,pPlayerCarColor)
			End If
		Next
		Return(player)
	End Function
	
	Method updateEngineSound()
		Local gear:Int = Int((fSpeed/fTopSpeed) / (1.0/GEARS))
		Local gearSpeed:Float = (fSpeed - (gear*(fTopSpeed/GEARS))) / (fTopSpeed/GEARS)
		Local rate:Float = 0.8*(gear+1)+2.8*gearSpeed
		
		If (fJumping) Then
			rate :* 1.5
		End If
		
		If (fHuman) Then
			fChnEngine1.SetRate(rate)
			fChnEngine2.SetRate(rate)
		Else
			rate :* fSoundRateModifier
		
			Local newDistanceToPlayer:Float = Abs(PLAYER_Z-fZ)
				
			If (newDistanceToPlayer < fDistanceToPlayer) Then
				rate :+ (fDistanceToPlayer - newDistanceToPlayer)*6
			Else
				rate :- (newDistanceToPlayer - fDistanceToPlayer)
			End If
			
			fChnEngine1.SetRate(rate)
			
			fDistanceToPlayer = newDistanceToPlayer

			' volume
			Local volume:Float = 1-fDistanceToPlayer/Abs(gEnemyMinZ-PLAYER_Z)
			If (volume < 0) Then
				volume = 0
			End If
			fChnEngine1.SetVolume(volume*TConstants.SOUND_VOLUME)
		End If
	End Method
		
	Method setSegmentDX(pSegmentDX:Float,pSegmentDXFraction:Float)
		Super.setSegmentDX(pSegmentDX,pSegmentDXFraction)
		fTargetSpeed = (fTopSpeed - Abs(pSegmentDXFraction)*AI_MAX_SPEED_DECREASE) * fTargetSpeedFactor
	End Method
	
	Method update(pDZ:Float)
		fOldZ = fZ
		
		Local acc:Float
		
		If (fSpeed < fTopSpeed*0.97) Then
			acc = (fTopSpeed-fSpeed)/1600.0*fAccFactor
		Else
			acc = (fTopSpeed-fSpeed)/4800.0*fAccFactor
		End If
		
		' smoking
		If (fSmokingTimer > 0) Then
			acc :/ 3
		End If
		
		' jumping
		If (fJumping) Then
			fJumpY :+ fJumpDY
			fJumpDY :- 0.01
			If (fJumpY <= 0) Then
				fJumpY = 0
				fJumping = False
			End If
		End If
		
		If (fHuman) Then
			' player car: z remains same
			If (KeyDown(KEY_UP) Or KeyDown(KEY_A)) Then
				fSpeed :+ acc
				If (fSpeed > fTopSpeed) Then
					fSpeed = fTopSpeed
				End If
			Else If (KeyDown(KEY_DOWN) Or KeyDown(KEY_Z) Or KeyDown(KEY_Y)) Then
				If (fSpeed > 0) Then
					fSpeed :- BRAKE
					If (fSpeed <= 0) Then
						fSpeed = 0
						fSteerResult = 0
					End If
				End If
			Else If (fSpeed > 0) Then
				fSpeed :- IDLE_BRAKE
				If (fSpeed < 0) Then
					fSpeed = 0
				End If
				
				' lose drift
				If (fDrift > 0) Then
					fDrift :- 0.01
					If (fDrift < 0) Then
						fDrift = 0
					End If
				End If
			End If
			
			If (Not(fJumping)) Then
				If (KeyDown(KEY_LEFT) Or KeyDown(KEY_COMMA)) Then
					fSteer :- fSteerChange
					If (fSteer < -fMaxSteer) Then
						fSteer = -fMaxSteer
					End If
				Else If (KeyDown(KEY_RIGHT) Or KeyDown(KEY_PERIOD)) Then
					fSteer :+ fSteerChange
					If (fSteer > fMaxSteer) Then
						fSteer = fMaxSteer
					End If
				Else
					fSteer :* fSteerReturnFactor
					
					' lose drift
					If (fDrift > 0) Then
						fDrift :- 0.1
						If (fDrift < 0) Then
							fDrift = 0
						End If
					End If
				End If
			End If
						
			fOutwardForce = (9*fOutwardForce + fSegmentDX*(240*fSpeed)*(240*fSpeed))/10.0
			
			fX :- fOutwardForce
			
			' gain drift
			If (fSpeed > fTopSpeed/2) Then
				If (fSteer <> 0) Then
					Local speed:Float = (fSpeed-fTopSpeed/2)/(fTopSpeed/2)
					Local steer:Float = Abs(fSteer)/fMaxSteer
					fDrift :+ (speed*steer)/5.5
				End If 
			End If
			
			' lose drift
			If (fDrift > 0) Then
				fDrift :- 0.065
				If (fDrift < 0) Then
					fDrift = 0
				End If
			End If
			
			Local steerSpeed:Float = fSpeed
			If (fSteerResult < fSteer) Then
				fSteerResult :+ steerSpeed
				If (fSteerResult > fSteer) Then
					fSteerResult = fSteer
				End If
			End If
			If (fSteerResult > fSteer) Then
				fSteerResult :- steerSpeed
				If (fSteerResult < fSteer) Then
					fSteerResult = fSteer
				End If
			End If
			
			' use drift to increase steering
			fDriftFraction:Float = 0
			If (fDrift > 1) Then
				Local applied:Float = fDrift
				If (applied > MAX_APPLIED_DRIFT) Then
					applied = MAX_APPLIED_DRIFT
				End If
				fDriftFraction = applied / MAX_APPLIED_DRIFT
				fX :+ fSteerResult*(1+fDriftFraction/5.0)*(1+fDriftFraction/5.0)
			Else
				fX :+ fSteerResult
			End If
			
			' skid clouds
			If (fDriftFraction > 0.2) Then
				TProp.Create(fZ-Rnd(0.15,0.25),fX-fDrawRearLWheelX,TProp.PROP_SKID_CLOUD)
				TProp.Create(fZ-Rnd(0.15,0.25),fX+fDrawRearRWheelX,TProp.PROP_SKID_CLOUD)
			End If
			
			' skidding sound
			fChnSkid.SetVolume(fDriftFraction*TConstants.SOUND_VOLUME)
			
			' exhaust flash
			fExhaustFlashTimer :- 1+(fSpeed/fTopSpeed)
			If (fExhaustFlashTimer <= 0) Then
				If (fSpeed > fTopSpeed*0.5) Then
					fExhaustFlashScale = 0.1
					Local chnExhaustFlash:TChannel = PlaySound(gSndExhaustFlash)
					chnExhaustFlash.SetVolume(TConstants.SOUND_VOLUME)
				End If
				fExhaustFlashTimer = Rand(MIN_EXHAUST_FLASH_TIME,MAX_EXHAUST_FLASH_TIME)
			End If
			
			If (fExhaustFlashScale > 0) Then
				fExhaustFlashScale :+ 0.07
				If (fExhaustFlashScale > 1.5) Then
					fExhaustFlashScale = 0
				End If
			End If
			
			' a bit of random movement
			fX :+ Rnd(-2,2)*fSpeed
			
			updateEngineSound()
		Else
			Local oldZ:Float = fZ
			
			fZ :+ fSpeed-pDZ
			
			' behind player
			If (fZ < PLAYER_Z) Then
				If (Not(fScoreCounted)) Then
					' overtaken by player
					If (oldZ >= PLAYER_Z) Then
						TScore.add(TScore.SCORE_OVERTAKING)
						fScoreCounted = True
					End If 
				End If
			End If
			
			' clear track ahead
			If (Not(fAICollisionWarning)) Then
				If (fSpeed < fTargetSpeed) Then
					fSpeed :+ acc
					If (fSpeed > fTopSpeed) Then
						fSpeed = fTopSpeed
					End If
				Else If (fSpeed > fTargetSpeed) Then
					If (fSpeed > 0) Then
						fSpeed :- BRAKE
						If (fSpeed < 0) Then
							fSpeed = 0
						End If
					End If
				Else If (fSpeed > 0) Then
					fSpeed :- IDLE_BRAKE
					If (fSpeed < 0) Then
						fSpeed = 0
					End If
				End If
			' something is in the way
			Else
				If (fSpeed > 0) Then
					' step on the brakes
					fSpeed :- IDLE_BRAKE
					If (fSpeed < 0) Then
						fSpeed = 0
					End If
				End If
				fAICollisionWarning = False
			End If
			
			If ((fX > (fTargetX+TARGET_X_MARGIN)) Or (fX > SIDE_BUMP_MIN_DISTANCE)) Then
				fSteer :- AI_STEER_CHANGE*(1+Abs(fSegmentDX))
				If (fSteer < -fMaxSteer) Then
					fSteer = -fMaxSteer
				End If
			Else If ((fX < (fTargetX-TARGET_X_MARGIN)) Or (fX < -SIDE_BUMP_MIN_DISTANCE)) Then
				fSteer :+ AI_STEER_CHANGE*(1+Abs(fSegmentDX))
				If (fSteer > fMaxSteer) Then
					fSteer = fMaxSteer
				End If
			Else
				fSteer :* (STEER_RETURN_FACTOR*0.8)
			End If
			
			If (fGolden) Then
				fGoldenColorTimer :+ 1
				If (fGoldenColorTimer > GOLDEN_COLOR_TIME) Then
					fGoldenColorTimer = 0
				End If
			End If
			
			fOutwardForce = (9*fOutwardForce + fSegmentDX*(210*fSpeed)*(210*fSpeed))/10.0

			fX :- fOutwardForce
			fX :+ fSteer
			
			updateEngineSound()
		End If
		
		fLeftWheelBump = False
		fRightWheelBump = False
		
		checkCollisions()
		
		If (Not(fHuman)) Then
			checkCollisions(True)
		End If
		
		If (fInTunnel And (Abs(fX) > SIDE_BUMP_MAX_DISTANCE)) Then
			If (fX > 0) Then
				fX = SIDE_BUMP_MIN_DISTANCE
			Else
				fX = -SIDE_BUMP_MIN_DISTANCE
			End If
			fSpeed :* 0.7
			fSteerResult = 0
			fSteer :* -1
			If (fSteer < -fMaxSteer) Then
				fSteer = -fMaxSteer
			Else If (fSteer > fMaxSteer) Then
				fSteer = fMaxSteer
			End If
			Local channel:TChannel = PlaySound(gSndCrash)
			channel.SetVolume(fScale*TConstants.SOUND_VOLUME)
		Else If (Abs(fX) > SIDE_BUMP_MIN_DISTANCE) Then
			If (Abs(fX) > OFFROAD_BUMP_MIN_DISTANCE) Then
				fLeftWheelBump = True
				fRightWheelBump = True
			Else
				If (fX >= 0) Then
					fRightWheelBump = True
				Else
					fLeftWheelBump = True
				End If
			End If
						
			fSideBumpTime :- fSpeed
			If (fSideBumpTime <= 0) Then
				
				If (Abs(fX) < SIDE_BUMP_MAX_DISTANCE) Then
					If (fHuman) Then
						Local chnBump:TChannel = PlaySound(gSndBump)
						chnBump.SetVolume(TConstants.SOUND_VOLUME/4)
					End If
					
					If (fSpeed > MIN_SLOWDOWN_SPEED) Then
						fSpeed :- SIDE_BUMP_SLOWDOWN
						If (fSpeed < MIN_SLOWDOWN_SPEED) Then
							fSpeed = MIN_SLOWDOWN_SPEED
						End If
					End If
				Else
					If (fHuman) Then
						Local chnBump:TChannel = PlaySound(gSndGrassBump)
						chnBump.SetVolume(TConstants.SOUND_VOLUME/4)
					End If
					
					If (fSpeed > MIN_SLOWDOWN_SPEED) Then
						fSpeed :- OFFROAD_BUMP_SLOWDOWN
						If (fSpeed < MIN_SLOWDOWN_SPEED) Then
							fSpeed = MIN_SLOWDOWN_SPEED
						End If
					End If
				End If
				
				fSideBumpTime = SIDE_BUMP_TIME
			End If
		End If
		
		If (fX < -MAX_DISTANCE_FROM_CENTER) Then
			fX = -MAX_DISTANCE_FROM_CENTER
		End If
		If (fX > MAX_DISTANCE_FROM_CENTER) Then
			fX = MAX_DISTANCE_FROM_CENTER
		End If
		
		updateWheelColor()
		
		If (fSmokingTimer > 0) Then
			updateSmoking()
		End If
		
		If (fZ > gMaxZ) Or (fZ < gEnemyMinZ) Then
			If (fActive) Then
				deactivate()
			End If
		End If
	End Method
	
	Method updateWheelColor()
		Local change:Float = fSpeed
		If (change > 0.15) Then
			change = 0.15
		End If
		fWheelColor :- change*50
		If (fWheelColor < 0) Then
			fWheelColor = 150
		End If
	End Method
	
	Method updateSmoking()
		fSmokeTimer :- 1
		If (fSmokeTimer <= 0) Then
			fSmokeTimer = SMOKE_TIME
		
			TProp.Create(fZ,fX,TProp.PROP_SMOKE)
		End If
		fSmokingTimer :- 1
	End Method

	Method checkCollisions(pLookAhead:Int=False)
		Local entity:TEntity = TEntity.gFirst
		While (entity <> Null)
			' other is not self
			If (entity <> Self) Then
				' other can be hit
				If (entity.hittable()) Then
					' other is in front
					If (fZ < entity.fZ) Then
						' moving closer to other
						If (entity.getSpeed() < fSpeed) Then
							Local checkDistance:Float = fLength
							If (pLookAhead) Then
								Local speedFraction:Float = fSpeed/fTopSpeed
								checkDistance :+ fLength * 17 * speedFraction '15
							End If
							Local distanceZ:Float = Abs(fZ - entity.fZ)
							' z distance is small
							If (distanceZ < checkDistance) Then
								Local distanceX:Float = Abs(fX - entity.fX)						
								' x distance is small
								If (distanceX < 0.9*(fWidth/2 + entity.fWidth/2)) Then
									' actual collision, not looking ahead
									If (Not(pLookAhead)) Then
									
										' start of tunnel
										If (entity.isTunnelStart()) Then
											' inside tunnel opening
											If (Abs(fX) < SIDE_BUMP_MAX_DISTANCE) Then
												Exit
											End If
										End If
									
										' oil
										If (entity.isOil()) Then
											' player car slides
											If (isHuman()) Then
												If (Not(fJumping)) Then
													fDrift = Rnd(MAX_APPLIED_DRIFT/2,MAX_APPLIED_DRIFT)
													fSteer :* 3
													If (fSteer < -fMaxSteer) Then
														fSteer = -fMaxSteer
													Else If (fSteer > fMaxSteer) Then
														fSteer = fMaxSteer
													End If
													' oil disappears
													entity.deactivate()
												End If
											End If
										Else
											If (fJumping And entity.isCar()) Then
												Exit
											End If
											
											Local oldSpeed:Float = fSpeed
											
											fSpeed = entity.receiveHit(fSpeed,fZ,fLength)
											
											If (entity.isHuman()) Then
												fZ = entity.fZ-fLength*1.2
											Else
												selectNewLane(entity.fX)
											End If
											
											If (oldSpeed > fTopSpeed/10) Then
												Local channel:TChannel
												Local speedDifferencePercentage:Float = (oldSpeed-fSpeed)/oldSpeed*100
												
												' small collision
												If (speedDifferencePercentage < 20) Then
													' small sound
													If (isHuman() Or entity.isHuman()) Then
														channel = PlaySound(gSndPlok)
														channel.SetVolume(fScale*TConstants.SOUND_VOLUME)
													End If
												' considerable collision, on wheels of other car
												Else If (entity.isCar() And Not(fJumping) And (distanceX > 0.7*(fWidth/2 + entity.fWidth/2)))
													fJumping = True
													fJumpDY = fSpeed*4
													
													' maintain most of old speed
													fSpeed = oldSpeed*0.98
													
													' bigger sound
													channel = PlaySound(gSndCrash)
													channel.SetVolume(fScale*TConstants.SOUND_VOLUME)
												' considerable collision, on body of other car or other entity
												Else If (speedDifferencePercentage < 50) Then
													' bigger sound
													channel = PlaySound(gSndCrash)
													channel.SetVolume(fScale*TConstants.SOUND_VOLUME)
													
													' count damage
													fDamage :+ 1
													
													If (fDamage >= DAMAGE_SMOKING) Then
														fDamage = 0
														fSmokingTimer = SMOKING_TIME
														fSmokeTimer = SMOKE_TIME
													End If
												' car explodes
												Else
													' car explodes
													Local explosion:TProp = TProp.Create(fZ+Rnd(fLength*2),fX,TProp.PROP_EXPLOSION)
													explosion.setChain(4,1)
													
													' cpu car leaves oil on track
													If (Not(fHuman)) Then
														TProp.Create(fZ,fX,TProp.PROP_OIL)
													End If
													
													deactivate()
												End If											
											End If
										End If
										Exit
									' looking ahead, no actual collision
									Else
										selectNewLane(entity.fX)
										
										' if cpu car is behind other car for some time, getting closer
										' (or, in fact, just very close), this means he has trouble passing him
										' (or, the other car suddenly got in the way), and should instead apply
										' the brake or let go of the throttle
										
										If (distanceZ < checkDistance/3) Then
											fAICollisionWarning = True
										End If
									End If
								End If
							End If
						End If
					End If
				End If
			End If
			entity = entity.fNext
		Wend
	End Method

	Method deactivate()
		Super.deactivate()
		
		If (Not(fHuman)) Then
			gEnemyCount :- 1
			If (gEnemyCount < 0) Then
				gEnemyCount = 0
			End If
		End If
	End Method

	Method draw()
		Local x:Float = fRoadX+fScale*fX
		Local drawY:Float = fScreenY-20*fScale
		
		If (fJumping) Then
			drawY :- fJumpY*fScale
		End If
		
		Local perspectiveEffect:Float = (TConstants.HALF_SCREEN_WIDTH-x)/TConstants.HALF_SCREEN_WIDTH * 20
		
		SetScale(fScale,fScale)
		
		Local bodyWidth:Float = 80
		Local bodyHeight:Float = 30
		Local frontWheelOffsetY:Float = MAX_FRONT_WHEEL_OFFSET_Y - (1-fScale) * (MAX_FRONT_WHEEL_OFFSET_Y-MIN_FRONT_WHEEL_OFFSET_Y)
		
		Local leftWheelBumpDY:Float = 0
		Local rightWheelBumpDY:Float = 0

		If (fLeftWheelBump) Then
			leftWheelBumpDY = fSideBumpTime*2
		End If
		
		If (fRightWheelBump) Then
			rightWheelBumpDY = fSideBumpTime*2
		End If
		
		Local leftWheelsShakeDY:Float = 0 'Rnd(1,16)*fSpeed
		Local rightWheelsShakeDY:Float = 0 'Rnd(1,16)*fSpeed
		
		' front wheels
		Local frontWheelSteerEffect:Float = perspectiveEffect + fSteer*4 + fDriftFraction*5
		Local slopeDY:Float = fSlope*SLOPE_TO_FRONT_WHEEL_DY_FACTOR
		
		If (slopeDY > MAX_FRONT_WHEEL_DY_FACTOR) Then
			slopeDY = MAX_FRONT_WHEEL_DY_FACTOR
		End If
		
		drawWheel(gGfxWheelFront,x-((bodyWidth*0.7-frontWheelSteerEffect)*fScale),drawY-((frontWheelOffsetY+leftWheelBumpDY+leftWheelsShakeDY+slopeDY)*fScale),gWheelFrontWidth,gWheelFrontHeight)
		drawWheel(gGfxWheelFront,x+((bodyWidth*0.7+frontWheelSteerEffect)*fScale),drawY-((frontWheelOffsetY+rightWheelBumpDY+rightWheelsShakeDY+slopeDY)*fScale),gWheelFrontWidth,gWheelFrontHeight)
		
		' front wing
		Local wingWidth:Float = bodyWidth*0.9
		Local wingHeight:Float = 8
		Local wingYOffset:Float = -20
		SetColor(fColorR/2,fColorG/2,fColorB/2)
		DrawRect(x-(wingWidth/2-frontWheelSteerEffect)*fScale,drawY-wingHeight*fScale+wingYOffset*fScale,wingWidth,wingHeight)
		
		' draw body
		Local rotation:Float = -fSteer*fSpeed*1.5*(1+fDriftFraction/2)
		SetRotation(rotation)
		SetHandle(bodyWidth/2,bodyHeight/2)
		Local bodyOffsetY:Float = 10
		If (fGolden) Then
			If (fGoldenColorTimer > GOLDEN_COLOR_TIME/2) Then
				fColorR = 255
				fColorG = 200
				fColorB = 0
			Else
				fColorR = 255
				fColorG = 255
				fColorB = 255
			End If
		End If
		SetColor(fColorR,fColorG,fColorB)
		DrawRect(x,drawY-(bodyHeight/2*fScale)+(bodyOffsetY*fScale),bodyWidth,bodyHeight)
		SetHandle(0,0)
		SetRotation(0)
		
		Local rearWheelSteerEffect:Float = perspectiveEffect + fSteer*2 + fDriftFraction*5
		
		' draw engine
		Local engineWidth:Float = 50
		Local engineHeight:Float = 20
		Local engineYOffset:Float = 8
		SetRotation(rotation)
		SetHandle(engineWidth/2,engineHeight/2)
		SetColor(fColorR/2,fColorG/2,fColorB/2)
		DrawRect(x-rearWheelSteerEffect*fScale,drawY-(engineHeight/2*fScale)+(engineYOffset*fScale),engineWidth,engineHeight)
		SetHandle(0,0)
		SetRotation(0)

		' rear wheels
		fDrawRearLWheelX = bodyWidth*0.85+rearWheelSteerEffect
		fDrawRearRWheelX = bodyWidth*0.85-rearWheelSteerEffect

		drawWheel(gGfxWheelRear,x-fDrawRearLWheelX*fScale,drawY-(leftWheelBumpDY+leftWheelsShakeDY)*fScale,gWheelRearWidth,gWheelRearHeight)
		drawWheel(gGfxWheelRear,x+fDrawRearRWheelX*fScale,drawY-(rightWheelBumpDY+rightWheelsShakeDY)*fScale,gWheelRearWidth,gWheelRearHeight)
		
		wingWidth:Float = bodyWidth*fWingWidthModifier
		wingHeight:Float = 6
		wingYOffset:Float = -26*fWingYOffsetModifier '6
		
		' rear wing post
		SetColor(40,40,40)
		DrawRect(x-(4+rearWheelSteerEffect)*fScale,drawY-wingHeight*fScale+wingYOffset*fScale,8,20)
		
		' rear wing
		SetRotation(rotation)
		SetHandle(wingWidth/2,wingHeight/2)
		SetColor(fColorR*2,fColorG*2,fColorB*2)
		DrawRect(x-rearWheelSteerEffect*fScale,drawY-wingHeight/2*fScale+wingYOffset*fScale,wingWidth,wingHeight)
		SetHandle(0,0)
		SetRotation(0)
		
		' exhaust flash
		If (fExhaustFlashScale > 0) Then
			SetScale(fExhaustFlashScale*fScale,fExhaustFlashScale*fScale)
			SetColor(255,255,255)
			DrawImage(gGfxExhaustFlash,x,fScreenY-25*fScale)
		End If
	End Method
	
	Method drawWheel(pGfx:TImage,pX:Float,pY:Float,pWidth:Int,pHeight:Int)
		SetColor(fWheelColor,fWheelColor,fWheelColor)
		DrawImage(pGfx,pX-(pWidth/2*fScale),pY-(pHeight/2*fScale))
	End Method
	
	Method drawShadow()
		SetScale(fScale,fScale)
		SetBlend(ALPHABLEND)
		SetAlpha(0.2)
		DrawImage(gGfxShadow,fRoadX+fScale*fX,fScreenY-16*fScale)
		SetBlend(MASKBLEND)
		SetAlpha(1)
	End Method

	Method getSpeed:Float()
		Return(fSpeed)
	End Method

	Method isHuman:Int()
		Return(fHuman)
	End Method
	
	Method isCar:Int()
		Return(True)
	End Method
	
	Method receiveHit:Float(pSpeed:Float,pZ:Float,pLength:Float)
		If (Not(fHuman)) Then
			fZ = pZ+pLength*1.2
		End If
		Return(fSpeed*0.9)
	End Method
	
	Method selectNewLane(pBlockedX:Float)
		If (pBlockedX <= 0) Then
			fTargetX = Rand(0,TConstants.ROAD_WIDTH*0.4)
		Else
			fTargetX = Rand(-TConstants.ROAD_WIDTH*0.4,0)
		End If
	End Method
	
	Method setSlope(pSlope:Float)
		fSlope = pSlope
	End Method
	
	Method setInTunnel(pInTunnel:Int)
		fInTunnel = pInTunnel
	End Method
	
	Method clear()
		If (fChnEngine1) Then
			fChnEngine1.Stop()
		End If
		If (fChnEngine2) Then
			fChnEngine2.Stop()
		End If
		If (fChnSkid) Then
			fChnSkid.Stop()
		End If
	End Method
End Type