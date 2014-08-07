class "Level" (Scene)

function Level:createFloorTile(mesh,x,y,textureID)

	local texID = textureID

	if self.levelType == "village" then
	else
	texID = 3

	if x == 0 or x == 48 or y == 0 or y == 48 then
		texID = 0
	else

		if self.worldData[x-1][y] == 1 then 
			texID = 0
		end 
		if self.worldData[x][y+1] == 1 then 
			texID = 0
		end
		if self.worldData[x][y-1] == 1 then 
			texID = 0
		end 
		if self.worldData[x+1][y] == 1 then 
			texID = 0
		end 
		if self.worldData[x+1][y] == 1 and self.worldData[x-1][y] == 1 then 
			texID = 0
		end 
	end
	end

	local stepX = 0.0625
	local offsetX = texID * stepX 

	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX,1)

	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX, 0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX, 1)
	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale),offsetX, 1)	
end

function Level:createHoleTile(mesh,x,y)
	
	local stepX = 0.0625
	  
	local offsetX = 1 * stepX 
	
	local oldheight = self.sheight
	self.sheight = self.sheight * -0.5

	if self.worldData[x][y-1] ~= 9 then
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX,0)
		mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX, 1)
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX, 0)
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX, 1)
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX,1)
		mesh:addVertex((x*self.levelScale),0,(y*self.levelScale),offsetX+stepX,0)
	end

	if self.worldData[x][y+1] ~= 9 then
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX, 1)	  
		mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX, 1)
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0)
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0)
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX,1)	  
		mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX, 0)
	end

	if self.worldData[x-1][y] ~= 9 then
		mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX, 1)	  
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX, 1)
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX+stepX, 0)
		mesh:addVertex((x*self.levelScale),0,(y*self.levelScale),offsetX, 0)		  
		mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX,1)	  
		mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX+stepX, 0)
	end
	  
	if self.worldData[x+1][y] ~= 9 then
		mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX+stepX,0)	  
		mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX,1)
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX,1)  
		mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX+stepX,0)	  
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX,1) 
		mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX,0)		  
	end

	self.sheight = oldheight 
end

function Level:createWallTile(mesh,x,y,textureID)
	
	local stepX = 0.0625
	local offsetX = 1 * stepX 

	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX,0)   
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX+stepX,1)

	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale, offsetX, 0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX+stepX, 1)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX, 1)
	  
	local offsetX = 2 * stepX 

	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX,0.5)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX, 0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX+stepX, 0.5)
	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale),offsetX, 0.5)

	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale, offsetX+stepX,0.5)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale)+self.levelScale, offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX,0)
	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX, 0.5)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0.5)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX, 0)

	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX+stepX,0.5)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX,0)
	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale),offsetX, 0.5)
	mesh:addVertex((x*self.levelScale),0,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0.5)
	mesh:addVertex((x*self.levelScale),self.sheight,(y*self.levelScale),offsetX, 0)

	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale)+self.levelScale,offsetX+stepX,0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0.5)
	mesh:addVertex((x*self.levelScale)+self.levelScale,self.sheight,(y*self.levelScale),offsetX, 0)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale)+self.levelScale,offsetX+stepX, 0.5)
	mesh:addVertex((x*self.levelScale)+self.levelScale,0,(y*self.levelScale),offsetX, 0.5)

end

function Level:checkArrowAttack(arrow, defending)
		if defending == nil then return end
		if arrow.hitOnce == true then return end

	   if levelRotate == true then

		local attackingFrom = arrow.body:getPosition().z+0.01
		local attackingTo = arrow.body:getPosition().z - 0.12

		if arrow.dirMod == -1 then	 
			attackingFrom = arrow.body:getPosition().z + 0.12
			attackingTo = arrow.body:getPosition().z - 0.01
		end


		if defending:checkHitZ(attackingFrom,attackingTo,arrow.body:getPosition().x - 0.05,arrow.body:getPosition().x + 0.05) == true and arrow.body:getPosition().y < 0.12 then
			if defending ~= player and defending.hasShield then
				if math.random(10) < 3 then defending:Block() end
			end
		   if defending:getHit() == true then
			   self:bleed(defending:getPosition().x, defending:getPosition().z, defending.blood)
			end
			if defending.HP > 0 and defending.dummy == false then
				defending.zAccel = (-2.5 * arrow.dirMod)
			end
			arrow.hitOnce = true
		end

		else

		local attackingFrom = arrow.body:getPosition().x	
		local attackingTo = arrow.body:getPosition().x + 0.12

		if arrow.dirMod == -1 then	 
			attackingFrom = arrow.body:getPosition().x - 0.12
			attackingTo = arrow.body:getPosition().x	
		end

		if defending:checkHitX(attackingFrom,attackingTo, arrow.body:getPosition().z - 0.09,arrow.body:getPosition().z + 0.12) == true and arrow.body:getPosition().y < 0.12 then
			if defending ~= player and defending.hasShield then
				if math.random(10) < 3 then defending:Block() end
			end
		   if defending:getHit() == true then
			   self:bleed(defending:getPosition().x, defending:getPosition().z, defending.blood)
			end

			if defending.HP > 0 and defending.dummy == false then
				defending.xAccel = (2.5 * arrow.dirMod)
			end
			arrow.hitOnce = true
		end

	end
end


function Level:doSpellAttack(spell, defending)
		if defending == nil then return end
	if spell.type == 0 then
			if defending.dead == false then
			if defending ~= player and defending.hasShield then
				if math.random(10) < 3 then defending:Block() end
			end
		   defending:getHit()
			if defending.dummy == false then
			if levelRotate == true then
				defending.zAccel = (-2.5 * spell.dirMod)			
			else
				defending.xAccel = (2.5 * spell.dirMod)			
			end
			end

			spell.hitOnce = true

			if defending.HP <= 0 then
				defending.hurtVal = 2			
				defending:setColor(0,0,0,1)
			end
			spell.y = 100
		end
	elseif spell.type == 1 then
		if defending.dead == false then			
			defending:Freeze()
			self.freezeSound:Play()
			spell.hitOnce = true
			spell.y = 100
		end
	end
end

