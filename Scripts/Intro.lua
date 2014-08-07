
class "Intro" (Scene)


function Intro:Intro()
        Scene.Scene(self, Scene.SCENE_3D)

        self.introScreen = Scene(Scene.SCENE_2D)
		self.introScreen:getDefaultCamera():setOrthoSize(0.0, 160)

        self.tigsLabel = SceneLabel("TIGSOURCE ASSEMBLEE COMPETITION", 8, "main")
        self.introScreen:addChild(self.tigsLabel)
        self.tigsLabel:setColor(1,1,1,0)

        self.presents = SceneLabel("PRESENTS", 8, "main")
        self.introScreen:addChild(self.presents)
        self.presents:setColor(1,1,1,0)

        self.gameBy = SceneLabel("A GAME BY IVAN SAFRIN", 8, "main")
        self.introScreen:addChild(self.gameBy)
        self.gameBy:setColor(1,1,1,0)

        self.credits = Entity()
        self.introScreen:addChild(self.credits)
        self.credits:setColor(1,1,1,0)

        local tempLabel = SceneLabel("WITH GRAPHICS BY ODDBALL,ORYX AND RYNEN10K", 8, "main")
		tempLabel:setPositionY(-16)
        self.credits:addChild(tempLabel)

        tempLabel = SceneLabel("MUSIC BY BLOT AND SAROS", 8, "main")
        self.credits:addChild(tempLabel)

        tempLabel = SceneLabel("SFX BY STIAN STARK AND BIGLON", 8, "main")
		tempLabel:setPositionY(16)
        self.credits:addChild(tempLabel)

        self.blockRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE,1200, 600,0,0)
        self.introScreen:addChild(self.blockRect)
        self.blockRect:setColor(0,0,0,0)
		self.blockRect:setBlendingMode(Renderer.BLEND_MODE_NORMAL)    
		self.blockRect.depthWrite = false
		self.blockRect.depthTest = false
		self.blockRect:setBlendingMode(Renderer.BLEND_MODE_NORMAL)

        self.introTimeline = 0

        self.wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 5.0,10,0)
		self.wall.depthWrite = false
        self.wall:Translate(-0.9,2,-1)
        self.wall:setMaterialByName("IntroWall", Services.ResourceManager:getGlobalPool())
        self:addChild(self.wall)

		self.particleEmitter = SceneParticleEmitter(100, 6.0, 0.3)
		self.particleEmitter.depthTest = false

		self.particleEmitter:setParticleSize(0.025)
		self.particleEmitter:setParticleType(SceneParticleEmitter.PARTICLE_TYPE_QUAD)
		self.particleEmitter:setEmitterSize(Vector3(2.0, 0.0, 2.0))
		self.particleEmitter:setMaterialByName("SparkParticle", Services.ResourceManager:getGlobalPool())

		self.particleEmitter:setParticleDirection(Vector3(0.0, 2.0, 0.0))

		self.particleEmitter.colorCurveR:addControlPoint2d(0,1)
        self.particleEmitter.colorCurveR:addControlPoint2d(100,1)

        self.particleEmitter.colorCurveG:addControlPoint2d(0,0.5)
        self.particleEmitter.colorCurveG:addControlPoint2d(20,0.3)
        self.particleEmitter.colorCurveG:addControlPoint2d(100,0)

        self.particleEmitter.colorCurveB:addControlPoint2d(0,0.4)
        self.particleEmitter.colorCurveB:addControlPoint2d(20,0)
        self.particleEmitter.colorCurveB:addControlPoint2d(100,0)

        self.particleEmitter.colorCurveA:addControlPoint2d(0,1)
        self.particleEmitter.colorCurveA:addControlPoint2d(40,1)
        self.particleEmitter.colorCurveA:addControlPoint2d(100,0)

        self.particleEmitter.scaleCurve:addControlPoint2d(0,0.04)
        self.particleEmitter.scaleCurve:addControlPoint2d(20,0.02)
        self.particleEmitter.scaleCurve:addControlPoint2d(60,0.02)
        self.particleEmitter.scaleCurve:addControlPoint2d(100,0.0)

		self.particleEmitter.useScaleCurves = true
		self.particleEmitter.useColorCurves = true

		self.particleEmitter:setPerlinEnabled(true)
		self.particleEmitter:setPerlinValue(Vector3(2.0, 1.0, 2.0))

        self:addChild(self.particleEmitter)
		self.particleEmitter:setPosition(0,-1,0)

        self.camera = self:getDefaultCamera()
        self.camera:setPosition(0.5,1,1)
        self.camera:lookAt(Vector3(0,1,0), Vector3(0,1,0))

		introMusic:Play(true)

        self.blockFadeSpeed = 0.2

        self.nextEvent = 2
        self.nextEventFunc = Intro_showTigs
        self.currentLabel = nil
        self.currentLabelBrightness = 0

        self.currentFadingLabel = nil
        self.currentFadingLabelBrightness = 0

        self.showingBlock = false

