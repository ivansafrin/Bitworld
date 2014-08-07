
class "Prop" (Entity)

function Prop:Prop(propIndex)
    Entity.Entity(self)

	self.ownsChildren = true

    self.__scale = 0.3 * 0.25
    local scale = self.__scale

    self.shadow = ScenePrimitive(ScenePrimitive.TYPE_PLANE, 0.15,0.15,0)
    self.shadow:setPosition(0.001, 0.04, -0.00)
    self.shadow:setColor(1,1,1,0.58)
    self.shadow:setMaterialByName("Shadow", Services.ResourceManager:getGlobalPool())
--    self:addChild(self.shadow)

    local bodyMesh = Mesh(Mesh.TRI_MESH)
	bodyMesh.indexedMesh = false
    local sheight = scale  

    local indexX = ((propIndex-1) % 16)
    local indexY = 1 - math.floor(propIndex/16)

    if indexX == 16 then indexX = 0 end     

    cellSizeX = 1/16
    cellSizeY = 1/2

	bodyMesh:addVertex(scale,0, 0,(indexX * cellSizeX) + cellSizeX,indexY*cellSizeY)  
	bodyMesh:addVertex(scale,sheight,0,(indexX * cellSizeX) + cellSizeX,(indexY * cellSizeY) + cellSizeY)
	bodyMesh:addVertex(0, sheight,0,indexX*cellSizeX,(indexY * cellSizeY) + cellSizeY)
 
	bodyMesh:addVertex(0,0,0,(indexX * cellSizeX),(indexY * cellSizeY))       
	bodyMesh:addVertex(0+scale,0,0,(indexX * cellSizeX)+cellSizeX,(indexY * cellSizeY))  
	bodyMesh:addVertex(0,sheight,0,(indexX * cellSizeX),(indexY * cellSizeY)+cellSizeY)
  
	bodyMesh:calculateNormals()
	self.body = SceneMesh.SceneMeshFromMesh(bodyMesh)

	self.body.billboardMode = true
	self.body.billboardRoll = true
	self.body:setMaterialByName("Prop", Services.ResourceManager:getGlobalPool())
	self.body.alphaTest = true
	self:addChild(self.body)
end