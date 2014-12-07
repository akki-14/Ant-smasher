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
			else
				endTime = 700
			end
			ant:setSequence(setSeq)
			ant:play()
			ant.x = 300
			ant.rotation = 180
			print(gameOver,ant.sequence)
			group:insert( ant )
			ant:addEventListener("touch",Smash.new)
			ant:addEventListener( "sprite", SpriteAnim.spriteListener )
			transition.to( ant, { x = ant.x + 125, y = ant.y + 300, rotation = ant.rotation - 45 , time=endTime,onComplete= function()  

												ant.rotation = ant.rotation + 90
												transition.to( ant, { x = ant.x - 250, y = ant.y + 300, time=endTime,onComplete= function() 
														
														ant.rotation = ant.rotation - 90
														transition.to( ant, { x = ant.x + 250, y = ant.y + 300 , time=endTime,onComplete= function() 
												
																ant.rotation = ant.rotation + 90
																transition.to( ant, { x = ant.x - 250, y = ant.y + 300 , time=endTime,onComplete= function()
																
																	SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil
																	
																end})
												
														end })
												
													end})
												
												end})
			
		end


}