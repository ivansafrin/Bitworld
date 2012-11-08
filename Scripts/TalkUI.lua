
class "TalkUI" (Screen)

function TalkUI:TalkUI()
    Screen.Screen(self)

    local rect = ScreenShape(ScreenShape.SHAPE_RECT, 800, 100, 0,0)
    rect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
    rect.position.y = 600 - 80
    rect:setColor(0,0,0,1)
    self:addChild(rect)

    self.blinkRect = ScreenShape(ScreenShape.SHAPE_RECT, 16, 16, 0,0)
    self.blinkRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)
    self.blinkRect.position.y = (600 - 100) + 25 + 25 + 19
    self:addChild(self.blinkRect)


    self.nameLabel = ScreenLabel("GARBUNKLE", 34, "main")
    self.nameLabel.position.x = 25
    self.nameLabel.position.y = (600 - 100) + 25
    self:addChild(self.nameLabel)
    self.nameLabel:setColor(1,1,1,0.5)

    self.textLabel = ScreenLabel("I AM SAYING SOME CRAZY CRAP!!!", 34, "main")
    self.textLabel.position.x = 25
    self.textLabel.position.y = (600 - 100) + 25 + 25
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

    self.nameLabel.position.x = 25
    self.nameLabel.position.y = (600 - 100) + 25

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
