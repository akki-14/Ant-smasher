require("spriteAnim")

CreateAntOrbit = {
    new = function(group,beeGrp,setSeq)
        local bee = SpriteAnim.new2()
        local angle = 0
        local initx,inity = 200,300
        local orbit
        local circle
        local update
        local tempTime			
        
        if( score < 1000) then
            tempTime = math.random(7000,8000)
        elseif score < 4000 then
            tempTime = math.random(5000,7000)
        else
            tempTime = math.random(5000,6000)
        end
        
        bee:setSequence(setSeq)
        bee:play()
        bee.x = math.random(60,650)
        --bee.rotation = 180
        beeGrp:insert( bee )
        bee:addEventListener("touch",Smash.new)
        
        local ax,ay = bee.x,bee.y - 150
        bee:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        transition.from(bee,{y = 1280,time=tempTime, onComplete = function() bee:removeSelf(); bee = nil end })
        
        circle= display.newImage(group,"images/life.png",math.random(300,450) , -300)
        circle:scale(1.3,1.3)
        circle.sequence = "gainLife"
        circle:addEventListener("touch",Smash.new)
        function orbit(ax,ay,ox,oy)
            if(bee.x ~= nil and circle ~= nil) then
                local theta = (angle * math.pi) / 180
                
                
                local px = math.cos(theta) * (ax-ox) - math.sin(theta) * (ay-oy) + ox
                local py = math.sin(theta) * (ax-ox) + math.cos(theta) * (ay-oy) + oy
                ax = px
                ay = py
                --print(px,py)
                circle.x = px 
                circle.y = py
                angle = angle + 8
                if bee ~=nil then
                    circle.tm = timer.performWithDelay(40,update)
                end
            else
                print("cancel transition")
                timer.cancel(circle.tm)	
            end
        end
        
        function update(event)
            if bee ~= nil and bee.x ~= nil then
                orbit(ax,ay,bee.x,bee.y)
                ay = bee.y - 150 
                --inity = inity + 3
            elseif gameOver == false and circle ~= nil and orbitFlag  then
                circle:removeSelf() ; circle = nil
            end
        end
        
        timer.performWithDelay(20,update)
        
    end
    
    
}