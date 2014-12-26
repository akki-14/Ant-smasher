require("gameEngine")
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true

group = nil

local menu
local bg
local getBgIndex
local scoreBar
local scoreText
local maxScoreText
local getMaxScore
local pauseButton
local pauseBar
--global
lives = {}
numLives = 3
score = 0
gameOver = false

local onKeyEvent
local scoreFront


local function pauseGame( event )
	local target = event.target
	if target.pauseState == true then
		GameEngine.pause(pauseBar)
		target.pauseState = false
	else
		GameEngine.resume(pauseBar)
		target.pauseState = true
	end
end

function scene:createScene(event)
	group = self.view
	
	numLives = 3
	score = 0
	gameOver = false
	getBgIndex = optionIce:retrieve("background")
	getMaxScore = maxScore:retrieve("max")
	bg = display.newImage(group,"images/bg_game" .. getBgIndex .. ".jpg",display.contentCenterX,display.contentCenterY)
	scoreBar = display.newImage(group,"images/score-bar.png",display.contentCenterX, bufferHeight + 140)
	scoreText = display.newText(group,score , 140 , bufferHeight + 65 ,"Base 02",30)
	for i=1,numLives do 
		lives[i] = display.newImage(group,"images/life.png",display.contentCenterX - 90 + (50 * i) , bufferHeight + 65)
	end
	maxScoreText = display.newText(group,getMaxScore , display.viewableContentWidth - 135 , bufferHeight + 65 ,"Base 02",30)
	pauseButton = display.newImage(group,"images/pause.png",display.contentCenterX, bufferHeight + 140)
	pauseButton.pauseState = true
	pauseBar = display.newImage(group,"images/pause_bar.png",-display.contentCenterX, display.contentCenterY)

	--CreateAnt.new(group)
	--timer.performWithDelay(2500,aaa,10)
	--CreateAntOrbit.new(group)
	GameEngine.new(group)
	
		print("game mmm",gameOver)
	
	function scoreFront(event)
		scoreText.text = score
		if(score > getMaxScore ) then
			maxScoreText.text = score
		end
		scoreBar:toFront()
		scoreText:toFront()
		maxScoreText:toFront()
			if numLives > 0 then
				for i=1,numLives do 
				lives[i]:toFront()
				end
		else
			transition.cancel()
			gameOver = true
			storyboard.gotoScene( "restartView", "fade", 600 )
		end	

				if score % 50 == 40 then
				end
			if score % 300 == 250  then
				if isPower then
					if math.random(2) == 1 then
						GainLife.gain(group)
					else	
						orbitFlag = true
						CreateAntOrbit.new(group,"bee")
					end	
					isPower = false
				end	
			else
				isPower = true
			end
	
	end
	
	function onKeyEvent(event)
	
		local phase = event.phase
			
		if event.phase=="down" and event.keyName=="back" then
				
			transition.cancel()
			gameOver = true
			storyboard.gotoScene( "menu", "fade", 600 )
			return true
		end
		return false
	end
	
end


function scene:enterScene(event)
	ads.show( "banner", { x=0, y=1160,interval=50,appId="ca-app-pub-2883837174861368/5479620739"} )
	Runtime:addEventListener( "enterFrame", scoreFront)
	Runtime:addEventListener( "key", onKeyEvent )
	pauseButton:addEventListener("tap",pauseGame)
	print("enter")
end


function scene:exitScene(event)
	ads.hide()
	Runtime:removeEventListener( "enterFrame", scoreFront)
	Runtime:removeEventListener( "key", onKeyEvent )
	transition.cancel()
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene