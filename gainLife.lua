require("smash")
GainLife = {
	 gain = function(group)
	 
		local power
		local tempTime
		if( score < 1000) then
				tempTime = math.random(7000,9000)
			elseif score < 2000 then
				tempTime = math.random(5500,7500)
			else
				tempTime = math.random(4500,6000)
			end
		power= display.newImage(group,"images/life.png",math.random(300,450) , -300)
		power.sequence = "gainLife"
		power.x = math.random(50,680)
		power:addEventListener("touch",Smash.new) 

		Beat.new(power)
			 transition.to(power,{ y = 1280, time = tempTime, onComplete = function()	Beat.stop(power) ; power:removeSelf(); power = nil	end})
	
		
	 
	 end
}


