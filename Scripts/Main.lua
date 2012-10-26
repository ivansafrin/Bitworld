-- Bitworld by Ivan Safrin.
-- Released under the MIT license as an example for the Polycode Framework.

require "Scripts/Prop"
require "Scripts/CreatureLibrary"
require "Scripts/VillageMap"
require "Scripts/FinalLevelMap"
require "Scripts/Creature"
require "Scripts/CharPicker"
require "Scripts/LevelStructure"
require "Scripts/Level"
require "Scripts/Intro"
require "Scripts/Player"
require "Scripts/HUD"
require "Scripts/TalkUI"

-- Set the texture filtering mode to "nearest" so that pixelart doesnt get blurry
Services.Renderer:setTextureFilteringMode(Renderer.TEX_FILTERING_NEAREST)

-- Register our font under the name "main"
Services.FontManager:registerFont("main", "Resources/fonts/fatkiddl2.ttf")

-- Game globals
firstFrame = false
gameLoaded = false
playerHP = 8
playerClass = "wizard"

talkUI = TalkUI()
talkUI.enabled = false
talking = false
talkToNPC = nil
talkTip = Screen()
local rect = ScreenShape(ScreenShape.SHAPE_RECT, 800, 40, 0,0)
rect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
rect.position.y = 600 - 40
rect:setColor(0,0,0,1)
talkTip:addChild(rect)
local tipLabel = ScreenLabel("PRESS X TO TALK!", 34, "main")
tipLabel.position.x = (800-tipLabel.width)/2
tipLabel.position.y = 600 - 45
talkTip:addChild(tipLabel)
talkTip.enabled = false


menuScreen = Screen()

local mRect = ScreenShape(ScreenShape.SHAPE_RECT,230, 600,0,0)
mRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
menuScreen:addChild(mRect)
mRect:setColor(0,0,0,1)

mRect = ScreenShape(ScreenShape.SHAPE_RECT,230, 600,0,0)
mRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
menuScreen:addChild(mRect)
mRect:setColor(0,0,0,1)
mRect:setPosition(800-230,0)


menuSelectRect = ScreenShape(ScreenShape.SHAPE_RECT,305, 26,0,0)
menuSelectRect:setPosition(250,100)
menuSelectRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
menuScreen:addChild(menuSelectRect)
menuSelectRect:setColor(1,1,1,0.2)


titleLabel = ScreenLabel("BITWORLD", 80, "main")
titleLabel.position.x = (800-titleLabel.width)/2
titleLabel.position.y = (200-titleLabel.height)/2
menuScreen:addChild(titleLabel)


startLabel = ScreenLabel("NEW GAME", 34, "main")
startLabel:setPositionX((800-startLabel:getWidth())/2)
startLabel:setPositionY(titleLabel:getPosition().y + 80)
startLabel:setColor(1,1,1,0.75)
menuScreen:addChild(startLabel)

exitLabel = ScreenLabel("EXIT GAME", 34, "main")
exitLabel:setPositionX((800-exitLabel:getWidth())/2)
exitLabel:setPositionY(startLabel:getPosition().y + 30)
exitLabel:setColor(1,1,1,0.75)
menuScreen:addChild(exitLabel)

menuChoice = 0 
menuScreen.enabled = false


hud = HUD()

fadeSpeed = 0.4

loadingScreen = Screen()

loadingBlock = ScreenShape(ScreenShape.SHAPE_RECT,800,600,0,0)
loadingBlock:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
loadingScreen:addChild(loadingBlock)
loadingBlock:setColor(0,0,0,1)

loading1 = ScreenImage("Resources/gfx/loading1.png")
loading1:setPositionX((800-loading1:getWidth())/2)
loading1:setPositionY((600-loading1:getHeight())/2)
loadingScreen:addChild(loading1)

loading2 = ScreenImage("Resources/gfx/loading2.png")
loading2:setPositionX((800-loading2:getWidth())/2)
loading2:setPositionY((600-loading2:getHeight())/2)
loadingScreen:addChild(loading2)

loading3 = ScreenImage("Resources/gfx/loading3.png")
loading3:setPositionX((800-loading3:getWidth())/2)
loading3:setPositionY((600-loading3:getHeight())/2)
loadingScreen:addChild(loading3)

