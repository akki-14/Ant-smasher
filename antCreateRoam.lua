require("spriteAnim")
require("smash")
CreateAntRoam = {
		new = function(group,setSeq,posX)
		
			local endTime = 1400
			if (score < 300 )then
				endTime = 1400
			elseif 	(score < 1300 )then
				endTime = 1150
			elseif 	(score < 2000 )then
				endTime = 950
			else
				endTime = 800
			end
			local ant = SpriteAnim.new()
			ant.taps = 0
			ant:setSequence(setSeq)
			ant:play()
			ant.x = posX
			ant.y = 1280
			--ant.rotation = 180
			group:insert( ant )
			ant:addEventListener("touch",Smash.new)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			
			if (ant.x < display.contentCenterX) then
			
				ant.rotation = ant.rotation + 55
				transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300, time=endTime,onComplete= function()  

												ant.rotation = ant.rotation - 110
												transition.to( ant, { x = bufferWidth, y = ant.y - 300, time=endTime,onComplete= function() 
														
														ant.rotation = ant.rotation + 110
														transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300 , time=endTime,onComplete= function() 
												
																ant.rotation = ant.rotation - 110
																transition.to( ant, { x = bufferWidth, y = ant.y - 300 , time=endTime,onComplete= function()
																
																	SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
																	
																end})
												
														end })
												
													end})
												
												end})
			
			else			
				ant.rotation = ant.rotation - 55
				transition.to( ant, { x = bufferWidth, y = ant.y - 300, time=endTime,onComplete= function()  

												ant.rotation = ant.rotation + 110
												transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300, time=endTime,onComplete= function() 
														
														ant.rotation = ant.rotation - 110
														transition.to( ant, { x = bufferWidth , y = ant.y - 300 , time=endTime,onComplete= function() 
												
																ant.rotation = ant.rotation + 110
																transition.to( ant, { x = display.viewableContentWidth, y = ant.y - 300 , time=endTime,onComplete= function()
																
																	SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
																	
																end})
												
														end })
												
													end})
												
												end})
			end
			
			
		end


}