end

function Intro_showTigs()
        intro.currentLabel = intro.tigsLabel
        intro.currentLabelBrightness = 0
        intro.nextEvent = 4
        intro.nextEventFunc = Intro_hideTigs
end

function Intro_showPresents()
        intro.currentLabel = intro.presents
        intro.currentLabelBrightness = 0
        intro.nextEvent = 10
        intro.nextEventFunc = Intro_hidePresents
end

function Intro_showGameBy()
        intro.currentLabel = intro.gameBy
        intro.currentLabelBrightness = 0
        intro.nextEvent = 18
        intro.nextEventFunc = Intro_hideGameBy
end

function Intro_showCredits()
        intro.currentLabel = intro.credits
        intro.currentLabelBrightness = 0
        intro.nextEvent = 24
        intro.nextEventFunc = Intro_hideCredits
end

function Intro_hideCredits()
        intro.currentLabel = nil
        intro.currentFadingLabel = intro.credits
        intro.currentFadingLabelBrightness = 1
        intro.nextEvent = 27
        intro.nextEventFunc = Intro_ShowBlock
end

function Intro_Done()
    showingIntro = false    
    introDone()
end

function Intro_ShowBlock()
        intro.showingBlock = true
        intro.nextEvent = 31
        intro.currentLabel = nil
        intro.currentFadingLabel = nil
        intro.currentFadingLabelBrightness = 0
        intro.nextEventFunc = Intro_Done
end

function Intro_hideGameBy()
        intro.currentLabel = nil
        intro.currentFadingLabel = intro.gameBy
        intro.currentFadingLabelBrightness = 1
        intro.nextEvent = 21
        intro.nextEventFunc = Intro_showCredits
end


function Intro_hidePresents()
        intro.currentLabel = nil
        intro.currentFadingLabel = intro.presents
        intro.currentFadingLabelBrightness = 1
        intro.nextEvent = 14
        intro.nextEventFunc = Intro_showGameBy
end


function Intro_hideTigs()
        intro.currentLabel = nil
        intro.currentFadingLabel = intro.tigsLabel
        intro.currentFadingLabelBrightness = 1
        intro.nextEvent = 6
        intro.nextEventFunc = Intro_showPresents
end

function Intro:Update(e)
    self.camera:Translate(0,e*0.12,0)
    self.introTimeline = self.introTimeline + (e)

    if self.introTimeline >= self.nextEvent then
        self.nextEventFunc()
    end
    
    if self.showingBlock == true then
        self.currentFadingLabelBrightness = self.currentFadingLabelBrightness + (e*self.blockFadeSpeed)
        self.blockRect:setColor(0,0,0,self.currentFadingLabelBrightness)
    end

    if self.currentLabel ~= nil then
        self.currentLabelBrightness = self.currentLabelBrightness + (e*0.5)
        self.currentLabel:setColor(1,1,1,self.currentLabelBrightness)
    end

    if self.currentFadingLabel ~= nil then
        self.currentFadingLabelBrightness = self.currentFadingLabelBrightness - (e*0.5)
        if self.currentFadingLabelBrightness < 0 then self.currentFadingLabelBrightness = 0 end
        self.currentFadingLabel:setColor(1,1,1,self.currentFadingLabelBrightness)
    end


end
