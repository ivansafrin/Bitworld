
class "Intro" (Scene)


function Intro:Intro()
        Scene.Scene(self)

        self.introScreen = Screen()

        self.tigsLabel = ScreenLabel("TIGSOURCE ASSEMBLEE COMPETITION", 34, "main")
        self.tigsLabel.x = (800-self.tigsLabel:getWidth())/2
        self.tigsLabel.y = (600-self.tigsLabel:getHeight())/2
        self.introScreen:addChild(self.tigsLabel)
        self.tigsLabel:setColor(1,1,1,0)

        self.presents = ScreenLabel("PRESENTS", 34, "main")
        self.presents.x = (800-self.presents:getWidth())/2
        self.presents.y = (600-self.presents:getHeight())/2
        self.introScreen:addChild(self.presents)
        self.presents:setColor(1,1,1,0)

        self.gameBy = ScreenLabel("A GAME BY IVAN SAFRIN", 34, "main")
        self.gameBy.x = (800-self.gameBy:getWidth())/2
        self.gameBy.y = (600-self.gameBy:getHeight())/2
        self.introScreen:addChild(self.gameBy)
        self.gameBy:setColor(1,1,1,0)


        self.credits = ScreenEntity()
        self.introScreen:addChild(self.credits)
        self.credits:setColor(1,1,1,0)

        local tempLabel = ScreenLabel("WITH GRAPHICS BY ODDBALL,ORYX AND RYNEN10K", 34, "main")
        tempLabel.x = (800-tempLabel:getWidth())/2
        tempLabel.y = (500-tempLabel:getHeight())/2
        self.credits:addChild(tempLabel)

        tempLabel = ScreenLabel("MUSIC BY BLOT AND SAROS", 34, "main")
        tempLabel.x = (800-tempLabel:getWidth())/2
        tempLabel.y = ((500-tempLabel:getHeight())/2) + 40
        self.credits:addChild(tempLabel)

        tempLabel = ScreenLabel("SFX BY STIAN STARK AND BIGLON", 34, "main")
        tempLabel.x = (800-tempLabel:getWidth())/2
        tempLabel.y = ((500-tempLabel:getHeight())/2) + 80
        self.credits:addChild(tempLabel)

        self.blockRect = ScreenShape(ScreenShape.SHAPE_RECT,800, 600,0,0)
        self.blockRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
        self.introScreen:addChild(self.blockRect)
        self.blockRect:setColor(0,0,0,0)
    
        self.introTimeline = 0

        self.wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 3,9,0)
        self.wall:Translate(-1,2,-1)
        self.wall:setMaterialByName("IntroWall")
        self:addChild(self.wall)

       self.particleEmitter = SceneParticleEmitter("SparkParticle", self, Particle.BILLBOARD_PARTICLE, ParticleEmitter.CONTINUOUS_EMITTER,
							15.8, 70, Vector3(0,0,0), Vector3(0,-0.4,0), Vector3(0,0,0), Vector3(0,0,0))
    
        self.particleEmitter:setBlendingMode(Renderer.BLEND_MODE_LIGHTEN)
 
        self.particleEmitter:getEmitter().colorCurveR:addControlPoint2d(0,1)
        self.particleEmitter:getEmitter().colorCurveR:addControlPoint2d(100,1)

        self.particleEmitter:getEmitter().colorCurveG:addControlPoint2d(0,0.5)
        self.particleEmitter:getEmitter().colorCurveG:addControlPoint2d(20,0.3)
        self.particleEmitter:getEmitter().colorCurveG:addControlPoint2d(100,0)

        self.particleEmitter:getEmitter().colorCurveB:addControlPoint2d(0,0.4)
        self.particleEmitter:getEmitter().colorCurveB:addControlPoint2d(20,0)
        self.particleEmitter:getEmitter().colorCurveB:addControlPoint2d(100,0)

        self.particleEmitter:getEmitter().colorCurveA:addControlPoint2d(0,1)
        self.particleEmitter:getEmitter().colorCurveA:addControlPoint2d(40,1)
        self.particleEmitter:getEmitter().colorCurveA:addControlPoint2d(100,0)

        self.particleEmitter:getEmitter().scaleCurve:addControlPoint2d(0,0.04)
        self.particleEmitter:getEmitter().scaleCurve:addControlPoint2d(20,0.02)
        self.particleEmitter:getEmitter().scaleCurve:addControlPoint2d(60,0.02)
        self.particleEmitter:getEmitter().scaleCurve:addControlPoint2d(100,0.0)

		self.particleEmitter:getEmitter().useScaleCurves = true
		self.particleEmitter:getEmitter().useColorCurves = true

        self.particleEmitter:getEmitter():enablePerlin(true)
        self.particleEmitter:getEmitter():setPerlinModSize(2)
        self.particleEmitter:getEmitter():setRotationSpeed(200)
        self:addChild(self.particleEmitter)

        self.particleEmitter:getEmitter().particleSpeedMod = 0.5

       self.particleEmitter:getEmitter():setEmitterRadius(Vector3(1,1,1))
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
