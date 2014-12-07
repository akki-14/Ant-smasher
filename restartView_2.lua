local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true

local getBgIndex
local bg
local playerName
local restart
local home
local insertName
local inputListener
local shareScore
local gameOver
local yourScore


--functions
local postScore


function postScore()	
	ShareApp.score("117188648491159",2,score)
end


function scene:createScene(event)
	print("scene")
	group = self.view
	
	getBgIndex = scoreIce:retrieve("background")
	bg = display.newImage(group,"images/bg_game" .. getBgIndex .. ".jpg",display.contentCenterX,display.contentCenterY)
	restart = display.newImage(group,"images/restart2.png",display.contentCenterX - 120,bufferHeight + 1000)
	home = display.newImage(group,"images/home.png",display.contentCenterX + 120,bufferHeight + 1000)
	restart:scale(0.7,0.7)
	home:scale(0.7,0.7)
	gameOver = display.newText(group,"GAME OVER",display.contentCenterX, bufferHeight + 300,"Base 02",80)
	yourScore = display.newText(group,"Your Score  " .. score,display.contentCenterX, bufferHeight + 450,"Base 02",40)
	
	
	playerName = native.newTextField( display.contentCenterX, display.contentCenterY, 300, 90 )
	playerName:setReturnKey("done")
	playerName.hintText = "Enter Name"
	playerName.size = 30
	playerName.align = "center"
	native.setKeyboardFocus( playerName )
	
	
	--insertName = display.newText(group,"Akhil has scored ",display.contentCenterX, bufferHeight + 600,"Base 02",35)
	
	function restartGame(event)
		storyboard.gotoScene( "game", "fade", 1000 )
		gameOver = false
	end
	function menuReturn(event)
		storyboard.gotoScene( "menu", "fade", 1000 )
		gameOver = false
	end
	
	function inputListener(event)
		local  target = event.target
		
		if(event.phase == "began") then
			if(target.text == target.hintText) then
			target.text = ''
			end
			target:setTextColor( 51,51,51)
		elseif(event.phase == "editing") then
			--insertName.text = event.text
		elseif(event.phase == "ended" or event.phase == "submitted") then
			if(target.text == '') then
			target.text = target.hintText 
			end
			target:setTextColor( 204,204,204)
			native.setKeyboardFocus( nil )
			playerName:removeSelf()
			playerName = nil
			insertName = display.newText(group,target.text .. " has scored " .. score ,display.contentCenterX, bufferHeight + 600,"Base 02",35)
			shareScore = display.newImage(group,"images/share_score.png", display.contentCenterX , bufferHeight + 700 )
			shareScore:addEventListener("tap",postScore)
			
		end
	
	end
	
	
			playerName:removeSelf()
			playerName = nil
			--insertName = display.newText(group,target.text .. " has scored " .. score ,display.contentCenterX, bufferHeight + 600,"Base 02",35)
			shareScore = display.newImage(group,"images/share_score.png", display.contentCenterX , bufferHeight + 700 )
			shareScore:addEventListener("tap",postScore)
	
end

function scene:enterScene(event)
	--playerName:addEventListener( "userInput", inputListener )
	restart:addEventListener("tap",restartGame)
	home:addEventListener("tap",menuReturn)
end


function scene:exitScene(event)
	
	
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene