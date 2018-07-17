
' Grand Prix - prop.bmx

SuperStrict

Import "entity.bmx"

Type TProp Extends TEntity
	Const PROP_BANNER_YELLOW:Int = 0
	Const PROP_BANNER_START:Int = 1
	Const PROP_CORNER_SIGN:Int = 2
	Const PROP_BUSH_1:Int = 3
	Const PROP_BANNER_COMMODORE:Int = 4
	Const PROP_BANNER_TIRES:Int = 5
	Const PROP_SIGN_TEST:Int = 6
	Const PROP_SIGN_FG:Int = 7
	Const PROP_EXPLOSION:Int = 8
	Const PROP_SKID_CLOUD:Int = 9
	Const PROP_OIL:Int = 10
	Const PROP_SMOKE:Int = 12
	Const PROP_TUNNEL_START:Int = 13
	Const PROP_TUNNEL_MID:Int = 14
	Const PROP_TUNNEL_END:Int = 15

	Const EXPLOSION_GROW_SPEED:Float = 0.022
	Const SKID_CLOUD_GROW_SPEED:Float = EXPLOSION_GROW_SPEED*10
	Const SMOKE_TIME:Int = 500
	Const TUNNEL_OPENING_HEIGHT:Int = TConstants.SCREEN_HEIGHT/2

	Global gGfxBannerYellow:TImage
	Global gGfxBannerStart:TImage
	Global gGfxBannerStart1:TImage
	Global gGfxBannerStart2:TImage
	Global gGfxBannerStart3:TImage
	Global gGfxCornerSign:TImage
	Global gGfxBush1:TImage
	Global gGfxBush2:TImage
	Global gGfxBannerCommodore:TImage
	Global gGfxBannerTires:TImage
	Global gGfxSignTest:TImage
	Global gGfxSignFG:TImage
	Global gGfxExplosion:TImage
	Global gGfxSkidCloud1:TImage
	Global gGfxSkidCloud2:TImage
	Global gGfxOil:TImage
	Global gGfxSmoke1:TImage
	Global gGfxSmoke2:TImage

	Global gSndExplosion:TSound
	
	Global gBannerStart:TProp
	
	Global gInTunnel:Int

	Field fType:Int
	Field fGfx:TImage
	Field fHittable:Int
	Field fSize:Float
	Field fTargetSize:Float
	Field fTimer:Float
	Field fChainCount:Int
	Field fChainDZ:Float
	Field fPartOfTunnel:Int
	
	Function Create:TProp(pZ:Float,pX:Float,pType:Int) 'pGfx:TImage)
		Local prop:TProp = New TProp
		
		prop.init(pZ,pX,True)
		prop.fType = pType
		prop.fSize = 1
		prop.fChainCount = 0
		prop.fTimer = -1
		prop.fPartOfTunnel = False
				
		Select pType
			Case PROP_BANNER_YELLOW
				prop.fGfx = gGfxBannerYellow
		
			Case PROP_BANNER_START
				prop.fGfx = gGfxBannerStart
				
				gBannerStart = prop
				
			Case PROP_CORNER_SIGN
				prop.fGfx = gGfxCornerSign
				
			Case PROP_BUSH_1
				If (Rand(1,10) > 6) Then
					prop.fGfx = gGfxBush1
				Else
					prop.fGfx = gGfxBush2
				End If
				
			Case PROP_BANNER_COMMODORE
				prop.fGfx = gGfxBannerCommodore

			Case PROP_BANNER_TIRES
				prop.fGfx = gGfxBannerTires

			Case PROP_SIGN_TEST
				prop.fGfx = gGfxSignTest
				prop.fHittable = True
		
			Case PROP_SIGN_FG
				prop.fGfx = gGfxSignFG
				prop.fHittable = True
				
			Case PROP_EXPLOSION
				prop.fGfx = gGfxExplosion
				prop.fSize = 0
				prop.fTargetSize = Rnd(0.3,1)
				
				Local channel:TChannel = PlaySound(gSndExplosion)
				Local scale:Float = 1.0-(prop.fZ-TEntity.gMinZ)/(TEntity.gMaxZ-TEntity.gMinZ)
				channel.SetVolume(scale*TConstants.SOUND_VOLUME)
				channel.SetRate(44000 + Rand(-2000,2000))

			Case PROP_SKID_CLOUD
				If (Rand(1,2) = 1) Then
					prop.fGfx = gGfxSkidCloud1
				Else
					prop.fGfx = gGfxSkidCloud2
				End If
				prop.fSize = Rnd(0.5)
				prop.fTargetSize = Rnd(1)
				
			Case PROP_OIL
				prop.fGfx = gGfxOil
				prop.fHittable = True
			
			Case PROP_SMOKE
				If (Rand(1,2) = 1) Then
					prop.fGfx = gGfxSmoke1
				Else
					prop.fGfx = gGfxSmoke2
				End If
				prop.fTimer = SMOKE_TIME
				
			Case PROP_TUNNEL_START
				prop.fPartOfTunnel = True
				prop.fHittable = True
				prop.fWidth = TConstants.ROAD_WIDTH*6
				
			Case PROP_TUNNEL_MID
				prop.fPartOfTunnel = True

			Case PROP_TUNNEL_END
				prop.fPartOfTunnel = True				
		End Select
		
		If (prop.fGfx <> Null) Then
			prop.fWidth = ImageWidth(prop.fGfx)
		End If
		
		Return(prop)
	End Function
	
	Function loadGraphics()
		gGfxBannerYellow = LoadImage("Graphics/banner_yellow.png")
		gGfxBannerStart = LoadImage("Graphics/banner_start.png")
		gGfxBannerStart1 = LoadImage("Graphics/banner_start_1.png")
		gGfxBannerStart2 = LoadImage("Graphics/banner_start_2.png")
		gGfxBannerStart3 = LoadImage("Graphics/banner_start_3.png")
		gGfxCornerSign = LoadImage("Graphics/cornersign.png")
		gGfxBush1 = LoadImage("Graphics/bush_1.png")
		gGfxBush2 = LoadImage("Graphics/bush_2.png")
		gGfxBannerCommodore = LoadImage("Graphics/banner_commodore.png")
		gGfxBannerTires = LoadImage("Graphics/banner_tires.png")
		gGfxSignTest = LoadImage("Graphics/sign_blue.png")
		gGfxSignFG = LoadImage("Graphics/sign_fg.png")
		gGfxExplosion = LoadImage("Graphics/explosion.png")
		gGfxSkidCloud1 = LoadImage("Graphics/skid_cloud.png")
		gGfxSkidCloud2 = LoadImage("Graphics/skid_cloud_2.png")
		gGfxOil = LoadImage("Graphics/oil.png")
		gGfxSmoke1 = LoadImage("Graphics/smoke_1.png")
		gGfxSmoke2 = LoadImage("Graphics/smoke_2.png")

		SetImageHandle(gGfxBannerYellow,ImageWidth(gGfxBannerYellow)/2,ImageHeight(gGfxBannerYellow))
		SetImageHandle(gGfxBannerStart,ImageWidth(gGfxBannerStart)/2,ImageHeight(gGfxBannerStart))
		SetImageHandle(gGfxBannerStart1,ImageWidth(gGfxBannerStart1)/2,ImageHeight(gGfxBannerStart1))
		SetImageHandle(gGfxBannerStart2,ImageWidth(gGfxBannerStart2)/2,ImageHeight(gGfxBannerStart2))
		SetImageHandle(gGfxBannerStart3,ImageWidth(gGfxBannerStart3)/2,ImageHeight(gGfxBannerStart3))
		SetImageHandle(gGfxCornerSign,ImageWidth(gGfxCornerSign)/2,ImageHeight(gGfxCornerSign))
		SetImageHandle(gGfxBush1,ImageWidth(gGfxBush1)/2,ImageHeight(gGfxBush1))
		SetImageHandle(gGfxBush2,ImageWidth(gGfxBush2)/2,ImageHeight(gGfxBush2))
		SetImageHandle(gGfxBannerCommodore,ImageWidth(gGfxBannerCommodore)/2,ImageHeight(gGfxBannerCommodore))
		SetImageHandle(gGfxBannerTires,ImageWidth(gGfxBannerTires)/2,ImageHeight(gGfxBannerTires))
		SetImageHandle(gGfxSignTest,ImageWidth(gGfxSignTest)/2,ImageHeight(gGfxSignTest))
		SetImageHandle(gGfxSignFG,ImageWidth(gGfxSignFG)/2,ImageHeight(gGfxSignFG))
		SetImageHandle(gGfxExplosion,ImageWidth(gGfxExplosion)/2,ImageHeight(gGfxExplosion))
		SetImageHandle(gGfxSkidCloud1,ImageWidth(gGfxSkidCloud1)/2,ImageHeight(gGfxSkidCloud1))
		SetImageHandle(gGfxSkidCloud2,ImageWidth(gGfxSkidCloud2)/2,ImageHeight(gGfxSkidCloud2))
		SetImageHandle(gGfxOil,ImageWidth(gGfxOil)/2,ImageHeight(gGfxOil))
		SetImageHandle(gGfxSmoke1,ImageWidth(gGfxSmoke1)/2,ImageHeight(gGfxSmoke1))
		SetImageHandle(gGfxSmoke2,ImageWidth(gGfxSmoke2)/2,ImageHeight(gGfxSmoke2))
	End Function
	
	Function loadSounds()
		gSndExplosion = LoadSound("Sounds/explosion.wav")
	End Function

	Method setChain(pChainCount:Int,pChainDZ:Float)
		fChainCount = pChainCount
		fChainDZ = pChainDZ
	End Method
	
	Method draw()
		Local x:Float = fRoadX+fScale*fX
		
		If (fPartOfTunnel) Then
			Local openingHeight:Float = TUNNEL_OPENING_HEIGHT*fScale
			Local topHeight:Float
			
			If (fType = PROP_TUNNEL_START) Then
				topHeight = openingHeight/2
			
				SetColor(255,255,255)
			Else
				If (gInTunnel) Then
					topHeight = fScreenY-openingHeight
				Else
					topHeight = openingHeight/1.5
				End If
			
				SetColor(0,0,0)
			End If
			
			SetScale(1,1)
			DrawRect(0,fScreenY-openingHeight,fRoadX-(TConstants.ROAD_WIDTH*fScale)/2,openingHeight+1)
			Local rightX:Float = fRoadX+(TConstants.ROAD_WIDTH*fScale)/2
			DrawRect(rightX,fScreenY-openingHeight,TConstants.SCREEN_WIDTH-rightX,openingHeight+1)
			DrawRect(0,fScreenY-(openingHeight+topHeight),TConstants.SCREEN_WIDTH,topHeight)
		Else
			If (fType = PROP_OIL) Then
				' oil is on ground so should be 'flattened' or 'stretched' along y axis
				' based on slope of hill, but less so as it gets closer to camera
				SetScale(fScale,fScale*(1+fSegmentDY*3500*(fZ/gMaxZ)))
			Else
				SetScale(fScale*fSize,fScale*fSize)
			End If
			SetColor(255,255,255)
			DrawImage(fGfx,x,fScreenY)
		End If
	End Method
	
	Method update(pScrollSpeed:Float)
		Super.update(pScrollSpeed)
		
		Select fType
			Case PROP_EXPLOSION
				fSize :+ EXPLOSION_GROW_SPEED
				If (fSize >= fTargetSize) Then
					fSize = fTargetSize
					fActive = False
					If (fChainCount > 0) Then
						Local explosion:TProp = TProp.Create(fZ+fChainDZ,fX,fType)
						explosion.setChain(fChainCount-1,fChainDZ)
					End If
				End If
		
			Case PROP_SKID_CLOUD
				fSize :+ SKID_CLOUD_GROW_SPEED
				If (fSize >= fTargetSize) Then
					fSize = fTargetSize
					fActive = False
				End If
				
			Case PROP_SMOKE
				fTimer :- 1
				If (fTimer <= 0) Then
					fActive = False
				End If
		End Select
	End Method
	
	Method receiveHit:Float(pSpeed:Float,pZ:Float,pLength:Float)
		Return(0)
	End Method
	
	Method hittable:Int()
		Return(fHittable)
	End Method
	
	Method isOil:Int()
		Return(fType = PROP_OIL)
	End Method
	
	Method isTunnelStart:Int()
		Return(fType = PROP_TUNNEL_START)
	End Method

	Method deactivate()
		Select fType
			Case PROP_TUNNEL_START
				gInTunnel = True
				
			Case PROP_TUNNEL_END
				gInTunnel = False
		End Select
		fActive = False
	End Method
End Type
