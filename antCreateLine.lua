require("spriteAnim")
require("smash")
CreateAntLine = {
		new = function(group,setSeq,posX)
		
			local endTime = 8000
			local toFro
			if (score < 400 )then
				endTime = math.random(6000,7000)
			elseif (score < 900 )then
				endTime = math.random(5000,6000)
			elseif (score < 1500 )then
				endTime = math.random(3500,5100)
			elseif (score < 2000 )then
				endTime = math.random(3000,4200)
			else
				endTime = math.random(2800,3500)
			end	
			
			local ant = SpriteAnim.new()
				ant.taps = 0
				--ant.rotation = 180
				ant:setSequence(setSeq)
				ant:play()
				ant.x =  posX
				group:insert( ant )
				ant:addEventListener("touch",Smash.new)
				ant:addEventListener( "sprite", SpriteAnim.spriteListener )
				
				
				transition.from(ant,{y = 1280,time=endTime, onComplete = function() SpriteAnim.endLife(ant) ; ant:removeSelf(); ant = nil end })
			if(math.random(5) == 2 ) then
				local bee = SpriteAnim.new2()
					--bee.rotation = 180
					bee:setSequence("bee")
					bee:play()
					bee.x =  posX - 100
					group:insert( bee )
					bee:addEventListener("touch",Smash.new)
					bee:addEventListener( "sprite", SpriteAnim.spriteListener )
				toFro = function()
					transition.to(bee,{ x = bee.x + 200,time=1000 , onComplete = function()
											transition.to(bee,{ x = bee.x - 200,time=1000, onComplete = function()
																toFro()
																end})
										end})
				end
				toFro()
				transition.from(bee,{y = 1280,time=endTime, onComplete = function() transition.cancel(bee); bee:removeSelf(); bee = nil end })
			end
			
		end


}