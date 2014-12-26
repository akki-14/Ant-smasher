require("spriteAnim")

CreateAntCross = {
    new = function(group,setSeq)
        
        local diff = 0
        
        if(setSeq == "scorpio") then
            if(math.random(4) == 2) then
                setSeq = "ant1"
            end
        end
        
        local endTime = 2000
        if (score < 300 )then
            endTime = 1500
        elseif 	(score < 900 )then
            endTime = 1200
        elseif (score < 1500 )then
            endTime = 1050
        elseif (score < 2200 )then
            endTime = 900
        else
            endTime = 850
        end
        local ant = SpriteAnim.new()
        ant.taps = 0
        ant:setSequence(setSeq)
        ant:play()
        ant.x = math.random(100,300)
        ant.y = 1280
        --ant.rotation = 180
        group:insert( ant )
        
        local ant1 = SpriteAnim.new()
        ant1.taps = 0
        ant1:setSequence(setSeq)
        ant1:play()
        ant1.x = math.random(400,650)
        ant1.y = 1280
        --ant1.rotation = 180
        group:insert( ant1 )
        
        diff = (ant1.x + ant.x) / 2
        
        ant:addEventListener("touch",Smash.new)
        ant1:addEventListener("touch",Smash.new)
        
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        ant1:addEventListener( "sprite", SpriteAnim.spriteListener )
        
            transition.to( ant, { x = ant.x + diff, y = ant.y - 320, rotation = ant.rotation + 45 , time=endTime,onComplete= function()  
                
                ant.rotation = ant.rotation - 90
                    transition.to( ant, { x = ant.x - diff, y = ant.y - 320, time=endTime,onComplete= function() 
                        
                        ant.rotation = ant.rotation + 90
                            transition.to( ant, { x = ant.x + diff, y = ant.y - 320 , time=endTime,onComplete= function() 
                                
                                ant.rotation = ant.rotation - 90
                                    transition.to( ant, { x = ant.x - diff, y = ant.y - 320 , time=endTime,onComplete= function()
                                        
                                        SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                        
                                end})
                                
                        end })
                        
                end})
                
        end})
        
        
        
            transition.to( ant1, { x = ant1.x - diff, y = ant1.y - 320, rotation = ant1.rotation - 45 , time=endTime,onComplete= function()  
                
                ant1.rotation = ant1.rotation + 90
                    transition.to( ant1, { x = ant1.x + diff, y = ant1.y - 320, time=endTime,onComplete= function() 
                        
                        ant1.rotation = ant1.rotation - 90
                            transition.to( ant1, { x = ant1.x - diff, y = ant1.y - 320 , time=endTime,onComplete= function() 
                                
                                ant1.rotation = ant1.rotation + 90
                                    transition.to( ant1, { x = ant1.x + diff, y = ant1.y - 320 , time=endTime,onComplete= function()
                                        
                                        SpriteAnim.endLife(ant1) ; ant1:removeSelf(); ant1 = nil
                                        
                                end})
                                
                        end })
                        
                end})
                
        end})
        
    end
    
    
}