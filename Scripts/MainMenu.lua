require "Scripts/Menu"

class "MainMenu" (Entity)

function MainMenu:MainMenu()
    Entity.Entity(self)

	self.logo = SceneImage("Resources/gfx/logo.png")
	self:addChild(self.logo)
	self.logo:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
	self.logo.depthTest = false
	self.logo.depthWrite = false
	self.logo:setPositionY(40)

	self.gameMenu = Menu()
	self:addChild(self.gameMenu)
	self.gameMenu:addOption("New Game", "new")
	self.gameMenu:addOption("Options", "options")
	self.gameMenu:addOption("Exit Game", "exit")
	self.gameMenu:setPosition(0,-10)
	self.currentMenu = self.gameMenu

	self.gameMenu:addEventListener(self, MainMenu.onGameMenuSelect, Event.SELECT_EVENT)

	self:Hide()
end

function MainMenu:onGameMenuSelect(event)
	if self.gameMenu:getSelection() == "new" then
		self.newGame()
	end
end

function MainMenu:Show()
	self.visible = true
end

function MainMenu:Hide()
	self.visible = false
end

function MainMenu:onKeyDown(key)
	self.currentMenu:onKeyDown(key)
end
