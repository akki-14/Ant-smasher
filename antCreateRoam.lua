require("spriteAnim")
require("smash")
CreateAntRoam = {
    new = function(group,setSeq,posX)
        
        local endTime = 1400
        if (score < 500 )then
            endTime = endTime
        elseif 	(score < 1000 )then
            endTime = endTime - 150
        elseif 	(score < 1500 )then
            endTime = endTime - 200
        elseif 	(score < 2000 )then
            endTime = endTime - 350
        elseif 	(score < 3000 )then
            endTime = endTime - 400
        elseif 	(score < 5000 )then
            endTime = endTime - 500
        else
            endTime = endTime - 600
        end
        
        endTime = endTime * settings.gameSpeed
        
        local ant = SpriteAnim.new()
        ant.taps = 0
        ant:setSequence(setSeq)
        ant:play()
        ant.x = posX
        ant.y = 1280
        --ant.rotation = 180
        group:insert( ant )
        ant:addEventListener("touch",Smash.new)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        if (ant.x < display.contentCenterX) then
            
            ant.rotation = ant.rotation + 55
                transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300, time=endTime,onComplete= function()  
                    
                    ant.rotation = ant.rotation - 110
                        transition.to( ant, { x = bufferWidth, y = ant.y - 300, time=endTime,onComplete= function() 
                            
                            ant.rotation = ant.rotation + 110
                                transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300 , time=endTime,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation - 110
                                        transition.to( ant, { x = bufferWidth, y = ant.y - 300 , time=endTime,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
            
        else			
            ant.rotation = ant.rotation - 55
                transition.to( ant, { x = bufferWidth, y = ant.y - 300, time=endTime,onComplete= function()  
                    
                    ant.rotation = ant.rotation + 110
                        transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300, time=endTime,onComplete= function() 
                            
                            ant.rotation = ant.rotation - 110
                                transition.to( ant, { x = bufferWidth , y = ant.y - 300 , time=endTime,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation + 110
                                        transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300 , time=endTime,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
        end
        
        
    end
    
    
}