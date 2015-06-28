local M = {}
local powerThunder = nil
local function thunderEnterFrame( event,antGroup )
    print(event,antGroup)
            if antGroup and antGroup.numChildren > 0 and not powerThunder then
                local antStack = {}
                for i=1,antGroup.numChildren do
                    if antGroup[i] and (antGroup[i].x > powerThunder.x - powerThunder.contentWidth / 2  and antGroup[i].x < powerThunder.x + powerThunder.contentWidth / 2) and (antGroup[i].y > powerThunder.y - 50 and 
                        antGroup[i].y < powerThunder.y + 50) then
                        print("ant in region",antGroup[i])
                        table.insert(antStack,antGroup[i])
                       
                    end
                end
                for k,v in pairs(antStack) do
                    print("remove",v)
                        transition.cancel(v)
                        v:removeSelf()
                        v = nil
                end
                -- print("num of ants ", antGroup.numChildren)
            end
    end
local enterFrame
--- Initiates a new GGFont object.
-- @return The new object.
M.initThunder =  function(grp)
    
    local chalkImage = display.newImage(grp, "images/chalk.png")
    chalkImage.strokeWidth = 10
    chalkImage:setStrokeColor( 1, 0, 0 )
    print("start thunder")
--    Runtime:addEventListener( "enterFrame", enterFrame)
    return chalkImage
    
end

M.endThunder = function()
--    Runtime:removeEventListener( "enterFrame", enterFrame)
end



M.freeze = function()
	print("Powers")
	
end

return M