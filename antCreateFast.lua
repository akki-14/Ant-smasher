require("spriteAnim")
require("smash")

CreateAntFast = {
    new = function(group,setSeq)
        
        local endTime = 2000
        local diffTime = 1000
        if (score < 900 )then
            endTime = math.random(1900,2100)
            diffTime = 200
        elseif(score < 1700 )then
            endTime = math.random(1700,1800)
            diffTime = 200
        else
            endTime = math.random(1500,1600)
            diffTime = math.random(200,300)
        end	
        
        endTime = endTime * settings.gameSpeed
        
        local ant = SpriteAnim.new()
        ant.taps = 0
        if setSeq == "scorpio" then
            if math.random( 3 ) ~= 1 then 
                setSeq = "ant1"
            end	
            
        end
        ant:addEventListener("touch",Smash.new)
        ant:setSequence(setSeq)
        ant:play()
        ant.x = math.random(700)
        ant.y = 1280
        --ant.rotation = 180
        group:insert( ant )
        ant:addEventListener( "sprite", SpriteAnim.spriteListener )
        
        
            transition.to( ant, {  y = ant.y - math.random(200,300), time=endTime ,onComplete= function()  
                
                    transition.to( ant, { y = ant.y - math.random(200,550), time=endTime - 1200,onComplete= function() 
                        
                            transition.to( ant, {  y = 0 , time=endTime ,onComplete= function() 
                                
                                SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                
                                
                        end })
                        
                end})
                
        end})
        
        
        
    end
    
    
}