require("antCreate")
require("antCreateTwin")
require("antCreateLine")
require("antCreateRoam")
require("antCreateZigZag")
require("antCreateCross")
require("antCreateOrbit")
require("antCreateFast")
require("flyCreate")
require("gainLife")
require("SpriteAnim")

local gameEngineTimer = nil
local tempGroup
GameEngine = {
		new = function(group)
		tempGroup = group
		local calculate
		local seq = {"ant1","ant2","scorpio"}
		local type1
		local type2
		local type3
		
		
		function calculate(points,totalKilled)
			
			
				local numOfAnts = math.random(5,8)
				
				if score  < 600 then
					local antPattern = math.random(5)
					local antType = math.random(3)
					local delayTime = math.random(1300,1600)
					local posX = 0
					if(antPattern == 1 ) then
						if score < 300 then
							delayTime = math.random(800,1000)
						else
							delayTime = math.random(650,900)
						end
					elseif(antPattern == 2) then
						posX = math.random(700)
						numOfAnts = math.random(7,10)
						delayTime = 90
					elseif(antPattern == 4) then
						posX = math.random(bufferWidth + 50,670 - bufferWidth)
						if score < 300 then
							delayTime = math.random(1100,1400)
						else
							delayTime = math.random(1000,1200)
						end
					elseif(antPattern == 5 ) then
						if score < 300 then
							delayTime = math.random(1100,1400)
						else
							delayTime = math.random(900,1200)
						end
					else
						if score < 300 then
							delayTime = math.random(1100,1400)
						else
							delayTime = math.random(1000,1200)
						end
					end
					
					local gameEngineTimer = timer.performWithDelay(delayTime,type1,numOfAnts)
					gameEngineTimer.params = {param1 = numOfAnts,param2 = antPattern,param3 = posX, param4 = antType}
				elseif score  < 1800 then
					
					local antPattern = math.random(6)
					local antType = math.random(3)
					local delayTime = math.random(1200,1400)
					local posX = 0
					if(antPattern == 5) then
						posX = math.random(bufferWidth + 30,680 - bufferWidth)
						delayTime = math.random(950,1400)
					elseif(antPattern == 1 ) then
						if score < 1100 then
							delayTime = math.random(650,800)
						else
							delayTime = math.random(400,700)
						end
					
					elseif(antPattern == 4 ) then
						if score < 1100 then
							delayTime = math.random(1050,1250)
						else
							delayTime = math.random(900,1000)
						end
					
					elseif(antPattern == 6 ) then
						if score < 1200 then
							delayTime = math.random(700,1000)
						else
							delayTime = math.random(600,900)
						end
					else
						if score < 1300 then
							delayTime = math.random(900,1100)
						else
							delayTime = math.random(800,950)
						end
					end
					
					gameEngineTimer = timer.performWithDelay(delayTime,type2,numOfAnts)
					gameEngineTimer.params = {param1 = numOfAnts,param2 = antPattern,param3 = posX,param4 = antType}
				else
					
					local antPattern = math.random(7)
					local antType = math.random(3)
					local delayTime = math.random(900,1100)
					local posX = 0
					if(antPattern == 2) then
						posX = math.random(bufferWidth + 50,660 - bufferWidth)
						delayTime = 90
					elseif(antPattern == 5) then
						posX = math.random(bufferWidth + 50,680 - bufferWidth)
						
						if score < 2300 then
							delayTime = math.random(700,1100)
						else
							delayTime = math.random(500,800)
						end
					elseif(antPattern == 7 ) then
						if score < 2300 then
							delayTime = math.random(700,850)
						else
							delayTime = math.random(550,800)
						end
					elseif(antPattern == 1  or antPattern == 4) then
						if score < 2300 then
							delayTime = math.random(700,900)
						else
							delayTime = math.random(600,800)
						end
					end
					
					gameEngineTimer = timer.performWithDelay(delayTime,type3,numOfAnts)
					gameEngineTimer.params = {param1 = numOfAnts,param2 = antPattern,param3 = posX, param4 = antType}
				end
				
				
				
				
				
		end
		
		function type1(event)
			if gameOver == false then	
				local params = event.source.params
				local num = params.param2
				local posX = params.param3
				local antType = params.param4
				
				if num == 1 then
					CreateAnt.new(group,seq[math.random(2)])
				elseif num == 2  then
					CreateAntRoam.new(group,seq[1],posX)
				elseif num == 3 then
					CreateAntTwin.new(group,seq[math.random(2)])
				elseif num == 4 then
					CreateAntLine.new(group,seq[1],posX)
				else
					CreateAntZigZag.new(group,seq[math.random(2)])
				end
					
				if(event.count == params.param1) then
					
				
					local temp = function(event)
						calculate(score,10)
					end
						if(num ~= 2) then
							gameEngineTimer = timer.performWithDelay(math.random(2000,2400),temp)
						else
							gameEngineTimer = timer.performWithDelay(math.random(2000,2500),temp)
						end
				
				end
			else
				timer.cancel(event.source)
			end	
		end
		
		
		
		function type2(event)
		
			
			if gameOver == false then	
				local params = event.source.params
				local num = params.param2
				local posX = params.param3
				local antType = params.param4
				
				if num == 1 then
					CreateAnt.new(group,seq[math.random(3)])
					if math.random(4) == 2 then
						FlyCreate.new(group,"fly")
					end
				elseif num == 2 then
					CreateAntFast.new(group,seq[math.random(3)])
				elseif num == 3 then
					CreateAntCross.new(group,seq[math.random(3)])
				elseif num == 4 then
					CreateAntTwin.new(group,seq[math.random(3)])
				elseif num == 5 then
					CreateAntLine.new(group,seq[math.random(2)],posX)
				else
					CreateAntZigZag.new(group,seq[math.random(2)])
				end
					
				if(event.count == params.param1) then
					
				
					local temp = function(event)
						calculate(score,10)
					end
						
					gameEngineTimer = timer.performWithDelay(math.random(1800,2500),temp)
						
				
				end
			else
				timer.cancel(event.source)
			end			
		end
		
		
		
		function type3(event)
		
			if gameOver == false then
					local params = event.source.params
					local num = params.param2
					local posX = params.param3
					local antType = params.param4
					
					if num == 1 then
						CreateAntCross.new(group,seq[math.random(2)])
					elseif num == 2 then
						CreateAntRoam.new(group,seq[1],posX)
					elseif num == 3 then
						CreateAntTwin.new(group,seq[math.random(2)])
					elseif num == 4 then
						CreateAntFast.new(group,seq[math.random(3)])
					elseif num == 5 then
						CreateAntLine.new(group,seq[math.random(2)],posX)
					elseif num == 6 then
						FlyCreate.new(group,"fly")
					else
						CreateAntZigZag.new(group,seq[math.random(2)])
					end
						
					if(event.count == params.param1) then
						
					
						local temp = function(event)
							calculate(score,10)
						end
							if(num ~= 2) then
								gameEngineTimer = timer.performWithDelay(math.random(1400,2000),temp)
							else
								gameEngineTimer = timer.performWithDelay(math.random(1300,1700),temp)
							end
					
					end
			else
				timer.cancel(event.source)
			end
		end
		
		function aaa(event)
			CreateAnt.new(group,seq[1])
			--CreateAntOrbit.new(group,"bee")
			--FlyCreate.new(group,seq[1])
			if(event.count == 2) then
				local temp = function(event)
					calculate(score,10)
				end
					
				gameEngineTimer = timer.performWithDelay(math.random(2000,3200),temp)
					
			end
		end
		
		gameEngineTimer = timer.performWithDelay(math.random(1500,2500),aaa,2)
		
		
		
	end,
	pause = function (view)
		timer.pause( gameEngineTimer )
		transition.pause()
		gamePause = true
		transition.to( view, { time=100, x=display.contentCenterX})
		--SpriteAnim.pause()
	end,
	resume = function (view)
		timer.resume( gameEngineTimer )
		transition.resume()
		gamePause = false
		transition.to( view, { time=100, x=-display.contentCenterX})
		--SpriteAnim.resume()

	end
}	