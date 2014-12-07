require("spriteAnim")

CreateAntZigZag = {
		new = function(group,setSeq)
		
			local ant = SpriteAnim.new()
			ant.taps = 0
			local endTime = 1500
			
			if (score < 200 )then
				endTime = 1300
			elseif 	(score < 600 )then
				endTime = 1100
			elseif 	(score < 1000 )then
				endTime = 1000
			elseif (score < 1600 )then
				endTime = 850
			elseif (score < 2500 )then
				endTime = 700
			else
				endTime = 650
			end
			ant:setSequence(setSeq)
			ant:play()
			ant.x = math.random(bufferWidth + 200 , display.viewableContentWidth - 200)
			ant.y = 1280
			--ant.rotation = 180
			print(gameOver,ant.sequence)
			group:insert( ant )
			ant:addEventListener("touch",Smash.new)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			if ant.x < display.contentCenterX then
				ant.rotation = ant.rotation + 45
				transition.to( ant, { x = ant.x + 150, y = ant.y - 320, time=endTime,onComplete= function()  

													ant.rotation = ant.rotation - 90
													transition.to( ant, { x = ant.x - 300, y = ant.y - 320, time=endTime,onComplete= function() 
															
															ant.rotation = ant.rotation + 90
															transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=endTime,onComplete= function() 
													
																	ant.rotation = ant.rotation - 90
																	transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=endTime,onComplete= function()
																	
																		SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
																		
																	end})
													
															end })
													
														end})
													
													end})
				else
					ant.rotation = ant.rotation - 45
					transition.to( ant, { x = ant.x - 150, y = ant.y - 320 , time=endTime,onComplete= function()  

													ant.rotation = ant.rotation + 90
													transition.to( ant, { x = ant.x + 300, y = ant.y - 320, time=endTime,onComplete= function() 
															
															ant.rotation = ant.rotation - 90
															transition.to( ant, { x = ant.x - 300, y = ant.y - 320 , time=endTime,onComplete= function() 
													
																	ant.rotation = ant.rotation + 90
																	transition.to( ant, { x = ant.x + 300, y = ant.y - 320 , time=endTime,onComplete= function()
																	
																		SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
																		
																	end})
													
															end })
													
														end})
													
													end})




				end
			
		end


}