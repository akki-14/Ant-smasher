require("spriteAnim")
require("smash")
CreateAntBoss = {
    new = function(group,setSeq)
        local ant = SpriteAnim.new()
        ant.taps = 0
        --ant.rotation = 180
        local endTime = 14000
        if (score < 500 )then
            endTime = endTime
        elseif 	(score < 1000 )then
            endTime = endTime - 1500
        elseif 	(score < 1500 )then
            endTime = endTime - 2500
        elseif 	(score < 2000 )then
            endTime = endTime - 4000
        elseif 	(score < 3000 )then
            endTime = endTime - 5500
        elseif 	(score < 4000 )then
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