
class "HUD" (Screen)

function HUD:HUD()
    Screen.Screen(self)

    self.exitLabel = ScreenLabel("PRESS RETURN TO EXIT TO NEXT LEVEL", 34, "main")
    self.exitLabel.x = (800-self.exitLabel:getWidth())/2
    self.exitLabel.y = (300-self.exitLabel:getHeight())/2
    self:addChild(self.exitLabel)


    self.exitLabel2 = ScreenLabel("PRESS RETURN TO ENTER THE FORTRESS", 34, "main")
    self.exitLabel2.x = (800-self.exitLabel2:getWidth())/2
    self.exitLabel2.y = (300-self.exitLabel2:getHeight())/2
    self:addChild(self.exitLabel2)    


    self.label = ScreenLabel("FPS: 90", 34, "main")
    self.label.x = 700
    self.label.y = -15
    self:addChild(self.label)
    self.label:setColor(1,1,1,0.5)
    self.label.visible = false

    self.goldLabel = ScreenLabel("GOLD:", 34, "main")
    self.goldLabel.x = 5
    self.goldLabel.y = -15
    self:addChild(self.goldLabel)


    self.hearts = {}
  
    for i=0,7 do
        image = ScreenImage("Resources/gfx/ass_item_tran.png")
        image:setImageCoordinates(5*8,3*8,8,8)
        image.xscale = 2
        image.yscale = 2  
        image.x = 5 + (18 * i)
        image.y = 20
        self:addChild(image)    
        self.hearts[i] = image
    end
  
    self.weaponImage = ScreenImage("Resources/gfx/ass_item_tran.png")
--    self.weaponImage:setImageCoordinates(0,0,8,8)
    self.weaponImage:setImageCoordinates(6*8,1*8,8,8)
    self.weaponImage.xscale = 2
    self.weaponImage.yscale = 2  
    self.weaponImage.x = 5
    self.weaponImage.y = 40
    self.weaponImage.visible = false
    self:addChild(self.weaponImage)

    local rect = ScreenShape(ScreenShape.SHAPE_RECT,100,2,0,0)
    rect.x = 5+50
    rect.y = 40
    self:addChild(rect)

    rect = ScreenShape(ScreenShape.SHAPE_RECT,100,2,0,0)
    rect.x = 5+50
    rect.y = 50
    self:addChild(rect)

    rect = ScreenShape(ScreenShape.SHAPE_RECT,2,10,0,0)
    rect.x = 5
    rect.y = 45
    self:addChild(rect)

    rect = ScreenShape(ScreenShape.SHAPE_RECT,2,10,0,0)
    rect.x = 5+100
    rect.y = 45
    self:addChild(rect)

    self.powerRect = ScreenShape(ScreenShape.SHAPE_RECT,100,10,0,0)
    self.powerRect.x = 5
    self.powerRect.y = 40
    self.powerRect:setColor(1,1,1,0.6)
    self:addChild(self.powerRect)

    self.powerRect:setPositionMode(ScreenEntity.POSITION_TOPLEFT)

end

function HUD:createMinimap(level)
--    image = Tau.Image(192,192)
--    image:fill(1,1,0,1)     
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

function HUD:updateGold(gold)
    self.goldLabel:setText("GOLD:"..gold)
    self.goldLabel.x = 5
end

function HUD:Update(e)    
   -- self.label:setText("FPS:"..CORE:getFPS())
end
