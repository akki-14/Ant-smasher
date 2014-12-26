require("spriteAnim")
require("smash")
CreateAntTwin = {
    new = function(group,setSeq)
        
        
        local ant = SpriteAnim.new()
        ant.taps = 0
        --ant.rotation = 180
        if setSeq == "scorpio" then
            if math.random( 5 ) == 1 then 
                ant:addEventListener("tap",Smash.new)
            else
                setSeq = "ant1"
                ant:addEventListener("touch",Smash.new)
            end
        else
            setSeq = "ant1"
            ant:addEventListener("touch",Smash.new)
        end
        
        local endTime = 10000
        if (score < 200 )then
            endTime = 7500
        elseif 	(score < 500 )then
            endTime = 6500
        elseif 	(score < 800 )then
            endTime = 5000
        elseif 	(score < 1200 )then
            endTime = 4500
        elseif 	(score < 1500 )then
            endTime = 4000
        elseif 	(score < 2500 )then
            endTime = 3700
        else
            endTime = 3300
        end
        ant:setSequence(setSeq)
        ant:play()
        ant.x = display.contentCenterX - 100
        group:insert( ant )
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        
        local ant1 = SpriteAnim.new()
        ant1.taps = 0
        --ant1.rotation = 180
        if setSeq == "scorpio" then
            if math.random( 3 ) ~= 1 then 
                setSeq = "ant1"
            end
            
        end
        ant1:addEventListener("touch",Smash.new)
        ant1:setSequence(setSeq)
        ant1:play()
        ant1.x = display.contentCenterX + 100
        group:insert( ant1 )
        ant1:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        
        transition.from(ant,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
        transition.from(ant1,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant1) ; ant1:removeSelf(); ant1 = nil end })
        
        if(math.random(5) == 2 ) then
            local bee = SpriteAnim.new2()
            local toFro
            local tempX
            --bee.rotation = 180
            bee:setSequence("bee")
            bee:play()
            if math.random(2) == 1 then
                bee.x =  display.contentCenterX - 200
                tempX =  display.contentCenterX - 200
                
            else
                bee.x =  display.contentCenterX 
                tempX =  display.contentCenterX 
            end
            group:insert( bee )
            bee:addEventListener("touch",Smash.new)
            bee:addEventListener( "sprite", SpriteAnim.spriteListener )
            toFro = function()
                print("1",bee.x,bee)
                bee.x = tempX
                    transition.to(bee,{ x = bee.x + 200,time=1000 , onComplete = function() 
                        print("2",bee.x,bee)
                            transition.to(bee,{ x = bee.x - 200,time=1000, onComplete = function()
                                print("3",bee.x,bee)
                                toFro()
                        end})
                end})
            end
            toFro()
            transition.from(bee,{y = 1280,time=endTime, onComplete = function() transition.cancel(bee); bee:removeSelf(); bee = nil end })
        end
        
        
    end
    
    
}