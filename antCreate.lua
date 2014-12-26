require("spriteAnim")
require("smash")
CreateAnt = {
    new = function(group,setSeq,target)
        local ant = SpriteAnim.new()
        local valY 
        ant.taps = 0
        --ant.rotation = 180
        local END_TIME = 9000
        if (score < 250 )then
            END_TIME = END_TIME
        elseif 	(score < 500 )then
            END_TIME = END_TIME - 1500
        elseif 	(score < 1000 )then
            END_TIME = END_TIME - 2500
        elseif 	(score < 1500 )then
            END_TIME = END_TIME - 3500
        elseif 	(score < 2000 )then
            END_TIME = END_TIME - 4000
        elseif 	(score < 3000 )then
            END_TIME = END_TIME - 5000
        elseif 	(score < 4000 )then
            END_TIME = END_TIME - 4500
        else
            END_TIME = END_TIME - 4000
        end
        ant:setSequence(setSeq)
        ant:play()
        group:insert(ant)
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        if target == nil then
            valY = 1280
            ant.x = math.random(50,680)
            transition.from(ant,{y = valY,time=END_TIME, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
        else
            valY = target.y
            ant.y = valY
            ant.x = target.x
            ant:scale(0.3,0.3)
            ant.alpha = 0.2
            local translateY = math.random( 0,TOTAL_HEIGHT - valY )
                transition.to(ant,{y = ant.y + translateY, x = math.random(50,680),xScale = 1,yScale=1,alpha=1 ,time=700, onComplete = function() 
                    if ant.y < TOTAL_HEIGHT / 2 then
                        END_TIME = END_TIME * 0.8
                    else
                        END_TIME = END_TIME * 0.7
                    end
                        transition.to(ant,{y = -10,time=END_TIME , onComplete = function() 
                            SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil 
                    end })
            end })
        end
        
        
        ant:addEventListener("touch",Smash.new)
    end
    
    
}