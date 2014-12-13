require("spriteAnim")
require("smash")
CreateAntBoss = {
		new = function(group,setSeq)
			local ant = SpriteAnim.new()
			ant.taps = 0
			--ant.rotation = 180
			local endTime = 12000
			if (score < 100 )then
				endTime = math.random(9000,11000)
			elseif 	(score < 350 )then
				endTime = math.random(7500,9000)
			elseif 	(score < 800 )then
				endTime = math.random(6500,8000)
			elseif 	(score < 1500 )then
				endTime = math.random(5500,7000)
			elseif 	(score < 2500 )then
				endTime = math.random(5000,6500)
			else
				endTime = math.random(5000,6500)
			end
			 
			ant:setSequence(setSeq)
			ant:play()
			ant:scale(2,2)
			ant.x = math.random(50,680)
			group:insert(ant)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			
			ant.transition = transition.from(ant,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
			if( setSeq == "scorpio") then
				ant:addEventListener("tap",Smash.new)
			elseif( setSeq == "antBoss") then
				ant:addEventListener("tap",Smash.new)
			else
				ant:addEventListener("touch",Smash.new)
			end
		end


}