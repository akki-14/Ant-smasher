require("spriteAnim")
require("smash")
FlyCreate = {
    new = function(group,setSeq)
        local fly = SpriteAnim.new2()
        local moveFly
        fly.taps = 0
        --fly.rotation = 180
        local endTime = 1500
        if (score < 1200 )then
            endTime = math.random(1500,2000)
        elseif (score < 3000 )then
            endTime = math.random(1100,1500)
        elseif (score < 5000 )then
            endTime = math.random(800,1200)
        elseif (score < 7000 )then
            endTime = math.random(800,1000)
        else
            endTime = 700
        end
        fly:setSequence("fly")
        fly:play()
        fly.x = math.random(200,400)
        fly.y = 1280
        group:insert( fly )
        fly:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        function moveFly(obj)
            if obj.y > 0 then
                transition.to(obj,{x = math.random (100 ,display.viewableContentWidth - 100), y = obj.y - 330 ,time = endTime,
                onComplete = function() moveFly(obj) end })
            else
                transition.to(obj,{time = 50 , onComplete = function() SpriteAnim.endLife(obj) ; obj:removeSelf(); obj = nil end})
            end
        end
        
        --transition.to(fly,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(fly) ; fly:removeSelf(); fly = nil end })
        moveFly( fly )
        --transition.to(fly,{ y = fly.y + 300,time=endTime, onComplete = function()	moveFly( fly )	end } )
        
        
        
        fly:addEventListener("touch",Smash.new)
    end
    
    
}