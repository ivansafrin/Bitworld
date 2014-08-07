-- Character selection screen

class "CharPicker" (Scene)

function CharPicker:CharPicker()
    Scene.Scene(self, Scene.SCENE_3D)
    self.pickerScreen = Scene(Scene.SCENE_2D)
	self.archerLabel = SceneLabel("ARCHER (HARD)", 64, "main")
    self.archerLabel:setPositionX((800-self.archerLabel:getWidth())/2)
    self.archerLabel:setPositionY((300-self.archerLabel:getHeight())/2)
    self.pickerScreen:addChild(self.archerLabel)

    self.knightLabel = SceneLabel("KNIGHT (EASY)", 64, "main")
    self.knightLabel:setPositionX((800-self.knightLabel:getWidth())/2)
    self.knightLabel:setPositionY((300-self.knightLabel:getHeight())/2)
    self.pickerScreen:addChild(self.knightLabel)

    self.wizardLabel = SceneLabel("WIZZARD (MEDIUM)", 64, "main")
    self.wizardLabel:setPositionX((800-self.wizardLabel:getWidth())/2)
    self.wizardLabel:setPositionY((300-self.wizardLabel:getHeight())/2)
    self.pickerScreen:addChild(self.wizardLabel)

    self.pickerScreen.enabled = false

    self.ambientColor.r = 1
    self.ambientColor.g = 1
    self.ambientColor.b = 1

    self.rotator = Entity()
    self:addChild(self.rotator)

    self:getDefaultCamera():setPosition(0.01,0.1,0.6)
    self:getDefaultCamera():lookAt(Vector3(0.01,0,0), Vector3(0,1,0))
    self:getDefaultCamera().fov = 65

    self.wizard = Creature(84)
    self.rotator:addChild(self.wizard)
    self.wizard:setPosition(-0,0,0.25)
    self.wizard.shadow.visible = false

    self.archer = Creature(6)
    self.rotator:addChild(self.archer)
    self.archer:setPosition(0.25,0,-0.25)
    self.archer.shadow.visible = false

    self.knight = Creature(34)
    self.rotator:addChild(self.knight)
    self.knight:setPosition(-0.25,0,-0.25)
    self.knight.shadow.visible = false

    self.choice = 1

end

function CharPicker:Update(e)
    self.archer:Update(e)
    self.wizard:Update(e)
    self.knight:Update(e)

    self.rotator:setYaw(self.choice*115)

    self.archerLabel.visible = false
    self.knightLabel.visible = false
    self.wizardLabel.visible = false

    if self.choice == 0 then
        self.wizardLabel.visible = true
        playerClass = "wizard"
    elseif self.choice == 1 then
        self.knightLabel.visible = true
        playerClass = "knight"
    else
        self.archerLabel.visible = true
        playerClass = "archer"
    end
end