function Level:checkSpellAttack(spell, defending)
		if defending == nil then return end
		if spell.hitOnce == true then return end

	   if levelRotate == true then

		local attackingFrom = spell.body:getPosition().z+0.01
		local attackingTo = spell.body:getPosition().z - 0.14

		if spell.dirMod == -1 then	 
			attackingFrom = spell.body:getPosition().z + 0.14
			attackingTo = spell.body:getPosition().z - 0.01
		end

		if defending:checkHitZ(attackingFrom,attackingTo,spell.body:getPosition().x - 0.08,spell.body:getPosition().x + 0.08) == true and spell.body:getPosition().y < 0.1 then
			self:doSpellAttack(spell, defending)
		end

		else

		local attackingFrom = spell.body:getPosition().x	
		local attackingTo = spell.body:getPosition().x + 0.14

		if spell.dirMod == -1 then	 
			attackingFrom = spell.body:getPosition().x - 0.14
			attackingTo = spell.body:getPosition().x	
		end

		if defending:checkHitX(attackingFrom,attackingTo,spell.body:getPosition().z - 0.08,spell.body:getPosition().z + 0.08) == true and spell.body:getPosition().y < 0.1  then
			 self:doSpellAttack(spell, defending)
		end

	end
end

function Level:checkAttack(attacking, defending)
		if defending == nil then return end

		local attackingFrom = 0
		local attackingTo = 0

	   if levelRotate == true then
		
			attackingFrom = attacking:getPosition().z+0.03
			attackingTo = attacking:getPosition().z - 0.15

		if attacking.movDirMod == -1 then	 
			attackingFrom = attacking:getPosition().z + 0.15
			attackingTo = attacking:getPosition().z - 0.03
		end

		if defending:checkHitZ(attackingFrom,attackingTo,attacking:getPosition().x - 0.03,attacking:getPosition().x + 0.03) == true then
		   if defending:getHit() == true then
			   self:bleed(defending:getPosition().x, defending:getPosition().z,defending.blood)
		   end
			if defending.HP > 0 and defending.dummy == false and defending.boss == false then
			   defending.zAccel = (-2.5 * attacking.movDirMod)
			end
		end

		else

		local attackingFrom = attacking:getPosition().x	
		local attackingTo = attacking:getPosition().x + 0.14

		if attacking.movDirMod == -1 then
			attackingFrom = attacking:getPosition().x - 0.14
			attackingTo = attacking:getPosition().x	
		end
					
		if defending:checkHitX(attackingFrom,attackingTo,attacking:getPosition().z - 0.03,attacking:getPosition().z + 0.03) == true then
		   if defending:getHit() == true then
			   self:bleed(defending:getPosition().x, defending:getPosition().z, defending.blood)
			end
			if defending.HP > 0 and defending.dummy == false  and defending.boss == false then
			   defending.xAccel = (2.5 * attacking.movDirMod)
			end
		end

	end
end

function Level:doBleed(x,y,bloodType)
	self.curBlood = self.curBlood + 1
	if self.curBlood > 40 then
	   self.curBlood = 0 
	end
	local blood = self.bloods[self.curBlood]
	blood:setMaterialByName(bloodType, Services.ResourceManager:getGlobalPool())
	blood:setPositionX(x - 0.06 + (random() * 0.12))
	blood:setPositionZ(y - 0.06 + (random() * 0.12))

end

function Level:bleed(x,y,bloodType)
	for i=0,3 do
		self:doBleed(x,y,bloodType)
	end
end

function Level:makeArrow()
	local arrow = {}
	arrow.body = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 0.07,0.035,0)
	arrow.body.alphaTest = true
	arrow.body.billboardMode = true
	arrow.body.billboardRoll = true
	arrow.speed = 0
	arrow.hitOnce = false
	arrow.dirMod = 1
	arrow.yspeed = 2
	arrow.glow = 0
	arrow.shooter = nil
	arrow.body.visible = false
	arrow.body:setMaterialByName("Arrow", Services.ResourceManager:getGlobalPool())
	return arrow
end

function Level:initArrows()

	self.spellballs = {}
	self.iceballs = {}
	
	self.numSpells = 0
		
	for i=0,0 do
		local iceball = self:createIceball()
		self.iceballs[i] = iceball
		self.spellballs[self.numSpells] = iceball
		self.numSpells = self.numSpells + 1
	end
	self.curIceball = 0

	self.fireballs = {}
	for i=0,0 do
		local fireball = self:createFireball()
		self.fireballs[i] = fireball
		self.spellballs[self.numSpells] = fireball
		self.numSpells = self.numSpells + 1
	end
	self.curFireball = 0

	self.arrows = {}
	for i=0,20 do
		local arrow = self:makeArrow()
		self:addChild(arrow.body)
		self.arrows[i] = arrow
	end
	self.curArrow = 0
	self.arrowLandSound = Sound("Resources/sfx/arrowLand.wav")

	self.castFireballSound = Sound("Resources/sfx/castFireBall.wav")
	self.castIceballSound = Sound("Resources/sfx/castIceBall.wav")

	self.freezeSound = Sound("Resources/sfx/creatureFreeze.wav")

	self.spellPerlin = Perlin(3,5,1.0,math.random())
	self.spellPerlinPos = 0
end

function Level:dropItem(x,y,itemType)
	self.curItem = self.curItem + 1
	if self.curItem > 20 then self.curItem = 0 end

	local item = self.items[self.curItem]
	if itemType == "heart" then
		item.icon:setMaterialByName("Heart", Services.ResourceManager:getGlobalPool())   
	elseif itemType == "golds" then
		item.icon:setMaterialByName("Golds", Services.ResourceManager:getGlobalPool())   
	end

	item.body:setPosition(x, 0.05, y)
	item.yAccel = 2.5

	item.type = itemType
end

function Level:initItems()
	self.curItem = 0
	self.items = {}

	for i=0,20 do
		local item = {}
		item.body = Entity()
	
		item.icon = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 0.05,0.05,0)	
		item.icon.billboardMode = true
		item.icon.billboardRoll = true
		item.icon:setMaterialByName("Heart", Services.ResourceManager:getGlobalPool())
		item.body:addChild(item.icon)		
		item.icon:Translate(0,0.025,0)
		item.yAccel = 0

		self:addChild(item.body)

		item.body:setPositionX(1000)
		item.body:setPositionZ(1000)

		self.items[i] = item
	end   
end

function Level:initBlood()
	self.curBlood = 0
	for i=0,40 do
		local blood = ScenePrimitive(ScenePrimitive.TYPE_PLANE, 0.1,0.1,0)
		blood:setMaterialByName("Blood", Services.ResourceManager:getGlobalPool())
		blood:setPosition(1000, random() * 0.01, 1000)
		local scale = 0.4 + (random() * 0.8)
		blood:setScale(scale,scale,scale) 
		blood.alphaTest = true
		local darkness = 0.5 + (random() * 0.4)
		blood:setColor(darkness,darkness,darkness,0.4 + (random() * 0.6))
		self:addChild(blood)
		self.bloods[i] = blood
	end
end

