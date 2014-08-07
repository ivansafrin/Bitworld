
class "Menu" (Entity)

function Menu:Menu()
	Entity.Entity(self)

	self.selectionRect = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 100, 10)
	self:addChild(self.selectionRect)
	self.selectionRect:setBlendingMode(Renderer.BLEND_MODE_NORMAL)
	self.selectionRect:setColor(1.0, 1.0, 1.0, 0.5)
	self.selection = 1
	self.labels = {}
	self:updateRect()
end

function Menu:onKeyDown(key)
	if key == KEY_UP then
		self.selection = self.selection - 1
		if self.selection < 1 then self.selection = count(self.labels) end
	elseif key == KEY_DOWN then
		self.selection = self.selection + 1
		if self.selection > count(self.labels) then self.selection = 1 end
	elseif key == KEY_RETURN then
		self:dispatchEvent(Event(), Event.SELECT_EVENT)
	end

	self:updateRect()	
end

function Menu:getSelection()
	return self.labels[self.selection].code
end

function Menu:updateRect()
	self.selectionRect:setPosition(0, self.selection * -10)
end

function Menu:addOption(title, code)
	local label = SceneLabel(title, 8, "main")
	label:setColor(1.0, 1.0, 1.0, 0.6)
	self:addChild(label)
	local newLabel = {}
	newLabel.label = label
	newLabel.code = code
	self.labels[count(self.labels)+1] = newLabel
	label:setPosition(0, count(self.labels) * -10)
end