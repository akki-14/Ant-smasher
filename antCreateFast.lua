require("spriteAnim")
require("smash")

CreateAntFast = {
    new = function(group,setSeq)
        
        local endTime = 2000
        local diffTime = 1000
        if (score < 500 )then
            endTime = 2000
            diffTime = 800
        elseif(score < 1700 )then
            endTime = 1800
            diffTime = 800
        elseif(score < 3000 )then
            endTime = 1600
            diffTime = 600
        elseif(score < 7000 )then
            endTime = 1500
            diffTime = 500
        else
            endTime = 1400
            diffTime = 400
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
        
        
            transition.to( ant, {  y = ant.y - math.random(100,300), time=endTime ,onComplete= function()  
                
                    transition.to( ant, { y = 350, time = diffTime,onComplete= function() 
                        
                            transition.to( ant, {  y = 0 , time = endTime ,onComplete= function() 
                                
                                SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
                                
                                
                        end })
                        
                end})
                
        end})
        
        
        
    end
    
    
}