function Level:updateArrows(e)
	self.spellPerlinPos = self.spellPerlinPos + (e*0.8)

	for i=0,self.numSpells-1 do
		local fireball = self.spellballs[i]
	   
		if fireball.levelRotate == true then
			fireball.body:setPositionZ(fireball.body:getPosition().z - (2.5*e*fireball.dirMod))
		else
			fireball.body:setPositionX(fireball.body:getPosition().x + (2.5*e*fireball.dirMod))
		end
		
		if fireball.body:getPosition().y > 0.05 then
		   fireball.body:setPositionY(fireball.body:getPosition().y - (e*3))
		else
		   fireball.body:setPositionY(0.05)
		end

--		fireball.body:setPositionY(fireball.body:getPosition().y+self.spellPerlin:Get(self.spellPerlinPos, 0.5)*0.15)

		if self:canPass(fireball.body:getPosition().x, fireball.body:getPosition().z) == false then
			fireball.body:setPositionX(1000)
			fireball.body:setPositionZ(1000)
		end

	if fireball.shooter == player then 
		for i=0,self.numCreatures-1 do
			local defending = self.creatures[i]
			if defending.friendly == false then
				self:checkSpellAttack(fireball, defending)
			end
		end
	else
		self:checkSpellAttack(fireball, player)
	end

	end

	for i=0,20 do
	local arrow = self.arrows[i]
	if arrow.body:getPosition().y > 0.01 then
		arrow.body:setRoll(arrow.body:getRoll() - 230 * e * arrow.dirMod)

	if arrow.levelRotate == true then
		arrow.body:Translate(0,e*arrow.yspeed,e*arrow.speed*arrow.dirMod*-1)
	else
		arrow.body:Translate(e*arrow.speed*arrow.dirMod,e*arrow.yspeed,0)
	end

	if arrow.speed > 0 then
		arrow.speed = arrow.speed - (5*e)
	end
	arrow.yspeed = arrow.yspeed - (20*e)

	if arrow.shooter == player then 
		for i=0,self.numCreatures-1 do
			local defending = self.creatures[i]
			if defending.friendly == false then
				self:checkArrowAttack(arrow, defending)
			end
		end
	else
		self:checkArrowAttack(arrow, player)
	end


	else
		arrow.body:setPositionY(0.01)
		if arrow.rested == false then
			self.arrowLandSound:Play()
			arrow.rested = true
		end
	end



--	if arrow.glow > 0 then
--		arrow.glow = arrow.glow - 5 * e
--		arrow.body:setColor(arrow.glow,arrow.glow,arrow.glow,1)
--	end

	end
end

function Level:shootArrow(creature)
	local arrow = self.arrows[self.curArrow]
	self.curArrow = self.curArrow + 1
	if self.curArrow == 20 then self.curArrow = 0 end

	arrow.levelRotate = levelRotate
	arrow.body.visible = true
	arrow.speed = creature.arrowCharge
	arrow.yspeed = 2
	arrow.hitOnce = false
	arrow.dirMod = creature.movDirMod
	if creature.movDirMod == 1 then
		arrow.body:setRoll(30)
	else
		arrow.body:setRoll(-210)
	end
	arrow.shooter = creature
	arrow.glow = 1
	arrow.rested = false
	arrow.body:setPosition(creature:getPosition().x+0.03, creature:getPosition().y+0.05, creature:getPosition().z-0.04)
end

function Level:createIceball()
	local fireball = {}
	fireball.position = {}

	fireball.body = Entity()

	fireball.body:setPositionY(100)
	fireball.levelRotate = false
	fireball.flame = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 0.02,0.02,0)
	fireball.flame:setColor(1,0.3, 0.2,1)
	fireball.flame.billboardMode = true
	fireball.flame.billboardRoll = true
--	fireball.body:addChild(fireball.flame)
	fireball.flame.y = 0.01
	fireball.dirMod = 1
	fireball.body:setPosition(0, 100, 0)

	fireball.particleEmitter = SceneParticleEmitter(50, 1.0, 1.0)
	
	fireball.particleEmitter:setParticleSize(0.02)
	fireball.particleEmitter:setParticleType(SceneParticleEmitter.PARTICLE_TYPE_QUAD)
	fireball.particleEmitter:setEmitterSize(Vector3(0.0, 0.0, 0.0))
	fireball.particleEmitter:setMaterialByName("SparkParticleIce", Services.ResourceManager:getGlobalPool())
	fireball.particleEmitter:setParticleDirection(Vector3(0.0, 0.0, 0.0))
	fireball.particleEmitter:setGravity(Vector3(0.0, -2.0, 0.0))
	fireball.particleEmitter:setPerlinEnabled(true)
	fireball.particleEmitter:setPerlinValue(Vector3(0.4, 0.4, 0.4))
--	fireball.particleEmitter:setParticleRotationSpeed(Vector3(0.0, 0.0, 50.0))
	fireball.particleEmitter.useScaleCurve = true
	fireball.particleEmitter.scaleCurve:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.scaleCurve:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.useColorCurves = true
	fireball.particleEmitter.colorCurveR:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveR:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.colorCurveG:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveG:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.colorCurveB:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveB:addControlPoint2d(1.0, 1.0)	

	fireball.particleEmitter.colorCurveA:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveA:addControlPoint2d(1.0, 0.0)	
	fireball.particleEmitter:setParticlesInWorldSpace(true)

	fireball.body:addChild(fireball.particleEmitter)

	fireball.light = SceneLight(SceneLight.POINT_LIGHT, self, 5.001,0.005)
	fireball.light:setLightColor(0.0,0.2,0.8)
	self:addLight(fireball.light)
	fireball.body:addChild(fireball.light)
	self:addChild(fireball.body)
	return fireball
end

function Level:createFireball()
	local fireball = {}
	fireball.position = {}
	fireball.body = Entity()

	fireball.body:setPositionY(100)
	fireball.levelRotate = false
	fireball.flame = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 0.02,0.02,0)
	fireball.flame:setColor(1,0.3, 0.2,1)
	fireball.flame.billboardMode = true
	fireball.flame.billboardRoll = true
--	fireball.body:addChild(fireball.flame)
	fireball.flame.y = 0.01
	fireball.dirMod = 1
	fireball.body:setPosition(0, 100, 0)

	fireball.particleEmitter = SceneParticleEmitter(100, 0.5, 1.0)
	
	fireball.particleEmitter:setParticleSize(0.02)
	fireball.particleEmitter:setParticleType(SceneParticleEmitter.PARTICLE_TYPE_QUAD)
	fireball.particleEmitter:setEmitterSize(Vector3(0.0, 0.0, 0.0))
	fireball.particleEmitter:setMaterialByName("SparkParticle", Services.ResourceManager:getGlobalPool())
	fireball.particleEmitter:setParticleDirection(Vector3(0.0, 0.0, 0.0))
	fireball.particleEmitter:setGravity(Vector3(0.0, 0.0, 0.0))
	fireball.particleEmitter:setPerlinEnabled(true)
	fireball.particleEmitter:setPerlinValue(Vector3(1.0, 1.0, 1.0))
