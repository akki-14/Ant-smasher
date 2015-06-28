require("spriteAnim")
require("smash")

CreateAnt = {
    new = function(grp,setSeq,target)
        local ant = SpriteAnim.new()
        local valY 
        ant.taps = 0
        --ant.rotation = 180
        local endTime = 9000
        if (score < 250 )then
            endTime = endTime
        elseif 	(score < 500 )then
            endTime = endTime - 1500
        elseif 	(score < 1000 )then
            endTime = endTime - 2500
        elseif 	(score < 1500 )then
            endTime = endTime - 3500
        elseif 	(score < 2000 )then
            endTime = endTime - 4000
        elseif 	(score < 3000 )then
            endTime = endTime - 5000
        elseif 	(score < 4000 )then
            endTime = endTime - 4500
        else
            endTime = endTime - 4000
        end

        endTime = endTime * settings.gameSpeed

        ant:setSequence(setSeq)
        ant:play()
        grp:insert(ant)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        if target == nil then
            valY = 1280
            ant.x = math.random(50,680)
            transition.from(ant,{y = valY,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
        else
            valY = target.y
            ant.y = valY
            ant.x = target.x
            ant:scale(0.3,0.3)
            ant.alpha = 0.2
            local translateY = math.random( 0,TOTAL_HEIGHT - valY )
                transition.to(ant,{y = ant.y + translateY, x = math.random(50,680),xScale = 1,yScale=1,alpha=1 ,time=700, onComplete = function() 
                    if ant.y < TOTAL_HEIGHT / 2 then
                        endTime = endTime * 0.8
                    else
                        endTime = endTime * 0.7
                    end
                        transition.to(ant,{y = -10,time=endTime , onComplete = function() 
                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil 
                    end })
            end })
        end
        
        
        ant:addEventListener("touch",Smash.new)
    end
    
    
}