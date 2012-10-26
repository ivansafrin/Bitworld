
require "Scripts/Creature"

class "Player" (Creature)

function Player:Player(playerClass)

    self.playerClass = playerClass

    if playerClass == "archer" then
        Creature.Creature(self, 6)
        self.archer = true
        self.hasShield = false
        self.shield.visible = false
    elseif playerClass == "wizard" then
        Creature.Creature(self, 84)
        self.hasShield = false
        self.shield.visible = false
        self.caster = true
    else
        self.warrior = true
        Creature.Creature(self, 34)
        self.hasShield = true
        self.shield.visible = true
    end

    self.player = true
    self.collideWalls = true

    self.pcharging = false

    self.HP = 8
end

function Player:primaryDown()
    if self.archer == true then
        if self.pcharging == false then
            arrowChargeSound:Play(true)
            self.pcharging = true
            self.arrowCharge = 0.0
            self.charging = true
            if self.cloaked == true then
                self:Uncloak()
            end
        end
    elseif self.caster == true then
        if self.pcharging == false then
            arrowChargeSound:Play(true)
            self.pcharging = true
            self.spellCharge = 0.0
            self.spellCharging = true
            self.spellID = 0
            self.spellChargeMax = 4
        end
    else
        if self.blocking == false then
            self:attack()
        end
    end
end

function Player:primaryUp()
    if self.archer == true then
        if self.arrowCharge > 1 then
            self:shootArrow()        
        end
        self.pcharging = false
        arrowChargeSound:Stop()
        self.arrowCharge = 0.0
        self.charging = false
    elseif self.caster == true then
        self.pcharging = false
        arrowChargeSound:Stop()
        self.spellCharge = 0.0
        self.spellCharging = false
    end    
end

function Player:secondaryDown()
    if self.warrior == true then
        self:Block()
    elseif self.caster == true then
        if self.pcharging == false then
            arrowChargeSound:Play(true)
            self.pcharging = true
            self.spellCharge = 0.0
            self.spellCharging = true
            self.spellID = 1
            self.spellChargeMax = 3
        end
    elseif self.archer == true then
        self:Cloak()
    end
end

function Player:secondaryUp()
    if self.warrior == true then
        self:Unblock()
    elseif self.caster == true then
        self.pcharging = false
        arrowChargeSound:Stop()
        self.spellCharge = 0.0
        self.spellCharging = false
    elseif self.archer == true then
        if self.cloaked == true then
            self:Uncloak()
        end
    end
end

