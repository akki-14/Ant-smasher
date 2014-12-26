require("spriteAnim")

CreateAntZigZag = {
    new = function(group,setSeq)
        
        local ant = SpriteAnim.new()
        ant.taps = 0
        local END_TIME = 1400
        
        if (score < 500 )then
            END_TIME = END_TIME
        elseif 	(score < 1000 )then
            END_TIME = END_TIME - 200
        elseif 	(score < 1500 )then
            END_TIME = END_TIME - 300
        elseif (score < 2000 )then
            END_TIME = END_TIME - 400
        elseif (score < 3000 )then
            END_TIME = END_TIME - 500
        elseif (score < 4000 )then
            END_TIME = END_TIME - 600
        else
            END_TIME = END_TIME - 700
        end
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
                transition.to( ant, { x = ant.x + 150, y = ant.y - 320, time=END_TIME,onComplete= function()  
                    
                    ant.rotation = ant.rotation - 90
                        transition.to( ant, { x = ant.x - 300, y = ant.y - 320, time=END_TIME,onComplete= function() 
                            
                            ant.rotation = ant.rotation + 90
                                transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=END_TIME,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation - 90
                                        transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=END_TIME,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
        else
            ant.rotation = ant.rotation - 45
                transition.to( ant, { x = ant.x - 150, y = ant.y - 320 , time=END_TIME,onComplete= function()  
                    
                    ant.rotation = ant.rotation + 90
                        transition.to( ant, { x = ant.x + 300, y = ant.y - 320, time=END_TIME,onComplete= function() 
                            
                            ant.rotation = ant.rotation - 90
                                transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=END_TIME,onComplete= function() 
                                    
                                    ant.rotation = ant.rotation + 90
                                        transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=END_TIME,onComplete= function()
                                            
                                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                            
                                    end})
                                    
                            end })
                            
                    end})
                    
            end})
            
            
            
            
        end
        
    end
    
    
}