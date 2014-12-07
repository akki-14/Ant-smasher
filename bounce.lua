
	Bounce = { new = function(grp)
		local timeDown  = 800
		local yDown 	= display.viewableContentHeight
		local timeUp 	= 200
		
		
		transition.to( grp, { time= timeDown, y= yDown ,transition=easing.inQuad , 
								onComplete= function() 
												local yUp		= grp.y - 150  
												transition.to( grp, { time= timeUp, y= yUp ,transition=easing.OutQuad , 
																	onComplete= function() 
																		transition.to( grp, { time= 220, y= yDown ,transition=easing.OutQuad , 
																				onComplete= function()
																					local yUp		= grp.y - 50
																					transition.to( grp, { time= timeUp - 90, y= yUp ,transition=easing.OutQuad,
																					onComplete= function() 
																						transition.to( grp, { time= 70, y= yDown ,transition=easing.OutQuad ,onComplete = function() 
																							--score.y = display.contentCenterY + 80 ; Beat.new(continue) ;
																							--grp:addEventListener("tap",restart)
																							--shareScore.y = display.contentCenterY + 300;
																							--Bounce.pullUp(grp)
																							return grp
																						end  })
																						
																						end})
																				end})
																	end} ) 
											end } )
		
		
	end
	,
	pullUp = function(grp)
		local timeDown  = 800
		local yDown 	= 0
		local timeUp 	= 200
		
		
		transition.to( grp, { time= timeDown, y= yDown ,transition=easing.inQuad , 
								onComplete= function() 
												local yUp		= grp.y + 150  
												transition.to( grp, { time= timeUp, y= yUp ,transition=easing.OutQuad , 
																	onComplete= function() 
																		transition.to( grp, { time= 220, y= yDown ,transition=easing.OutQuad , 
																				onComplete= function()
																					local yUp		= grp.y + 50
																					transition.to( grp, { time= timeUp - 90, y= yUp ,transition=easing.OutQuad,
																					onComplete= function() 
																						transition.to( grp, { time= 70, y= yDown ,transition=easing.OutQuad ,onComplete = function() 
																							--score.y = display.contentCenterY + 80 ; Beat.new(continue) ;
																							--grp:addEventListener("tap",restart)
																							--shareScore.y = display.contentCenterY + 300;
																						end  })
																						
																						end})
																				end})
																	end} ) 
											end } )
		
		
		
	
	
	end
}