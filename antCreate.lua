require("spriteAnim")
require("smash")
CreateAnt = {
		new = function(group,setSeq)
			local ant = SpriteAnim.new()
			ant.taps = 0
			--ant.rotation = 180
			local endTime = 10000
			if (score < 100 )then
				endTime = math.random(6000,9000)
			elseif 	(score < 250 )then
				endTime = math.random(6000,8000)
			elseif 	(score < 500 )then
				endTime = math.random(4500,6500)
			elseif 	(score < 1000 )then
				endTime = math.random(4000,5500)
			elseif 	(score < 1500 )then
				endTime = math.random(3500,5000)
			else
				endTime = math.random(3000,4500)
			end
			ant:setSequence(setSeq)
			ant:play()
			ant.x = math.random(50,680)
			group:insert(ant)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			
			transition.from(ant,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
			if( setSeq == "scorpio") then
				ant:addEventListener("tap",Smash.new)
			else
				ant:addEventListener("touch",Smash.new)
			end
		end


}