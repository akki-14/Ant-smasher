require("spriteAnim")
require("smash")
CreateAntSShape = {
    new = function(group,setSeq)
        local ant = SpriteAnim.new()
        ant.taps = 0
        local antWidth = ant.contentWidth
        --ant.rotation = 180
        local END_TIME = 1500
        if 	(score < 500 )then
            END_TIME = END_TIME 
        elseif 	(score < 1000 )then
            END_TIME = END_TIME - 200
        elseif 	(score < 1500 )then
            END_TIME = END_TIME - 300
        elseif 	(score < 2000 )then
            END_TIME = END_TIME - 400
        elseif 	(score < 3000 )then
            END_TIME = END_TIME - 500
        elseif 	(score < 4000 )then
            END_TIME = END_TIME - 600
        else
            END_TIME = END_TIME - 700
        end
        ant:setSequence(setSeq)
        ant:play()
        ant.y = 1280
        ant.x = math.random(bufferWidth+50+antWidth,720-50-bufferWidth-antWidth)
        group:insert(ant)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        local function antTrajectory()
            local xVal,yVal
            if(ant.x < TOTAL_WIDTH/2) then
                xVal = math.random(TOTAL_WIDTH/2-ant.x + 40,TOTAL_WIDTH - ant.x - bufferWidth)
            else
                xVal = - math.random(ant.x - TOTAL_WIDTH/2 + 40,ant.x+bufferWidth)
            end
            ant.rotation = 0
            yVal = math.random(300,500)
                transition.to( ant, {  y = ant.y - yVal, time=END_TIME,onComplete= function() 
                    
                    if(ant.y < 0) then
                        SpriteAnim.endLife(ant) ; 
                        ant:removeSelf(); 
                        ant = nil
                    else
                        if xVal > 0 then
                            ant.rotation = 90
                        else
                            ant.rotation = -90
                        end
                            transition.to( ant, { x = ant.x + xVal, time=END_TIME/2,onComplete= function() 
                                if(ant.y < 0) then
                                    SpriteAnim.endLife(ant); 
                                    ant:removeSelf(); 
                                    ant = nil
                                else
                                    antTrajectory()
                                end
                        end})
                    end
            end})
        end
        
        antTrajectory()
        
        
        ant:addEventListener("touch",Smash.new)
    end
    
    
}