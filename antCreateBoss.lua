require("spriteAnim")
require("smash")
CreateAntBoss = {
    new = function(group,setSeq)
        local ant = SpriteAnim.new()
        ant.taps = 0
        --ant.rotation = 180
        local END_TIME = 14000
        if (score < 500 )then
            END_TIME = END_TIME
        elseif 	(score < 1000 )then
            END_TIME = END_TIME - 1500
        elseif 	(score < 1500 )then
            END_TIME = END_TIME - 2500
        elseif 	(score < 2000 )then
            END_TIME = END_TIME - 4000
        elseif 	(score < 3000 )then
            END_TIME = END_TIME - 5500
        elseif 	(score < 4000 )then
            END_TIME = END_TIME - 7000
        else
            END_TIME = END_TIME - 8000
        end
        
        ant:setSequence(setSeq)
        ant:play()
        ant:scale(2,2)
        ant.x = math.random(ant.contentWidth+50,720-ant.contentWidth-50)
        group:insert(ant)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        transition.from(ant,{y = 1280,time=END_TIME, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
        if( setSeq == "antBoss") then
            ant:addEventListener("tap",Smash.new)
        else
            ant:addEventListener("touch",Smash.new)
        end
    end
    
    
}