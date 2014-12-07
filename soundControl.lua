
SoundControl = {
  Smash = function(getSeq)
		local gameSound = optionIce:retrieve("gameSound")
		if gameSound == 1 then
			if getSeq == "ant1" then
				smashChannel = audio.play( antSound[math.random(3)])
			elseif getSeq == "ant2" then
				smashChannel = audio.play( antSound[math.random(2,5)] )
			elseif getSeq == "bee" then
				smashChannel = audio.play( beeSmashSound )
			elseif getSeq == "lifeLost" then
				smashChannel = audio.play( lifeLost )
			elseif getSeq == "lifeGain" then
				smashChannel = audio.play( lifeGain )
			else
				smashChannel = audio.play( antSound[math.random(6,8)] )
			end
		end
	
	 end,
	 
	Menu =  function()
	 
		menuChannel = audio.play( optionSound, { channel = 2 } )
			
	end
	,
	Tick = function()
		tickSoundChannel = audio.play( tickSound, { channel = 2 } )
	
	end
}