loadingImages = {loading1, loading2, loading3}

showingFinalCutscene = false

shakeHard = false

rollingCredits = false


creditsScreen = Screen()
creditsAnchor = ScreenEntity()

local creditRect = ScreenShape(ScreenShape.SHAPE_RECT,800, 600,0,0)
creditRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
creditsScreen:addChild(creditRect)
creditRect:setColor(0,0,0,1)


creditsScreen:addChild(creditsAnchor)

creditLines = {"","BITWORLD","","","BUILT USING","POLYCODE","FOR THE TIGSOURCE","ASSEMBLEE COMPETITION",
"","GAME DESIGN AND PROGRAMMING","IVAN SAFRIN","","GRAPHICS","ODDBALL + ORYX","","FONT DESIGN","RYNEN10K","","MUSIC","BLOT AND SAROS",
 "", "SOUND EFFECTS","STIAN STARK AND BIGLON","","","TESTING AND FEEDBACK","","NAUMAN HAFIZ","ADAM ATOMIC","KENTA TOHARA","MARK JOHNS",
"","","SHOUTOUTS TO THE GOOD PEOPLE OF","TIGSOURCE","","","","","","","","THANK YOU FOR PLAYING"}

for i=1,#creditLines do
	local creditLabel = ScreenLabel(creditLines[i], 34, "main")
	creditLabel.x = (800-creditLabel:getWidth())/2
	creditLabel.y = i*32
	creditsAnchor:addChild(creditLabel)
end

creditsScreen.enabled = false
rollingCredits = false

faderScreen = Screen()
faderRect = ScreenShape(ScreenShape.SHAPE_RECT,800, 600,0,0)
faderRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
faderScreen:addChild(faderRect)
faderRect:setColor(0,0,0,0)
faderVal = 0
fadingIn = false

function endCredits()
	shakeHard = false
	villageMusic:Stop(true)	
	creditsScreen.enabled = false
	rollingCredits = false
	showingFinalCutscene = false
	hud.enabled = false
	restartGame()
end

function scrollCredits()
	rumblingSound:Stop()
	villageMusic:Play(true)
	creditsScreen.enabled = true
	rollingCredits = true
	creditsAnchor.y = 600 + 20
end

function doGameEnd()
	showingFinalCutscene = true
	level.player:setSpeed(0,0)	
	music:Stop()
	rumblingSound:Play(false)
	shakeHard = true
	fadeOut(0.1, scrollCredits)
end