--	fireball.particleEmitter:setParticleRotationSpeed(Vector3(0.0, 0.0, 50.0))
	fireball.particleEmitter.useScaleCurve = true
	fireball.particleEmitter.scaleCurve:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.scaleCurve:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.useColorCurves = true
	fireball.particleEmitter.colorCurveR:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveR:addControlPoint2d(1.0, 1.0)	

	fireball.particleEmitter.colorCurveG:addControlPoint2d(0.0, 0.5)
	fireball.particleEmitter.colorCurveG:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.colorCurveB:addControlPoint2d(0.0, 0.0)
	fireball.particleEmitter.colorCurveB:addControlPoint2d(1.0, 0.0)	

	fireball.particleEmitter.colorCurveA:addControlPoint2d(0.0, 1.0)
	fireball.particleEmitter.colorCurveA:addControlPoint2d(1.0, 0.0)	
	fireball.particleEmitter:setParticlesInWorldSpace(true)

	fireball.body:addChild(fireball.particleEmitter)


	fireball.light = SceneLight(SceneLight.POINT_LIGHT, self, 5.001,0.005)
	fireball.light:setLightColor(0.9,0.2,0)
	self:addLight(fireball.light)
	fireball.body:addChild(fireball.light)
	self:addChild(fireball.body)
	return fireball
end

function Level:castIceball(creature)
	self.castIceballSound:Play()
	local fireball = self.iceballs[self.curIceball]
	fireball.body:setPositionX(creature:getPosition().x+0.03)
	fireball.body:setPositionY(creature:getPosition().y+0.07)
	fireball.body:setPositionZ(creature:getPosition().z-0.01)
	fireball.shooter = creature
	fireball.type = 1
	fireball.levelRotate = levelRotate
	fireball.dirMod = creature.movDirMod
	fireball.hitOnce = false
end


function Level:castFireball(creature)
	self.castFireballSound:Play()
	local fireball = self.fireballs[self.curFireball]
	fireball.body:setPositionX(creature:getPosition().x+0.03)
	fireball.body:setPositionY(creature:getPosition().y+0.07)
	fireball.body:setPositionZ(creature:getPosition().z-0.01)
	fireball.shooter = creature
	fireball.levelRotate = levelRotate
	fireball.dirMod = creature.movDirMod
	fireball.type = 0
	fireball.hitOnce = false
	return fireball
end

function Level:losePlayer()
	for i=0,self.numCreatures-1 do
		local creature = self.creatures[i]
		creature:loseSight()
	end
end

function Level:creatureAttack(attacking)
	if attacking == player then 
		for i=0,self.numCreatures-1 do
			local defending = self.creatures[i]
			if defending.friendly == false then
				self:checkAttack(attacking, defending)
			end
		end
	else
		self:checkAttack(attacking, player)
	end
end

function Level:getTargetPath(source, dest)
	return self:getShortestPath(self:positionToTile(source:getPosition().x,source:getPosition().z),self: positionToTile(dest:getPosition().x,dest:getPosition().z))
end

function Level:getPathFindTarget(source, dest)

	local retPoint = {}	
	
	local shortestPath,pathSize = self:getShortestPath(self:positionToTile(source:getPosition().x,source:getPosition().z),self: positionToTile(dest:getPosition().x,dest:getPosition().z))

	if pathSize > 0 then
		local pt = shortestPath[pathSize-1]
		local npt = self:tileToPosition(pt.x, pt.y)	
		retPoint.x = npt.x
		retPoint.z = npt.y
	else
		retPoint.x = source.position.x
		retPoint.z = source.position.z
	end
	
	return retPoint
end

function Level:doFillPath(tileVal, x,y)
	if x < 0 or x > 47 or y < 0 or y > 47 then
		return false
	end

	if self.pathData[x][y] ~= 1000 or self.worldData[x][y] == 1 then
		return false
	end

	self.pathData[x][y] = tileVal

	self.newPathNodes[self.numNewPathNodes] = {}
	local j = self.newPathNodes[self.numNewPathNodes]
	j.x = x
	j.y = y
	self.numNewPathNodes = self.numNewPathNodes + 1
	return true
end

function Level:fillPath(tileVal, x,y,dx,dy)
	if x < 0 or x > 47 or y < 0 or y > 47 then
		return false
	end

	if x==dx and y == dy then
		return true
	end

	self:doFillPath(tileVal, x,y-1)
	self:doFillPath(tileVal, x-1,y)
	self:doFillPath(tileVal, x+1,y)
	self:doFillPath(tileVal, x,y+1)

	return false
end

function Level:fillPathNodes(tileVal, destx, desty)

	self.newPathNodes = {}
	self.numNewPathNodes = 0   

	for i=0,self.numPathNodes-1 do
		local node = self.pathNodes[i]
		if self:fillPath(tileVal, node.x, node.y, destx, desty) == true then
			return 
		end
	end

	if self.numNewPathNodes > 0 then
		self.pathNodes = self.newPathNodes
		self.numPathNodes = self.numNewPathNodes
		self:fillPathNodes(tileVal+1, destx, desty) 
	end
end

function Level:getShortestPath(source, dest)
	if dest.x < 0 then dest.x = 0 end
	if dest.x > 47 then dest.x = 47 end

	if dest.y < 0 then dest.y = 0 end
	if dest.y > 47 then dest.y = 47 end


	local ret = {}

	for i=0,48 do
		for j=0,48 do
			self.pathData[i][j] = 1000
		end
	end

	self.pathNodes = {}
	self.numPathNodes = 1
	self.pathNodes[0] = {}
	local j = self.pathNodes[0]
	j.x = source.x
	j.y = source.y

	while self:fillPathNodes(0,dest.x, dest.y) == false do
	end

	local curX = dest.x
	local curY = dest.y
	local i = 0

	curValue = self.pathData[curX][curY]

	while curValue > 1 do

		ret[i] = {}
		local j = ret[i]

		local nextX = curX
		local nextY = curY
		local nextVal = curValue

		nextX,nextY,nextVal = self:checkPathTile(nextX,nextY,curX,curY-1, nextVal)
		nextX,nextY,nextVal = self:checkPathTile(nextX,nextY,curX-1,curY, nextVal)
		nextX,nextY,nextVal = self:checkPathTile(nextX,nextY,curX+1,curY, nextVal) 
		nextX,nextY,nextVal = self:checkPathTile(nextX,nextY,curX,curY+1, nextVal)

		local npt = self:tileToPosition(nextX, nextY)	
		j.x = npt.x
		j.y = npt.y

		self.pathData[curX][curY] = 1000
		curX = nextX
		curY = nextY


		if nextVal == curValue then
			curValue = curValue - 1
		else
			curValue = nextVal	
		end  
		i = i + 1
	end

	return ret,i
