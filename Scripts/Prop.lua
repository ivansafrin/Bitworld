
class "Prop" (SceneEntity)

function Prop:Prop(propIndex)
    SceneEntity.SceneEntity(self)

    self.scale = 0.3 * 0.25
    local scale = self.scale

    self.shadow = ScenePrimitive(ScenePrimitive.TYPE_PLANE, 0.15,0.15,0)
    self.shadow.pitch = -90
    self.shadow.y = 0.001
    self.shadow.x = 0.04
    self.shadow.z = -0.00
    self.shadow:setColor(1,1,1,0.58)
    self.shadow:setMaterialByName("Shadow")
    self:addChild(self.shadow)

    local bodyMesh = Mesh(Mesh.TRI_MESH)
    local sheight = scale  

  i = 0
  j = 0


    local indexX = ((propIndex-1) % 16)
    local indexY = 1 - math.floor(propIndex/16)

    if indexX == 16 then indexX = 0 end     

    cellSizeX = 1/16
    cellSizeY = 1/2

  
   newPoly = Polygon()
  newPoly:addVertex((i*self.scale)+scale,0,(j*scale),(indexX * cellSizeX) + cellSizeX,indexY*cellSizeY)  
        newPoly:addVertex((i*scale)+scale,sheight,(j*scale),(indexX * cellSizeX) + cellSizeX,(indexY * cellSizeY) + cellSizeY)
  newPoly:addVertex((i*scale),sheight,(j*scale),indexX*cellSizeX,(indexY * cellSizeY) + cellSizeY)

     bodyMesh:addPolygon(newPoly)    
 
        newPoly = Polygon()
        newPoly:addVertex((i*scale),0,(j*scale),(indexX * cellSizeX),(indexY * cellSizeY))       
  newPoly:addVertex((i*scale)+scale,0,(j*scale),(indexX * cellSizeX)+cellSizeX,(indexY * cellSizeY))  
  newPoly:addVertex((i*scale),sheight,(j*scale),(indexX * cellSizeX),(indexY * cellSizeY)+cellSizeY)
     bodyMesh:addPolygon(newPoly)    
  
  bodyMesh:calculateNormals()
  self.body = SceneMesh.SceneMeshFromMesh(bodyMesh)

--    self.body:cacheToVertexBuffer(true)
    self.body.billboardMode = true
    self.body.billboardRoll = true
  self.body:setMaterialByName("Prop")
    self.body.alphaTest = true

  self:addChild(self.body)
end