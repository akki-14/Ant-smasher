
	Beat = { new = function(grp)
	
		--grp.x = display.contentCenterX
		--grp.y = display.contentCenterY + 180
	
	beatContract = function()
		
		
		 transition.to( grp, {time = 700, xScale = 1 , yScale= 1,transition=easing.inOutQuad, tag="stop", onComplete = beatExpand })
		
	end 
	beatExpand = function()
		
		print("1" , grp)
		transition.to( grp, {time = 900, xScale = 1.3 , yScale= 1.3 ,transition=easing.inOutQuad,tag="stop" , onComplete = beatContract})
		
	end 
	transition.cancel("stop")
	beatContract()
end,
	stop = function()
		transition.cancel("stop")
		
	end

}