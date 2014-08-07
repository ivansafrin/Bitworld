
require "Scripts/MainMenu"

class "HUD" (Scene)

function HUD:HUD()
    Scene.Scene(self, Scene.SCENE_2D)
	self:getDefaultCamera():setOrthoSize(0.0, 160)

	self.gameHUD = Entity()
	self:addChild(self.gameHUD)
	self.gameHUD.visible = false

	self.exitLabel = SceneLabel("PRESS RETURN TO EXIT TO NEXT LEVEL", 8, "main")
    self.gameHUD:addChild(self.exitLabel)

    self.exitLabel2 = SceneLabel("PRESS RETURN TO ENTER THE FORTRESS", 8, "main")
    self.gameHUD:addChild(self.exitLabel2)    

    self.goldLabel = SceneLabel("GOLD 0", 8, "main")
    self.gameHUD:addChild(self.goldLabel)
	self.goldLabel:setAnchorPoint(Vector3(-1.0, 1.0, 0.0))
    self.goldLabel:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
    self.goldLabel.alphaTest = true
    self.hearts = {}
  
    for i=0,7 do
        image = SceneImage("Resources/gfx/heart.png")
		image:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
		image:setAnchorPoint(Vector3(-1.0, 1.0, 0.0))
		image.alphaTest = true
        self.gameHUD:addChild(image)    
        self.hearts[i] = image
    end

	self.flashVal = 0.0

    self.powerRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE,100,10)
	self.powerRect:setAnchorPoint(Vector3(-1.0, 1.0, 0.0))
    self.powerRect:setColor(1,1,1,0.6)
    self.gameHUD:addChild(self.powerRect)

	self.mainMenu = MainMenu()
	self:addChild(self.mainMenu)

	self.flashRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE,160*2,160)
    self:addChild(self.flashRect)
    self.flashRect:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
    self.flashRect.depthTest = false
    self.flashRect.depthWrite = false
	self:Reposition()

	self.faderRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 160*2, 160)
	self.faderRect.depthTest = false
	self.faderRect.depthWrite = false
	self.faderRect:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
	self:addChild(self.faderRect)
	self.faderRect:setColor(0,0,0,0)
	self.faderVal = 0
	self.fadingIn = false
	self.fadingOut = false
	self.fadeSpeed = 0.4
	self.flashColor = Color(1.0, 1.0, 1.0, 1.0)
end

function HUD:showGameHUD(val)
	self.gameHUD.visible = val
end

function HUD:Clear()
	self.faderRect:setColor(0,0,0,0)
end

function HUD:fadeIn()
	self.faderVal = 1
	self.faderRect:setColor(0,0,0,1)
	self.fadingIn = true
end

function HUD:fadeOut(fspeed,endFunc)
	self.onFadeEnd = endFunc
	self.fadeSpeed = fspeed
	self.faderVal = 0
	self.faderRect:setColor(0,0,0,0)
	self.fadingIn = false
	self.fadingOut = true
end

function HUD:setMaxHP(maxHP)
    for i=0,7 do
        local heart = self.hearts[i]
        if maxHP > i then            
            heart.visible = true
        else
            heart.visible = false
        end
    end
end

function HUD:updateHP(hp)
    for i=0,7 do
        local heart = self.hearts[i]
        if hp > i then            
            heart:setColor(1,1,1,1)
        else
            heart:setColor(1,1,1,0.25)
        end
    end
end

function HUD:Reposition()
	local aspect = Services.Core:getXRes()/Services.Core:getYRes()
	self.goldLabel:setPosition(-70 * aspect, 72)

    for i=0,7 do
        local heart = self.hearts[i]
		heart:setPosition(-70 * aspect + (9 * i), 65)
	end

	self.powerRect:setPosition(-70 * aspect, 56)
end

function HUD:updateGold(gold)
    self.goldLabel:setText("GOLD "..gold)
end

function HUD:Update(e)
    self.flashRect:setColor(self.flashColor.r, self.flashColor.g, self.flashColor.b, self.flashVal)
	self.flashVal = self.flashVal - (e * 2.0)

	-- If we're fading out the screen, update the fade value based on time elapsed and check if we're done fading out.
	if self.fadingOut == true then
		self.faderVal = self.faderVal + (e * self.fadeSpeed)
		if self.faderVal > 1 then
			self.fadingOut = false
			self.faderVal = 1
			if self.onFadeEnd ~= nil
				then self.onFadeEnd()
			end
		end
	end

	if self.fadingIn == true then
		self.faderVal = self.faderVal - (e * 0.4)
		if self.faderVal < 0 then
			self.faderVal = 0
		end
	end
	self.faderRect:setColor(0,0,0,self.faderVal)
end
