
class "TalkUI" (Scene)

function TalkUI:TalkUI()
    Scene.Scene(self, Scene.SCENE_2D)
	self:getDefaultCamera():setOrthoSize(0.0, 160)

    local rect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 360, 80)
    rect:setColor(0,0,0,1)
    self:addChild(rect)

    self.blinkRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 16, 16)
    self:addChild(self.blinkRect)

    self.nameLabel = SceneLabel("GARBUNKLE", 8, "main")
    self:addChild(self.nameLabel)
    self.nameLabel:setColor(1,1,1,0.5)

    self.textLabel = SceneLabel("I AM SAYING SOME CRAP!!!", 8, "main")
    self:addChild(self.textLabel)

    self.currentLine = 0
    self.typeTimer = 0
    self.printing = false
    self.currentPrinting = nil
    self.printChar = 1

    self.shownLine = ""
end

function TalkUI:talkToNPC(npc)
    self.currentLine = 0
    talkTip.enabled = false
    self.enabled = true

    if npc.onlytalk ~= nil then
        if npc.onlytalk ~= player.playerClass then
            self.speechlines = npc.nospeechlines
        else
            self.speechlines = npc.speechlines
        end
    else
        self.speechlines = npc.speechlines
    end

    self.nameLabel:setText(npc.name)

    self.nameLabel:setPositionX(25)
    self.nameLabel:setPositionY((600 - 100) + 25)

    talking = true
    self:Progress()
end

function TalkUI:Update(e)
    self.typeTimer = self.typeTimer + e
    if self.typeTimer > 0.03 then
        self:Type()
        self.typeTimer = 0
    end
end

function TalkUI:Type()
    if self.blinkRect.visible == true then
        self.blinkRect.visible = false
    else
        self.blinkRect.visible = true
    end 

    if self.printing == true then
        typeSound:Play()
        self.printChar = self.printChar + 1
        self.shownLine = string.sub(self.currentPrinting,0,self.printChar)
        self.textLabel:setText(self.shownLine)
        self.textLabel:setPositionX(25)
        self.textLabel:setPositionY((600 - 100) + 25 + 25)
        self.blinkRect:setPositionX(25 + self.textLabel:getWidth()+2)
        if #self.shownLine == #self.currentPrinting then
            self.printing = false
        end
    end
end

function TalkUI:Progress()
    self.currentLine = self.currentLine + 1
    if self.currentLine > #self.speechlines then
        talking = false
        self.enabled = false
    else
        self.printing = true
        self.printChar = 1
        self.currentPrinting = self.speechlines[self.currentLine]
    end
end
