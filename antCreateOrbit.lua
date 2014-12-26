require("spriteAnim")

CreateAntOrbit = {
    new = function(group,setSeq)
        local ant = SpriteAnim.new2()
        local angle = 0
        local initx,inity = 200,300
        local orbit
        local circle
        local update
        local tempTime			
        
        if( score < 1000) then
            tempTime = math.random(7000,8000)
        elseif score < 2000 then
            tempTime = math.random(5000,7000)
        else
            tempTime = math.random(5000,6000)
        end
        
        ant:setSequence(setSeq)
        ant:play()
        ant.x = math.random(60,650)
        --ant.rotation = 180
        group:insert( ant )
        ant:addEventListener("touch",Smash.new)
        
        local ax,ay = ant.x,ant.y - 150
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        transition.from(ant,{y = 1280,time=tempTime, onComplete = function() ant:removeSelf(); ant = nil end })
        
        circle= display.newImage(group,"images/life.png",math.random(300,450) , -300)
        circle.sequence = "gainLife"
        circle:addEventListener("touch",Smash.new)
        function orbit(ax,ay,ox,oy)
            if(ant.x ~= nil and circle ~= nil) then
                local theta = (angle * math.pi) / 180
                
                
                local px = math.cos(theta) * (ax-ox) - math.sin(theta) * (ay-oy) + ox
                local py = math.sin(theta) * (ax-ox) + math.cos(theta) * (ay-oy) + oy
                ax = px
                ay = py
                --print(px,py)
                circle.x = px 
                circle.y = py
                angle = angle + 9
                if ant ~=nil then
                    circle.tm = timer.performWithDelay(60,update)
                end
            else
                print("cancel transition")
                timer.cancel(circle.tm)	
            end
        end
        
        function update(event)
            if ant ~= nil and ant.x ~= nil then
                orbit(ax,ay,ant.x,ant.y)
                ay = ant.y - 150 
                --inity = inity + 3
            elseif circle ~= nil and orbitFlag  then
                print("circle")
                if gameOver == false then
                    circle:removeSelf() ; circle = nil
                end
            end
        end
        
        timer.performWithDelay(50,update)
        
    end
    
    
}