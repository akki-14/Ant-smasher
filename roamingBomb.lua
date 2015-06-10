require("smash")
local M = {}
M.__index = M
M.bombGroup = {}

local function showKilledObj(killedObj)
    
end

function M.new(initX,initY,grp,sceneGrp,direction)
    local self = setmetatable({}, M)
    
    local bomb = nil
    local walkTime = 3000
    
    --functions
    local startWalking
    local walkLeft
    local walkRight
    local startExplosion
    
    local function checkForObjectsInExplosion( antGroup , bomb, explosionProperty)
        local explosionRadius = explosionProperty.radius
        local isAutoExplosion = explosionProperty.autoExplosion
        local minX = bomb.x - explosionRadius
        local maxX = bomb.x + explosionRadius
        local miny = bomb.y - explosionRadius
        local maxY = bomb.y + explosionRadius
        if antGroup and antGroup.numChildren > 0 then
            local antStack = {}
            local totalAnts = antGroup.numChildren
            for i=1,totalAnts do
                if antGroup[i] and (antGroup[i].x > minX  and antGroup[i].x < maxX) and (antGroup[i].y > miny and 
                    antGroup[i].y < maxY) then
                    table.insert(antStack,antGroup[i])
                end
            end
            
            for k,v in pairs(antStack) do
                --                print("remove",v)
                transition.cancel(v)
                showKilledObj()
                Smash.new{target = v,isBombCollision = true}
                v:removeSelf()
                v = nil
                if isAutoExplosion then
                    print("explode",bomb)
                    self.explode()
                end
            end
        end
    end
    
    local function enterFrame(event)
        checkForObjectsInExplosion(self.audienceGrp, bomb , {radius = 60,autoExplosion = true}) 
    end
    
    
    function walkLeft(obj)
        if obj ~= nil then
            obj:setSequence("walk")
            obj:play()
            transition.to(obj, {time = walkTime,x = 0, onComplete = function() walkRight(obj) end } )
        end
    end
    
    
    function walkRight(obj)
        if obj then
            obj:setSequence("walk_inv")
            obj:play()
            transition.to(obj, {time = walkTime,x = TOTAL_WIDTH, onComplete = function () walkLeft(obj)  end} )
        end
    end
    
    function startWalking(event)
        local target = event.target
        if not gamePause then
            if target.sequence == "still" then
                if target.direction == "left" then
                    walkLeft(target)
                else
                    walkRight(target)
                end
                if target.isEnterFrame ~= true then 
                    target.isEnterFrame = true
                    Runtime:addEventListener( "enterFrame", enterFrame)
                end
            else
                self.explode()
            end
        end
        
    end
    
    function startExplosion(x,y)
        local explode = SpriteAnim.explode()
        explode.x = x
        explode.y = y 
        explode:scale(2.7,2.5)
        explode:play()
        sceneGrp:insert(explode)
        explode:addEventListener("sprite", function(event) 
            local target = event.target
            if event.phase == "ended" then
                    transition.to(target, {time = 700 ,alpha = 0.1 , onComplete = function() 
                        target:removeSelf()
                        target = nil
                    end
                })
            end
        end )
        SoundControl.explosion()
        checkForObjectsInExplosion(self.audienceGrp, explode,{radius = 250,autoExplosion = false})
    end
    
    
    self.explode = function()
        if bomb ~= nil then
            Runtime:removeEventListener( "enterFrame", enterFrame)
            startExplosion(bomb.x,bomb.y)            
            transition.cancel(bomb)
            bomb:removeSelf()
            bomb = nil
        end
    end
    
    self.start =  function()
        self.audienceGrp = grp
        bomb = SpriteAnim.roamingBomb()
        bomb.x = initX
        bomb.y = initY
        bomb.direction = direction
        bomb:setSequence("still")
        bomb:play()
        sceneGrp:insert(bomb)
        print("create bomb",bomb)
        bomb:addEventListener("tap", startWalking )
    end
    
    self.stop = function()
        Runtime:removeEventListener( "enterFrame", enterFrame)
    end
    
    self.start()
    table.insert(M.bombGroup,self)
    return self
end

M.destroyAll = function()
    print("roaming destroy")
    for k,v in pairs(M.bombGroup) do
        print("destroying",k)
        v.stop()
    end
end


return M