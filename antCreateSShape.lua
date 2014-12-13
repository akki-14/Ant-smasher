require("spriteAnim")
require("smash")
CreateAntSShape = {
		new = function(group,setSeq)
			local ant = SpriteAnim.new()
			ant.taps = 0
			--ant.rotation = 180
			local endTime = 1000
			if (score < 100 )then
				endTime = math.random(1000,1000)
			elseif 	(score < 250 )then
				endTime = math.random(1000,2000)
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
			ant.y = 1280
			ant.x = math.random(bufferWidth+50,680-bufferWidth)
			group:insert(ant)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			
			local function antTrajectory()
				local xVal,yVal
				if(ant.x < TOTAL_WIDTH/2) then
					xVal = math.random(TOTAL_WIDTH/2-ant.x + 30,TOTAL_WIDTH - ant.x - bufferWidth)
				else
					xVal = - math.random(ant.x - TOTAL_WIDTH/2 + 30,ant.x+bufferWidth)
				end
				ant.rotation = 0
				yVal = math.random(300,500)
				transition.to( ant, {  y = ant.y - yVal, time=endTime,onComplete= function() 

						if(ant.y < 0) then
							SpriteAnim.endLife(ant) ; 
							ant:removeSelf(); 
							ant = nil
						else
							if xVal > 0 then
							ant.rotation = 90
							else
							ant.rotation = -90
							end
							transition.to( ant, { x = ant.x + xVal, time=endTime/2,onComplete= function() 
									if(ant.y < 0) then
										SpriteAnim.endLife(ant) ; 
										ant:removeSelf(); 
										ant = nil
									else
										antTrajectory()
									end
								end})
						end
					end})
			end

			antTrajectory()

			if( setSeq == "scorpio") then
				ant:addEventListener("tap",Smash.new)
			else
				ant:addEventListener("touch",Smash.new)
			end
		end


}