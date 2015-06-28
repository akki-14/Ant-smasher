require("spriteAnim")
require("smash")

Frog = {
    new = function(group,setSeq)
        local frog = SpriteAnim.frog()
        local valY 
        local jump
        local hopValue = 140
        local hopDelay = 1200
        local finalPoint = 50
        local jumpTimer
        frog.taps = 0

        local endTime = 600
        if (score < 250 )then
            endTime = endTime
        elseif 	(score < 500 )then
            hopValue = 160
        elseif  (score < 1000 )then
            hopValue = 180
            hopDelay = 1050
        elseif  (score < 2000 )then
            hopValue = 190
            hopDelay = 1000
        elseif 	(score < 3000 )then
            hopValue = 220
            hopDelay = 950
            endTime = endTime - 50
        elseif 	(score < 4000 )then
            endTime = endTime - 100
            hopValue = 220
            hopDelay = 750
        else
            endTime = endTime - 100
            hopValue = 240
            hopDelay = 600
        end

        endTime = endTime * settings.gameSpeed
        hopValue = hopValue * (1/settings.gameSpeed)
        hopDelay = hopDelay * settings.gameSpeed
        print("speed",settings.gameSpeed)
        frog:setSequence(setSeq)
        frog:play()
        group:insert(frog)
        frog:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        valY = 1280
        frog.y = valY
        frog.x = math.random(50,680)

        function jump()
            frog:play()
            transition.to(frog,{y = frog.y - hopValue, time = endTime, onComplete = function() 
                    if frog.y <= finalPoint then
                        SpriteAnim.endLife(frog) ; frog:removeSelf(); frog = nil ;
                        timer.cancel(jumpTimer)
                    end
                         end })
        end
       jumpTimer = timer.performWithDelay( hopDelay, jump,-1 )
            -- transition.to(frog,{ y = frog.y - hopValue, time = endTime , onComplete = function ()
            -- })
        
        function onSmash( event)
          Smash.new(event)
          timer.cancel(jumpTimer)
        end

        frog:addEventListener("touch",onSmash)
    end
    
    
}