function showLoadingScreen()
	for i=1,#loadingImages do
		local image = loadingImages[i]
		image.visible = false
	end
	local newImage = loadingImages[random(#loadingImages)]
	newImage.visible = true
	loadingScreen.enabled = true
end

showLoadingScreen()

gameOverScreen = Screen()

blockRect = ScreenShape(ScreenShape.SHAPE_RECT,800, 600,0,0)
blockRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
gameOverScreen:addChild(blockRect)

label = ScreenLabel("YOU HAVE DIED..", 34, "main")
label.x = (800-label:getWidth())/2
label.y = (600-label:getHeight())/2
gameOverScreen:addChild(label)

gameOverScreen.enabled = false

isGameOver = false
gameOverTimer = 0

charging = false
showingIntro = false

showingVillage = false

levelIndex = 1
intro = nil

playerGold = 0 

loadMapNextFrame = false

villageLevel = nil

villageCamCurve = BezierCurve()

villageCamCurve:addControlPoint3d(2.2,0.3,0)
villageCamCurve:addControlPoint3d(0,0.5,-2.2)
villageCamCurve:addControlPoint3d(-2.2,0.2,0)
villageCamCurve:addControlPoint3d(0,0.5,2.2)
villageCamCurve:addControlPoint3d(2.2,0.3,0)

camCurveVal = 0.6

onExit = false
onFadeEnd = nil

fadingOut = false

levelRotate = false
levelRotateVal = 0
levelRotateSound = Sound("Resources/sfx/levelRotate.wav")

showingCharPicker = false



function initGame()
	Services.ResourceManager:addDirResource("Resources/gfx", false)
	Services.ResourceManager:addDirResource("Resources/shaders", false)
	Services.ResourceManager:addDirResource("Resources/materials", false)

	alertSound = Sound("Resources/sfx/alert.wav")  
	whereSound = Sound("Resources/sfx/where.wav")  

	jumpSound = Sound("Resources/sfx/jump03.wav")	
	hurtSound = Sound("Resources/sfx/ouch.wav")
	dummyHurtSound = Sound("Resources/sfx/dummyHurt.wav")
	attackSound = Sound("Resources/sfx/slash.wav")
	arrowShootSound = Sound("Resources/sfx/shieldDown.wav")

	rumblingSound = Sound("Resources/sfx/rumbling.wav")

	heartPickupSound = Sound("Resources/sfx/heartPickup.wav")
	goldPickupSound = Sound("Resources/sfx/goldPickup.wav")

	shieldHitSound = Sound("Resources/sfx/shieldHit.wav")
	shieldUpSound = Sound("Resources/sfx/shieldUp.wav")
	shieldDownSound = Sound("Resources/sfx/shieldDown.wav")

	cloakSound = Sound("Resources/sfx/cloak.wav")
	uncloakSound = Sound("Resources/sfx/uncloak.wav")

	typeSound = Sound("Resources/sfx/type.wav")

	arrowChargeSound = Sound("Resources/sfx/arrowCharge.wav")
	introMusic = Sound("Resources/music/intro.ogg")
	villageMusic = Sound("Resources/music/village.ogg")

	music = introMusic

		musics = {}
		music = Sound("Resources/music/dungeon01.ogg")
		musics[0] = music
		music = Sound("Resources/music/dungeon02.ogg")
		musics[1] = music

		gameoverMusic = Sound("Resources/music/gameover.ogg")
		--gameoverMusic = music

end

function pickChars()
	faderRect:setColor(0,0,0,0)
	menuScreen.enabled = false
	Services.Renderer:setClearColor(0.1,0.1,0.1)
	showingVillage = false
	villageLevel.enabled = false
	charPicker.enabled = true
	charPicker.pickerScreen.enabled = true
	showingCharPicker = true
end

function initLevel()

	paused = false
	--math.randomseed(Services.Core:getTicks())
	--math.randomseed(80085)	
	hud.enabled = false

	villageLevel = Level("village", "VillageSkin", {})
	villageLevel.ambientColor.r = 0.7
	villageLevel.ambientColor.g =  0.65
	villageLevel.ambientColor.b =  0.6

	villageCam = villageLevel:getDefaultCamera()
	--villageCam:setPostFilter("Pixellate")

	villageLevel.enabled = false

	charPicker = CharPicker()
	charPicker.enabled = false

	introDone()
	--showIntro()
end

function showVillageLevel()
	villageLevel.enabled = true
	showingVillage = true
	Services.Renderer:setClearColor(0.4,0.6,0.7)
end

function fadeIn()
	faderVal = 1
	faderRect:setColor(0,0,0,1)
	fadingIn = true
end

function fadeOut(fspeed,endFunc)
	onFadeEnd = endFunc
	fadeSpeed = fspeed
	faderScreen.enabled = true
	faderVal = 0
	faderRect:setColor(0,0,0,0)
	fadingIn = false
	fadingOut = true
end

function introDone()
	if intro ~= nil then 
		intro.introScreen.enabled = false
		intro.enabled = false
	end

	menuScreen.enabled = true
	showVillageLevel()
	fadeIn()
end

function showIntro()
	Services.Renderer:setClearColor(0,0,0)
	intro = Intro()
	showingIntro = true
end

function updateVillageCam(e)
	villageLevel:Update(e)
	camCurveVal = camCurveVal + e*0.005
	if camCurveVal > 1 then camCurveVal = 0 end
	local pos =  villageCamCurve:getPointAt(camCurveVal)
	villageCam:setPosition(pos.x, pos.y, pos.z) 
	villageCam.fov = 65
	villageCam:lookAt(Vector3(0,0,0), Vector3(0,1,0))
end

function createNewLevel()

	levelRotate = false

	hud.enabled = true
	local levelTemplate = levelStructure[levelIndex]
	print(levelTemplate.caption)

	level = Level(levelTemplate.type,levelTemplate.skin, levelTemplate.creatures)

	if levelTemplate.hasFire == true then
		level:createFire()
	end
	
	camPerlin = Perlin(3,5,1.0,random())
	perlinPosition = 0

	camera = level.defaultCamera
	camera.fov = 65
--	camera:setPostFilter("Pixellate")

	levelLoaded = true

	player = Player(playerClass)
	level:addChild(player)
	player.level = level

	hud:createMinimap(level)

	player.HP = playerHP
	player.maxHP = playerMaxHP

	player.gold = playerGold

	level.player = player

	level.__cbody.ambientColor.r = levelTemplate.ambientR
	level.__cbody.ambientColor.g = levelTemplate.ambientG
	level.__cbody.ambientColor.b = levelTemplate.ambientB

	RENDERER:setClearColor(levelTemplate.fogR/255.0,levelTemplate.fogG/255.0,levelTemplate.fogB/255.0)

	light = SceneLight(AREA_LIGHT, 1.05,0.14,level)
	light:setLightColor(1,0.9,0.8)
	level:addLight(light)
	player.bodyAnchor:addChild(light)
	light:Translate(0,0.15,0)

	local pos = level:tileToPosition(level.levelStartX-1, level.levelStartY)
	player:setPosition(pos.x, 0,pos.y)

	onExit = false

	music:Stop()
	music = musics[levelTemplate.musicIndex]
	music:Play(false)
end

function loadFirstDungeonLevel()
	villageMusic:Stop()

	villageLevel.__cbody:removeEntity(player.__cbody)
	villageLevel.player = nil	
	villageLevel.__cbody:setEnabled(false)
	levelIndex = 0
	playerHP = 7
	playerClass = "archer"
	loadNextLevel()
end

function restartGame()
	gameoverMusic:Stop()
	introMusic:Play(false)
	cleanCurrentLevel()
	isGameOver = false
	gameOverScreen.enabled = false
	showVillageLevel()
	menuScreen.enabled = true
end

function newGame()

	introMusic:Stop()
	villageMusic:Play(false)

	if playerClass == "wizard" then
		playerHP = 4
		hud:setMaxHP(4)
	elseif playerClass == "archer" then
		playerHP = 6
		hud:setMaxHP(6)
	else
		playerHP = 8		
		hud:setMaxHP(8)
	end

	playerMaxHP = playerHP

	charPicker.enabled = false
	charPicker.pickerScreen.enabled = false
	showingCharPicker = false

	showVillageLevel()
	showingVillage = false

	player = Player(playerClass)
	villageLevel:addChild(player)
	player.level = villageLevel
	player.HP = playerHP
	player.maxHP = playerHP
	villageLevel.player = player

	camPerlin = Perlin(3,5,1.0,random())
	perlinPosition = 0

	camera = villageLevel:getDefaultCamera()
	camera.fov = 65

	levelLoaded = true
	level = villageLevel
	hud.enabled = true
end

function doGameOver()
		music:Stop()
		gameoverMusic:Play(true)
		hud.enabled = false
		gameOverScreen.enabled = true
		isGameOver = true
		blockRect:setColor(0,0,0,0)
		gameOverTimer = 0
end

function loadNextLevel()
	   playerHP = player.HP
		playerGold = player.gold
	   playerClass = player.playerClass
		music:Stop()
		gameoverMusic:Stop()
	cleanCurrentLevel()
	music:Stop()
	hud.enabled = false
	showLoadingScreen()
	loadMapNextFrame = true
	levelIndex = levelIndex+1
end

function cleanCurrentLevel()
	levelLoaded = false
	level.__cbody:setEnabled(false)
	level = nil
	player = nil
	collectgarbage("collect")
end

function onKeyDown(key)

	if rollingCredits == true then
		if key == KEY_ESCAPE then
			fadeOut(0.3,endCredits)
		end
	end

	if showingFinalCutscene == true then
		return
	end

	if talking == true then
		if key == KEY_x or key == KEY_RETURN or key == KEY_SPACE then
			talkUI:Progress()
		end
		return
	end

	if showingIntro == true then 
		if key == KEY_RETURN or key == KEY_ESCAPE or key == KEY_SPACE then
			intro.introTimeline = 27
			intro.blockFadeSpeed = 1
			intro.nextEvent = 28
			Intro_ShowBlock()
		end
		return
	end

	if menuScreen.enabled == true then
		if key == KEY_DOWN then
			menuChoice = menuChoice + 1
			if menuChoice > 1 then
			   menuChoice = 0 
			end
		elseif key == KEY_UP then
			menuChoice = menuChoice - 1
			if menuChoice < 0 then
			   menuChoice = 1 
			end
		elseif key == KEY_RETURN then
			if menuChoice == 0 then
				pickChars()
			elseif menuChoice == 1 then
				Services.Core:Shutdown()
			end
		end
		return
	end

	if showingCharPicker == true then
		if key == KEY_LEFT then
			charPicker.choice = charPicker.choice + 1
			if charPicker.choice > 2 then
				charPicker.choice = 0
			end
		elseif key == KEY_RIGHT then
			charPicker.choice = charPicker.choice - 1
			if charPicker.choice < 0 then
				charPicker.choice = 2
			end
		elseif key == KEY_RETURN then
			newGame()
		end
		return
	end

	if isGameOver == true then
		if gameOverTimer > 0.3 then
			if key == KEY_RETURN or key == KEY_SPACE then
				restartGame()
			end
		end
		return
	end

	if key == KEY_RETURN then
		if onExit == true then
			if level == villageLevel then
				loadFirstDungeonLevel()
			else
				loadNextLevel()
			end
			return			
		end
	end

	if key == KEY_b then
		loadNextLevel()
		return
	 end

  if player.dead == true or player.frozen == true then return end 

  if levelRotate == false then
  if key == KEY_UP then
	player:setSpeed(player.xSpeed,-player.speed)
  elseif key == KEY_DOWN then
	player:setSpeed(player.xSpeed,player.speed)
  elseif key == KEY_LEFT then
	player:setSpeed(-player.speed,player.zSpeed)
  elseif key == KEY_RIGHT then
	player:setSpeed(player.speed,player.zSpeed)
 end

	else

  if key == KEY_UP then
	player:setSpeed(-player.speed,player.zSpeed)
  elseif key == KEY_DOWN then
	player:setSpeed(player.speed,player.zSpeed)
  elseif key == KEY_LEFT then
	player:setSpeed(player.xSpeed,player.speed)
  elseif key == KEY_RIGHT then
	player:setSpeed(player.xSpeed,-player.speed)
 end

	end

   if key == KEY_c then
	player:jump()
  elseif key == KEY_x then   
	if talkToNPC ~= nil then
		talkUI:talkToNPC(talkToNPC)
	else
		player:primaryDown()
	end
  elseif key == KEY_z then
	player:secondaryDown()
  elseif key == KEY_p then
	paused = not paused
  elseif key == KEY_SPACE then
	if levelRotate == true then
		levelRotate = false
	else
		levelRotate = true
	end
	 levelRotateSound:Play(true)
	 player:setSpeed(0,0)
  end 
end

function onKeyUp(key)

	if showingFinalCutscene == true then return end

	if showingIntro == true then return end

  if menuScreen.enabled == true or showingCharPicker == true then return end

  if levelLoaded == false then
	return
  end

  if player.dead == true or player.frozen == true then return end

  if levelRotate == false then
  if key == KEY_UP then
	player:setSpeed(player.xSpeed,0)
  elseif key == KEY_DOWN then
	player:setSpeed(player.xSpeed,0)
  elseif key == KEY_LEFT then
	player:setSpeed(0,player.zSpeed)
  elseif key == KEY_RIGHT then
	player:setSpeed(0,player.zSpeed)
  end

  else

  if key == KEY_UP then
	player:setSpeed(0,player.zSpeed)
  elseif key == KEY_DOWN then
	player:setSpeed(0,player.zSpeed)
  elseif key == KEY_LEFT then
	player:setSpeed(player.xSpeed,0)
  elseif key == KEY_RIGHT then
	player:setSpeed(player.xSpeed,0)
  end

  end

  if key == KEY_z then
	player:secondaryUp()
  elseif key == KEY_x then
	player:primaryUp()
  end
end

function updateLevel(e)

	perlinPosition = perlinPosition + (e * 0.01)  

	if levelRotate == true then
		if levelRotateVal < 1 then
			levelRotateVal = levelRotateVal + 5 * e
		else
			levelRotateVal = 1
		end
	else
		if levelRotateVal > 0 then
			levelRotateVal = levelRotateVal - 5 * e
		else
			levelRotateVal = 0
		end
	end
	
	local camDistance = 1.1
	camera:setPosition(player:getPosition().x + ((camPerlin:Get(perlinPosition, 0) * 0.2)*(1-levelRotateVal)) + (levelRotateVal*camDistance),
	player:getPosition().y+(camDistance*0.75) + (camPerlin:Get(perlinPosition, 0) * 0.2) ,
	player:getPosition().z+(camDistance-(levelRotateVal*camDistance))+ ((camPerlin:Get(perlinPosition, 0) * 0.2)*(levelRotateVal))) 

	if shakeHard == true then
		perlinPosition = perlinPosition + (e * 0.5)  
		camera:lookAt(Vector3(player:getPosition().x+(camPerlin:Get(perlinPosition, 0)*0.3),
		player:getPosition().y+(camPerlin:Get(perlinPosition, 0.5)*0.3),
		player:getPosition().z+(camPerlin:Get(perlinPosition, 1)*0.3)))
	else
		camera:lookAt(player:getPosition(), Vector3(0,1,0))
	end


	if paused == true then
	else
		player:Update(e)
		hud:Update(e)
		level:Update(e)
	end
end

-- ******************************************************************
-- Main update function. The game is updated here on every frame.
-- ******************************************************************

function Update(e)

	-- If the credits are rolling, move the anchor entity of the credits up based on elapsed time.
	if rollingCredits == true then
		creditsAnchor.position.y = creditsAnchor.position.y - (e * 35)

		-- If the credits scroll past a certain point, fade out and end the credits.
		if creditsAnchor.position.y < -1376 then
			rollingCredits = false
			fadeOut(0.2,endCredits)
		end
	end

	-- If talking to a character, update the conversation UI.
	if talking == true then
		talkUI:Update(e)
	end

	-- If showing the character selector, update the character selector.
	if showingCharPicker == true then
		charPicker:Update(e)
		return
	end

	-- If showing the menu screen, set the menu selector position based on the current choice.
	if menuScreen.enabled == true then
		menuSelectRect.position.x = 262-20
		menuSelectRect.position.y = titleLabel.position.y + 95+(30*menuChoice)
	end

	-- If we're fading out the screen, update the fade value based on time elapsed and check if we're done fading out.
	if fadingOut == true then
		faderVal = faderVal + (e * fadeSpeed)
		if faderVal > 1 then fadingOut = false faderScreen.enabled = false faderVal = 1 if onFadeEnd ~= nil then onFadeEnd()  end end
	end

	if fadingIn == true then
		faderVal = faderVal - (e * 0.4)
		if faderVal < 0 then faderVal = 0 end
	end
	faderRect:setColor(0,0,0,faderVal)

	if showingVillage == true then
		updateVillageCam(e)		
	end

	if showingIntro == true then
		intro:Update(e)
	end

	if loadMapNextFrame == true then
		loadMapNextFrame = false
		createNewLevel()
		loadingScreen.enabled = false
		return
	end

	if isGameOver == true then
		gameOverTimer = gameOverTimer + e * 0.1
		blockRect:setColor(0,0,0,gameOverTimer)
	end

	if gameLoaded == false then
		if firstFrame == true then 
			initGame()
			initLevel()
			gameLoaded = true
			loadingScreen.enabled = false
		else
			firstFrame = true
		end
	else
		if levelLoaded == true then
		if player.archer == true then
			hud.powerRect.scale.x = player.arrowCharge/5
		elseif player.caster == true then
			hud.powerRect.scale.x = player.spellCharge/player.spellChargeMax
		else
			hud.powerRect.scale.x = 0
		end

		local pos = level:tileToPosition(level.levelEndX, level.levelEndY)

		local startVector = Vector3(pos.x,0,pos.y)

		if startVector:distance(player:getPosition()) < 0.1 then
			onExit = true
			if level == villageLevel then
				hud.exitLabel2.visible = true
			else
				hud.exitLabel.visible = true
			end
		else
			onExit = false
			hud.exitLabel.visible = false
			hud.exitLabel2.visible = false
		end
	
		hud:updateHP(player.HP)
		hud:updateGold(player.gold)
		updateLevel(e)
		else

		end
	end
end