end

function Level:checkPathTile(curX,curY, x,y, value)
	if x == nil or y == nil then return curX,curY,value end
	if x < 0 or x > 47 or y < 0 or y > 47 then
		return curX,curY,value
	end

	if self.pathData[x][y] < value then
		return x,y,self.pathData[x][y]
	else
		return curX,curY,value
	end	
end

function Level:tileToPosition(x,y)
	local ret = {}
	
	if x == nil then ret.x = 0 else
		ret.x = (-23*self.levelScale) + (x * self.levelScale)
	end
	if y == nil then ret.y = 0 else
		ret.y = (-24*self.levelScale) + (y * self.levelScale)
	end

	return ret

end

function Level:positionToTile(x,y)
	local ret = {}
	
	ret.x = math.floor(((x + (23*self.levelScale)) / self.levelScale)) + 1 
	ret.y = math.floor(((y + (23*self.levelScale)) / self.levelScale)) + 1

	

	if ret.x < 0 then ret.x = 0 end
	if ret.x > 47 then ret.x = 47 end

	if ret.y < 0 then ret.y = 0 end
	if ret.y > 47 then ret.y = 47 end

	return ret
end

function Level:generateRandomLevel()
	for i=0,48 do
		self.worldData[i] = {}
		for j=0,48 do
			if math.random() > 0.5 or i == 16 or j == 16 or i == 15 or i == 17 or j == 15 or j == 17 then
				self.worldData[i][j] = 0
			else
				self.worldData[i][j] = 1
			end
		end
	end
end

function Level:createProp(propType,x,y)
	local prop = Prop(propType+1)
	prop:setPosition((-23*self.levelScale) + (x * self.levelScale), 0.0, (-24*self.levelScale) + (y * self.levelScale) - 0.04)
	self.props[self.numProps] = prop
	self.numProps = self.numProps + 1
	return prop
end

function Level:decorateRoom(rect, roomInfo)

	if rect.w < 2 or rect.h < 2 then return end

  --  print("decorating as "..roomInfo.roomName)

	local biggestSize = math.max(rect.w, rect.h) 
	
	local wallDensity = 0.4
	if roomInfo.roomName == "study" then		
		wallDensity = 0.9
	end

	for i=0,rect.w do
		if math.random() < wallDensity then
			if self.worldData[rect.x + i][rect.y - 1] == 1 then
				if roomInfo.roomName == "study" then
				   self:createProp(21, rect.x + i, rect.y)
				else
					self:createProp(math.random(20,22), rect.x + i, rect.y)
				end
			end
		end		
	end

	for i=0,biggestSize do
		if math.random() < 0.5 then
			self:createProp(roomInfo["propIDs"][math.random(roomInfo["numProps"])], rect.x + math.random(rect.w), rect.y+math.random(rect.h))
		end
	end


end

