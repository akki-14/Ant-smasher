require("spriteAnim")
require("smash")
CreateAntBoss = {
    new = function(group,setSeq)
        local ant = SpriteAnim.new()
        ant.taps = 0
        --ant.rotation = 180
        local endTime = 16000
        if (score < 500 )then
            endTime = endTime
        elseif 	(score < 1000 )then
            endTime = endTime - 2000
        elseif 	(score < 5000 )then
            endTime = endTime - 3500
        elseif 	(score < 8000 )then
            endTime = endTime - 7000
        else
            endTime = endTime - 8000
        end
        
        
        endTime = endTime * settings.gameSpeed

        ant:setSequence(setSeq)
        ant:play()
        ant:scale(2,2)
        ant.x = math.random(ant.contentWidth+50,720-ant.contentWidth-50)
        group:insert(ant)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        transition.from(ant,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
        if( setSeq == "antBoss") then
            ant:addEventListener("tap",Smash.new)
        else
            ant:addEventListener("touch",Smash.new)
        end
    end
    
    
}