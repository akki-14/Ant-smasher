local M = {}
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
                    print("remove",v)
                    transition.cancel(v)
                    v:removeSelf()
                    v = nil     
                    if isAutoExplosion then
                        M.explode()
                    end
                end
            end
    end
    
local function enterFrame(event)
    checkForObjectsInExplosion(M.audienceGrp, bomb , {radius = 100,autoExplosion = true}) 
end


function walkLeft(obj)
    if obj then
        transition.to(obj, {time = walkTime,x = 0, onComplete = function() walkRight(obj) end } )
    end
end


function walkRight(obj)
    if obj then
        transition.to(obj, {time = walkTime,x = TOTAL_WIDTH, onComplete = function () walkLeft(obj)  end} )
    end
end

function startWalking(event)
    local target = event.target
    if target.sequence == "frog" then
        target:setSequence("frogSmash")
        target:play()
        if target.direction == "left" then
            walkLeft(target)
        else
            walkRight(target)
        end
    else
        M.explode()
    end
    
end

function startExplosion(x,y)
    local explode = SpriteAnim.new()
    explode.x = x
    explode.y = y 
    explode:play()
    explode:addEventListener("sprite", function(event) 
        local target = event.target
        if event.phase == "ended" then
            target:removeSelf()
            target = nil
        end
    end )
    checkForObjectsInExplosion(M.audienceGrp, explode,{radius = 500,autoExplosion = false})
end


M.explode = function()
    print("explode")
    startExplosion(bomb.x,bomb.y)
    Runtime:removeEventListener( "enterFrame", enterFrame)
    bomb:removeSelf()
    bomb = nil
end

M.start =  function(grp,obj)
    M.audienceGrp = grp
    bomb = SpriteAnim.frog()
    bomb.x = TOTAL_WIDTH
    bomb.y = CENTER_Y
    bomb.direction = "left"
    bomb:play()
--    bomb:addEventListener("tap", function() M.explode() end)
    bomb:addEventListener("tap", startWalking )
    Runtime:addEventListener( "enterFrame", enterFrame)
end

M.stop = function()
    
end

return M