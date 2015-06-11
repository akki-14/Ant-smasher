require("spriteAnim")

CreateAntZigZag = {
    new = function(group,setSeq)
        
        local ant = SpriteAnim.new()
        ant.taps = 0
        local endTime = 1400
        
        if (score < 500 )then
            endTime = endTime
        elseif 	(score < 1000 )then
            endTime = endTime - 200
        elseif 	(score < 1500 )then
            endTime = endTime - 300
        elseif (score < 3000 )then
            endTime = endTime - 400
        elseif (score < 5000 )then
            endTime = endTime - 500
        elseif (score < 7000 )then
            endTime = endTime - 600
        else
            endTime = endTime - 700
        end
        
        endTime = endTime * settings.gameSpeed
        
        ant:setSequence(setSeq)
        ant:play()
        ant.x = math.random(bufferWidth + 200 , display.viewableContentWidth - 200)
        ant.y = 1280
        --ant.rotation = 180
        print(gameOver,ant.sequence)
        group:insert( ant )
        ant:addEventListener("touch",Smash.new)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        if ant.x < display.contentCenterX then
            ant.rotation = ant.rotation + 45
                transition.to( ant, { x = ant.x + 150, y = ant.y - 320, time=endTime,onComplete= function()  
                    
                    ant.rotation = ant.rotation - 90
                        transition.to( ant, { x = ant.x - 300, y = ant.y - 320, time=endTime,onComplete= function() 
                            
                            ant.rotation = ant.rotation + 90
                                transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=endTime,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation - 90
                                        transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=endTime,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
        else
            ant.rotation = ant.rotation - 45
                transition.to( ant, { x = ant.x - 150, y = ant.y - 320 , time=endTime,onComplete= function()  
                    
                    ant.rotation = ant.rotation + 90
                        transition.to( ant, { x = ant.x + 300, y = ant.y - 320, time=endTime,onComplete= function() 
                            
                            ant.rotation = ant.rotation - 90
                                transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=endTime,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation + 90
                                        transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=endTime,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
            
            
            
            
        end
        
    end
    
    
}