function Level:buildRoom(rect)
	for si=0,rect.w do
		for sj=0,rect.h do			
			self.worldData[rect.x + si][rect.y + sj] = 0
		end
	end

	if 1 == 1 then
	if rect.w > 1 and rect.h > 1 then
		if math.random() > 0.5 then
			for i=0,math.random(2) do
				local creatureIndex = random(#self.createCreatures)
				local creature = self:createLibraryCreature(self.createCreatures[creatureIndex])
				if creature ~= nil then
					creature:setPositionX((-24*self.levelScale) + ((rect.x + math.ceil(math.random() * rect.w)) * self.levelScale))
					creature:setPositionZ((-24*self.levelScale) + ((rect.y + math.ceil(math.random()*rect.h)) * self.levelScale))
				end
			end
		end
	end
	end

	self.rooms[self.numRooms] = rect
	self.numRooms =self.numRooms + 1
end

function Level:createNPC(id)
	local template = npcLibrary[id]
	if template == nil then return nil end
	local creature = self:createLibraryCreature(template.base)
	creature.friendly = true
	creature.name = template.name
	creature.speechlines = template.speechlines

	if template.onlytalk ~= nil then
		creature.onlytalk = template.onlytalk
		creature.nospeechlines = template.nospeechlines
	end

	pos = self:tileToPosition(template.x, template.y)
	creature:setPosition(pos.x, 0, pos.y)
	self.npcs[#self.npcs+1] = creature
	return creature	
end

function Level:createLibraryCreature(id)
	local template = creatureLibrary[id]

	if template == nil then return nil end

	local creature = Creature(template.imageIndex)
	creature.hasShield = template.hasShield
	creature.shield.visible = creature.hasShield
	creature.speed = template.speed
	creature.HP = template.HP
	creature.level = self
	creature.id = id
	creature.name = template.name
	creature.thinkType = template.aitype

	if template.dummy == true then
		creature.dummy = true
	end

	if template.blood ~= nil then
		creature.blood = template.blood
	end
	
	if creature.thinkType == AI_MAGE then
		creature.spellID = template.spellID
	end

	self.creatures[self.numCreatures] = creature
	self.numCreatures = self.numCreatures + 1
	return creature
end

function Level:roomCollide(room1,room2)
	for i=0,room1.w+2 do
		for j=0,room1.h+2 do
			local px = room1.x + i -1
			local py = room1.y + j -1
			if px >= room2.x and px <= room2.x + room2.w and py >= room2.y and py <= room2.y + room2.h then
				return true
			end
		end
	end
	return false
end

function Level:checkRoomInRooms(rooms, numRooms, room)
	for i=0,numRooms do
		if self:roomCollide(rooms[i], room) then
			return false
		end
	end
	return true
end

function Level:buildRooms(num,x,y,w,h)
	local roomMax = 6
	local roomMin = 1

	local squares = {}
	local numSquares = 0

	for rloop=0,20000 do
		local square = {}
		square.x = x+math.random(w-roomMax)
		square.y = y+math.random(h-roomMax) 
		square.w = roomMin+math.random(roomMax-roomMin) 
		square.h = roomMin+math.random(roomMax-roomMin)
		if self:checkRoomInRooms(squares, numSquares-1, square) then
			self:buildRoom(square)
			squares[numSquares] = square
			numSquares = numSquares + 1
		end
	end
end

function Level:buildBinaryRooms(x,y,w,h)

	local square1 = {}
	local square2 = {}

	if w < 5 or h < 5 and (w < 9 and h < 9) then 
		square1.x = x
		square1.y = y
		square1.w = w
		square1.h = h

		self:buildRoom(square1)
	else
		if w > h then
			square1.x = x
			square1.y = y
			square1.w = math.random(w-4)
			square1.h = h - 1

			square2.x = x + square1.w + 2
			square2.y = y
			square2.w = w - square1.w - 2
			square2.h = h - 1
		else
			square1.x = x
			square1.y = y
			square1.w = w - 1
			square1.h = math.random(h-4)

			square2.x = x
			square2.y = y + square1.h + 2
			square2.w = w - 1
			square2.h = h - square1.h - 2
		end  
		self:buildBinaryRooms(square1.x, square1.y,square1.w, square1.h)
		self:buildBinaryRooms(square2.x, square2.y,square2.w, square2.h)
	end
end

function Level:canPass(x,y)
	
	local pos = self:positionToTile(x,y)
	local tileValX = pos.x
	local tileValY = pos.y

	if tileValX > 47 or tileValY > 47 or tileValX < 0 or tileValY < 0 then
		return false
	end

	if self.worldData[tileValX][tileValY] == 1 then
		return false
	else
		return true
	end
end

function Level:generateFinalBossLevel()
	self.worldData = {}
	self.rooms = {}
	self.numRooms = 0

	for i=0,48 do
		self.worldData[i] = {}
		for j=0,48 do
			self.worldData[i][j] = finalLevelData[i+1][j+1]
		end
	end

	dummy = self:createLibraryCreature("dragonboss")
	pos = self:tileToPosition(22,17)
	dummy:setPosition(pos.x,0,pos.y)

	for i=0,4 do
		local creature = self:createLibraryCreature("fireslime")
		pos = self:tileToPosition(18+random(7),17+random(5))
		creature:setPosition(pos.x,0,pos.y)
	end

	for i=0,4 do
		local creature = self:createLibraryCreature("firehorror")
		pos = self:tileToPosition(18+random(7),17+random(5))
		creature:setPosition(pos.x,0,pos.y)
	end

	for i=0,3 do
		local creature = self:createLibraryCreature("darkeye")
		pos = self:tileToPosition(18+random(7),17+random(5))
		creature:setPosition(pos.x,0,pos.y)
	end

end

function Level:generateVillageLevel()
	self.worldData = {}
	self.rooms = {}
	self.numRooms = 0

	for i=0,48 do
		self.worldData[i] = {}
		for j=0,48 do
			self.worldData[i][j] = villageData[i+1][j+1]
		end
	end

	for i=1,#villageNPCs do
		self:createNPC(villageNPCs[i])
	end

	local dummy = self:createLibraryCreature("dummypost")
	local pos = self:tileToPosition(20,37)
	dummy:setPosition(pos.x,0,pos.y)

	dummy = self:createLibraryCreature("dummypost")
	pos = self:tileToPosition(22,37)
	dummy:setPosition(pos.x,0,pos.y)

	dummy = self:createLibraryCreature("dummypost")
	pos = self:tileToPosition(32,38)
	dummy:setPosition(pos.x,0,pos.y)

	dummy = self:createLibraryCreature("dummypost")
	pos = self:tileToPosition(32,40)
	dummy:setPosition(pos.x,0,pos.y)

end

function Level:createSnow()
	self.particleEmitter = SceneParticleEmitter(300, 5.0, 0.01)

	self.particleEmitter:setParticleSize(0.01)
	self.particleEmitter:setParticleType(SceneParticleEmitter.PARTICLE_TYPE_QUAD)
	self.particleEmitter:setEmitterSize(Vector3(3.0, 0.0, 3.0))
	self.particleEmitter:setMaterialByName("SparkParticle", Services.ResourceManager:getGlobalPool())
	self.particleEmitter:setParticleDirection(Vector3(0.0, 0.0, 0.0))

	self.particleEmitter:setGravity(Vector3(0.0, -6.0, 0.0))

	self.particleEmitter:setPerlinEnabled(true)
	self.particleEmitter:setPerlinValue(Vector3(0.6, 0.0, 0.6))

	self.particleEmitter:setParticleRotationSpeed(Vector3(0.0, 0.0, 50.0))

	self.particleEmitter:setPosition(0.0, 1.0, 0.0)
	self:addChild(self.particleEmitter)
end

function Level:createLava()
	self.lava = ScenePrimitive(ScenePrimitive.TYPE_PLANE, 9,9,0)
	self.lava:setPositionY(-0.5)
	self.lava:setMaterialByName("Lava", Services.ResourceManager:getGlobalPool())
	self:addChild(self.lava)
end

function Level:createFire()
--	self.particleEmitter = SceneParticleEmitter(100, 3.0, 1.0)
--	self:addChild(self.particleEmitter)
end

function Level:generateCastleLevel()
	self.worldData = {}
	self.rooms = {}
	self.numRooms = 0

	for i=0,48 do
		self.worldData[i] = {}
		for j=0,48 do
			self.worldData[i][j] = 1
		end
	end

	local square = {}		

	-- make a hallway
	square.x = (48/2) - 2
	square.y = 0
	square.w = 3
	square.h = 48
	square.dontDecorate = true
	self:buildRoom(square)

	square = {}
	square.x = 0
	square.y = (48/2) - 2
	square.w = 48
	square.h = 3
	square.dontDecorate = true
	self:buildRoom(square)

	self:buildBinaryRooms(1,1,20,20)
	self:buildBinaryRooms(27,1,20,19)
	self:buildBinaryRooms(1,27,19,20)
	self:buildBinaryRooms(27,27,20,20)


	for i=0,self.numRooms-1,2 do
		if i+1 < self.numRooms-1 then
			self:connectRoom(self.rooms[i], self.rooms[i+1])
		end
		if i > 2 then
			self:connectRoom(self.rooms[i], self.rooms[i-1])
		end
	end

	if self.numHoles > 0 then
		for i=0,0 do
			 self.worldData[1+random(45)][1+random(45)] = 9
		end
	end

	for i=0,self.numRooms-1 do
	   local room = self.rooms[i]
		if room.dontDecorate == nil then
			self:decorateRoom(room, self.roomTypes[math.floor(math.random() * (self.numRoomTypes+1))]) 
		end
	end
end

function Level:generateLavaLevel() 
  self.worldData = {}
	self.rooms = {}
	self.numRooms = 0

	for i=0,48 do
		self.worldData[i] = {}
		for j=0,48 do
			self.worldData[i][j] = 1
		end
	end

	local square = {}		

	self:buildBinaryRooms(1,1,46,46)

	for i=0,self.numRooms-1,2 do
		if i+1 < self.numRooms-1 then
			self:connectRoom(self.rooms[i], self.rooms[i+1])
		end
		if i > 2 then
			self:connectRoom(self.rooms[i], self.rooms[i-1])
		end
	end

	if self.numHoles > 0 then
		for i=0,0 do
			 self.worldData[1+random(45)][1+random(45)] = 9
		end
	end
end

function Level:addTorch(x,y)
	local light = SceneLight(SceneLight.POINT_LIGHT, 18.05,0.01,self)
	light:setLightColor(1,0.4,0.1)
	self:addLight(light)
	light:Translate(((-24*self.levelScale) + (x * self.levelScale)) - 0.1,0.05,(-24*self.levelScale) + (y * self.levelScale))
	self.torches[self.numTorches] = light
	self.numTorches = self.numTorches + 1
end

function Level:connectRoom(room1, room2)
	local posx = room1.x + math.floor(room1.w/2)
	local posy = room1.y+ math.floor(room1.h/2)

	while posx ~= room2.x and posx > 0 and posx < 48 do
		self.worldData[posx][posy] = 0
		if posx < room2.x then
			posx = posx + 1
		else
			posx = posx - 1
		end
	end

	while posy ~= room2.y and posy > 0 and posy < 48 do
		self.worldData[posx][posy] = 0
		if posy < room2.y then
			posy = posy + 1
		else
			posy = posy - 1
		end
	end


end

function Level:createEntranceExit()

	if self.levelType == "village" then
		self.levelStartX = 0
		self.levelStartY = 0

		self.levelEndX = 35
		self.levelEndY = 31
	elseif self.levelType == "finalboss" then
		self.levelStartX = 22
		self.levelStartY = 35

		self.levelEndX = 2
		self.levelEndY = 2
	else
	local ok = false
	self.levelStartX = 0
	self.levelStartY = 0

	while ok == false do
		self.levelStartX = 1+math.random(46)
		self.levelStartY = 1+math.random(46)	
		if self.worldData[self.levelStartX][self.levelStartY] == 0 and self.worldData[self.levelStartX-1][self.levelStartY] == 0 then ok = true end
	end

	local ok = false

	self.levelEndX = 0
	self.levelEndY = 0

	local startVector = Vector3(self.levelStartX,0,self.levelStartY)
	local endVector = Vector3(0,0,0)

	while ok == false do
		self.levelEndX = 1+math.random(46)
		self.levelEndY = 1+math.random(46)  
		endVector.x =  self.levelEndX
		endVector.z =  self.levelEndY

		if self.worldData[self.levelEndX][self.levelEndY] == 0 and startVector:distance(endVector) > 3.5  then ok = true end
	end

	end

	local entrance = self:createProp(26,self.levelStartX, self.levelStartY)
	entrance.shadow.visible = false
	entrance.body:setMaterialByName("PropLight", Services.ResourceManager:getGlobalPool())
	entrance.body:setScale(1.3,1.3,1.3)

	local exit = self:createProp(27,self.levelEndX, self.levelEndY)
	exit.shadow.visible = false	
	exit.body:setMaterialByName("PropLight", Services.ResourceManager:getGlobalPool())
	exit.body:setScale(1.3,1.3,1.3)

	self.exitGlow = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 0.10,0.16,0)
	self.exitGlow:setMaterialByName("exitGlow", Services.ResourceManager:getGlobalPool())
	self.exitGlow:setBlendingMode(Renderer.BLEND_MODE_LIGHTEN)
	self.exitGlow:setColor(1,1,1,0.4)
	self.exitGlow.depthTest = false

	local pos = self:tileToPosition(self.levelEndX, self.levelEndY)
	self.exitGlowX = pos.x
	self.exitGlow:setPosition(pos.x + 0.05,  0.08, pos.y - 0.08)

	self.exitGlow.billboardMode = true
	self.exitGlow.billboardRoll = true

end

function Level:generateLevel(levelType)
	self.worldData = {}
	if levelType == "castle" then
		self:generateCastleLevel()   
	elseif levelType == "lavacastle" then
		self:generateLavaLevel()   
	elseif levelType == "village" then
		self:generateVillageLevel()  
	elseif levelType == "finalboss" then
		self:generateFinalBossLevel()	   
	else
		self:generateRandomLevel()
	end
	self:createEntranceExit()
end

function Level:Level(levelType,levelSkin,createCreatures)
	Scene.Scene(self, Scene.SCENE_3D)	
	
	self:getDefaultCamera():setClippingPlanes(0.1, 100.0)

	self.ownsChildren = true

	self.numHoles = 0
	self.exitGlowVal = 0
	self.createCreatures = createCreatures
	self.player = nil

	self.npcs = {}
	self.bloods = {}

	self.levelType = levelType
	self.levelSkin = levelSkin
	self.roomTypes = {}
	self.numRoomTypes = 3

	self.pathData = {}
	for i=0,48 do
		self.pathData[i] = {}
	end

	self.roomTypes[0] = {}
	self.roomTypes[0]["roomName"] = "cellar"
	self.roomTypes[0]["propIDs"] = {}
	self.roomTypes[0]["propIDs"][0] = 14
	self.roomTypes[0]["propIDs"][1] = 15
	self.roomTypes[0]["propIDs"][2] = 15
	self.roomTypes[0]["propIDs"][3] = 14
	self.roomTypes[0]["propIDs"][4] = 15
	self.roomTypes[0]["propIDs"][5] = 4
	self.roomTypes[0]["numProps"] = 5

	self.roomTypes[1] = {}
	self.roomTypes[1]["roomName"] = "bedroom"
	self.roomTypes[1]["propIDs"] = {}
	self.roomTypes[1]["propIDs"][0] = 16
	self.roomTypes[1]["propIDs"][1] = 17
	self.roomTypes[1]["propIDs"][2] = 18
	self.roomTypes[1]["propIDs"][3] = 19
	self.roomTypes[1]["numProps"] = 3

	self.roomTypes[2] = {}
	self.roomTypes[2]["roomName"] = "study"
	self.roomTypes[2]["propIDs"] = {}
	self.roomTypes[2]["propIDs"][0] = 5
	self.roomTypes[2]["propIDs"][1] = 6
	self.roomTypes[2]["propIDs"][2] = 7
	self.roomTypes[2]["propIDs"][3] = 8
	self.roomTypes[2]["propIDs"][4] = 10
	self.roomTypes[2]["propIDs"][5] = 21
	self.roomTypes[2]["numProps"] = 5

	self.roomTypes[3] = {}
	self.roomTypes[3]["roomName"] = "dining"
	self.roomTypes[3]["propIDs"] = {}
	self.roomTypes[3]["propIDs"][0] = 9
	self.roomTypes[3]["propIDs"][1] = 10
	self.roomTypes[3]["propIDs"][2] = 11
	self.roomTypes[3]["propIDs"][3] = 12
	self.roomTypes[3]["propIDs"][4] = 13
	self.roomTypes[3]["propIDs"][5] = 14
	self.roomTypes[3]["propIDs"][6] = 15
	self.roomTypes[3]["numProps"] = 6

	self.numRoomTypes = 3

	self.levelScale = 0.18
	self.sheight = 0.08

	self.numCreatures = 0
	self.creatures = {}

	self.numProps = 0
	self.props = {}

	self.torches = {}
	self.numTorches = 0
	self.torchPerlin = Perlin(3,5,1.0,math.random())
	self.torchPerlinPosition = 0	

	self:generateLevel(levelType)

--	if self.levelType == "village" then
		self:buildLevelGeometry()
--	end

	if self.levelType == "village" then
		self:createSnow()
	end

	if self.levelType == "finalboss" then
--		self:createFire()
		self:createLava()
	end


	self:initArrows()
	self:initItems()

	self:addChild(self.exitGlow)
end

function Level:checkFall(creature)
		local pos = {}
		if levelRotate == false then		
			pos = self:positionToTile(creature:getPosition().x-0.08,creature:getPosition().z+0.08)
		else
			pos = self:positionToTile(creature:getPosition().x-0.08,creature:getPosition().z-0.09)		
		end

		if self.worldData[pos.x][pos.y] == 9 then
			typeSound:Play()
		end
end

function Level:Update(e)

	if self.player ~= nil then
	for i=0,20 do

		local item = self.items[i]
		if item.body:getPosition().y > 0.025 then
			item.yAccel = item.yAccel - (20 * e)
			item.body:Translate(0,item.yAccel*e,0)
		else
			item.yAccel = 0
			item.body:getPosition().y = 0.025
		end

		if self.player:getPosition().x > item.body:getPosition().x - 0.05 and self.player:getPosition().x < item.body:getPosition().x + 0.05 and self.player:getPosition().z > item.body:getPosition().z - 0.05 and self.player:getPosition().z < item.body:getPosition().z + 0.05  then 
			item.body:setPositionX(1000)
			item.body:setPositionZ(1000)
			self.player:useItem(item)
		end

	end
	end


	if levelRotate == true then
	   self.exitGlow:setPositionX(self.exitGlowX - 0.025)
	else
	   self.exitGlow:setPositionX(self.exitGlowX + 0.05)
	end

	self.exitGlowVal = self.exitGlowVal + (e*5)
	self.exitGlow:setColor(1,1,1,0.2+(0.5*math.sin(self.exitGlowVal)))

	self.torchPerlinPosition = self.torchPerlinPosition + (e * 0.5)

	for i=0,self.numTorches-1 do
		local torch = self.torches[i]
		local perlinVal = 0.4 + (0.6 * math.abs(self.torchPerlin:Get(self.torchPerlinPosition, 0)))
		torch:setLightColor(1* perlinVal,0.4* perlinVal,0.1 * perlinVal)
	end

	self:updateArrows(e)

	if self.player == nil then
		for i=0,self.numCreatures-1 do
			local creature = self.creatures[i]
			creature:Update(e*0.3)
		end
	else

	local nextToNPC = false
	for i=1,#self.npcs do
		local npc = self.npcs[i]

		if player:getPosition().x > npc:getPosition().x - 0.1 and player:getPosition().x < npc:getPosition().x + 0.1 and player:getPosition().z > npc:getPosition().z - 0.1 and player:getPosition().z < npc:getPosition().z + 0.1  then
			if talking == false then
				talkTip.enabled = true
				nextToNPC = true
				talkToNPC = npc
			end
		end
	end
	if nextToNPC == false then
		talkToNPC = nil
		talkTip.enabled = false
	end

	if self.player ~= nil then		
		self:checkFall(self.player)
	end

	for i=0,self.numCreatures-1 do
		local creature = self.creatures[i]
		local camera = self:getDefaultCamera()

		if creature:getPosition():distance(self.player:getPosition()) < 2.5 then
			if showingFinalCutscene == false then
				creature:Think(e)
			end
			if camera:isAABBInFrustum(creature:getWorldAABB()) then			
				creature:Update(e)
				local pos = self:positionToTile(creature:getPosition().x,creature:getPosition().z)
				if self.worldData[pos.x][pos.y] == 9 then
					creature:Fall()
				end
			end
		end
	end

	end
end

function Level:buildLevelGeometry()

	local wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 50*self.levelScale,50*self.levelScale)
	self:addChild(wall)
	wall:setMaterialByName(self.levelSkin.."Wall", Services.ResourceManager:getGlobalPool())
	wall:Translate(0,0,(-24*self.levelScale)-(self.levelScale*0.5))

	wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 50*self.levelScale,50*self.levelScale,0)
	self:addChild(wall)
	wall:setYaw(180)
	wall:setMaterialByName(self.levelSkin.."Wall", Services.ResourceManager:getGlobalPool())
	wall:Translate(0,0,24*self.levelScale)

	wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 50*self.levelScale,50*self.levelScale,0)
	wall:setYaw(90)
	self:addChild(wall)
	wall:setMaterialByName(self.levelSkin.."Wall", Services.ResourceManager:getGlobalPool())
	wall:Translate((-24*self.levelScale)+(self.levelScale*0.3),0,0)

	wall = ScenePrimitive(ScenePrimitive.TYPE_VPLANE, 50*self.levelScale,50*self.levelScale,0)
	wall:setYaw(-90)
	self:addChild(wall)
	wall:setMaterialByName(self.levelSkin.."Wall", Services.ResourceManager:getGlobalPool())
	wall:Translate(25*self.levelScale,0,0)

	local worldMesh = Mesh(Mesh.TRI_MESH)

	for i=0,48 do
		for j=0,48 do
		if self.worldData[i][j] == 0 then
			self:createFloorTile(worldMesh, i,j, 0.0)
		elseif self.worldData[i][j] == 2 then
			self:createFloorTile(worldMesh, i,j, 3.0)
		elseif self.worldData[i][j] == 3 then
			self:createFloorTile(worldMesh, i,j, 4.0)
		elseif self.worldData[i][j] == 9 then
			self:createHoleTile(worldMesh, i,j)
		else
			self:createWallTile(worldMesh, i,j, 0.0)	  
		  end
		end  
	end

	worldMesh:calculateNormals(false)  
	world = SceneMesh.SceneMeshFromMesh(worldMesh)
	world.ownsMesh = true
	world:setMaterialByName(self.levelSkin, Services.ResourceManager:getGlobalPool())

	world:Translate(-24*self.levelScale,0,-24*self.levelScale)
	world:Translate(self.levelScale*0.5,0,-0.5*self.levelScale)
	self:addChild(world)
	world:cacheToVertexBuffer(true)

	self:initBlood()

	for i=0,self.numProps-1 do
		local prop = self.props[i]
		self:addChild(prop)
	end


	for i=0,self.numCreatures-1 do
		local creature = self.creatures[i]
		self:addChild(creature)
	end


end
