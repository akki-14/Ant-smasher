require("spriteAnim")
require("smash")
CreateAnt = {
		new = function(group,setSeq,target)
			local ant = SpriteAnim.new()
			local valY 
			ant.taps = 0
			--ant.rotation = 180
			local endTime = 10000
			if (score < 100 )then
				endTime = math.random(7000,9000)
			elseif 	(score < 350 )then
				endTime = math.random(6000,9000)
			elseif 	(score < 600 )then
				endTime = math.random(5000,7000)
			elseif 	(score < 1400 )then
				endTime = math.random(4000,6500)
			elseif 	(score < 2000 )then
				endTime = math.random(3000,5000)
			else
				endTime = math.random(2500,4000)
			end
			ant:setSequence(setSeq)
			ant:play()
			group:insert(ant)
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
							endTime = endTime * 0.6
						else
							endTime = endTime * 0.6
						end
						transition.to(ant,{y = -10,time=endTime * 0.8, onComplete = function() 
							SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil 
								end })
					 end })
			end

			if( setSeq == "scorpio") then
				ant:addEventListener("tap",Smash.new)
			else
				ant:addEventListener("touch",Smash.new)
			end
		end


}