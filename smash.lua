require("spriteAnim")
Smash = {
		new = function(event)
		if(gameOver == false and gamePause == false) then
				local target = event.target
				local getSeq = target.sequence
				function initSmash()
					local smashedAnt = SpriteAnim.new()
					smashedAnt.x = target.x
					smashedAnt.y = target.y
					smashedAnt.rotation = target.rotation
					smashedAnt:setSequence(getSeq .. "Smash")
					if (getSeq=="antBoss") then
						smashedAnt:scale(2,2)
						timer.performWithDelay(50,function()
							CreateAnt.new(group,"ant1",smashedAnt)
						end,math.random(2,5))

					end
					group:insert( smashedAnt )
					transition.to(smashedAnt,{alpha = 0,time=math.random(1500,3500), transition=easing.inQuad, onComplete = function() smashedAnt:removeSelf(); smashedAnt = nil end })
				end
				
				function initSmash2()
					local smashedAnt = SpriteAnim.new2()
					smashedAnt.x = target.x
					smashedAnt.y = target.y
					smashedAnt.rotation = target.rotation
					smashedAnt:setSequence(getSeq .. "Smash")
					group:insert( smashedAnt )
					transition.to(smashedAnt,{alpha = 0,time=math.random(1500,2700), transition=easing.inOutQuad, onComplete = function() smashedAnt:removeSelf(); smashedAnt = nil end })
				end
				function frogSmash()
					local smashedFrog = SpriteAnim.frog()
					smashedFrog.x = target.x
					smashedFrog.y = target.y
					smashedFrog.rotation = target.rotation
					smashedFrog:setSequence(getSeq .. "Smash")
					group:insert( smashedFrog )
					transition.to(smashedFrog,{alpha = 0,time=math.random(1500,2700), transition=easing.inOutQuad, onComplete = function() smashedFrog:removeSelf(); smashedFrog = nil end })
				end
				
				local function initOver()
				
					local temp = function()
						storyboard.gotoScene( "restartView", "fade", 1000 )
					end
					
					local smashedAnt = SpriteAnim.new2()
					smashedAnt:scale(1.5,1.5)
					smashedAnt.x = target.x
					smashedAnt.y = target.y
					smashedAnt.rotation = -180
					smashedAnt:setSequence(getSeq .. "Smash")
					group:insert( smashedAnt )
					transition.to(smashedAnt,{rotation = 0,time=1500, onComplete = function() timer.performWithDelay(1000,temp) end })
				end
				
				if getSeq == "antBoss" then
					target.taps = target.taps + 1
						transition.pause(target)
						transition.to(target,{alpha = 0,time = 40,onComplete = function()
										transition.to(target,{alpha = 1,time = 80,onComplete = 
											function()
												transition.to(target,{alpha = 0,time = 40,onComplete = 
												function()
													transition.to(target,{alpha = 1,time = 100})
													transition.resume(target.transition)
												end})
											end})
									end})
				
					SoundControl.Smash(getSeq)
				elseif getSeq == "bee" then
					SoundControl.Smash(getSeq)
					transition.cancel()
					initOver()
					target:removeSelf()
					target = nil
					gameOver = true
					system.vibrate()
				elseif getSeq == "gainLife" then
					print("gain life")
					transition.cancel(target)
					--timer.cancel(target.tm)
					SoundControl.Smash("lifeGain")
					if numLives < 3 then
						numLives = numLives + 1
						lives[numLives] = display.newImage(group,"images/life.png",display.contentCenterX - 90 + (50 * numLives) , bufferHeight + 65)
					end
					target:removeSelf()
					target = nil
					orbitFlag = false
				elseif getSeq == "frog" then
					frogSmash()
					transition.cancel(target)
                                        timer.cancel(target.timerId)
					target:removeSelf()
					target = nil
				elseif getSeq == "fly" then
					initSmash2()
					transition.cancel(target)
					target:removeSelf()
					target = nil	
				else	
					initSmash()
					transition.cancel(target)
					target:removeSelf()
					target = nil
				end
				
				
				if getSeq == "ant1" then
					score = score + 15
					SoundControl.Smash(getSeq)
					
				elseif getSeq == "ant2" then
					score = score + 20
					SoundControl.Smash(getSeq)
				elseif getSeq == "fly" then
					score = score + 25
					SoundControl.Smash(getSeq)
					
				elseif getSeq == "scorpio" then
					score = score + 30
					SoundControl.Smash(getSeq)
				elseif getSeq == "frog" then
					score = score + 30
					SoundControl.Smash(getSeq)
				elseif getSeq == "antBoss" and 	target.taps == 3 then
					score = score + 50
					SoundControl.Smash(getSeq)
					initSmash()
					transition.cancel(target)
					target:removeSelf()
					target = nil
				
				end
				
				
		end	
	end
	}