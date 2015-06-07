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
local gameOverText
local yourScore
local enter_name = ""
local min_high_score
local shareScore
local insertName
local tempFlag = true
--local resetGroup

--functions
local inputListener
local enter_high_score
local store_score
local ok_save
local postScore
local min_score
local onKeyEvent


function scene:createScene(event)
	resetGroup = self.view
	tempFlag = true
	getBgIndex = optionIce:retrieve("background")
	bg = display.newImage(resetGroup,"images/bg_game" .. getBgIndex .. ".jpg",display.contentCenterX,display.contentCenterY)
	restart = display.newImage(resetGroup,"images/restart2.png",display.contentCenterX - 120,bufferHeight + 1050)
	home = display.newImage(resetGroup,"images/home.png",display.contentCenterX + 120,bufferHeight + 1050)
	restart:scale(0.7,0.7)
	home:scale(0.7,0.7)
	gameOverText = display.newText(resetGroup,"GAME OVER",display.contentCenterX, bufferHeight + 300,"Base 02",80)
	yourScore = display.newText(resetGroup,"Your Score  " .. score,display.contentCenterX, bufferHeight + 450,"Base 02",40)
	
	local function submitScoreListener(val)
		print(leaderboard,gameNetwork)
		gameNetwork.request("setHighScore", 
			{
				localPlayerScore = 
				{
					category = leaderboardId, -- Id of the leaderboard to submit the score into
					value = val -- The score to submit
				}
			})
	end
	
	
	 function enter_high_score(score)
			function store_score(name,score)
				if( name == "" ) then
					name = "No-Name"
				end
					scoreIce:storeIfHigher( name, score )
					scoreIce:save()
					submitScoreListener(score)
			end



			 function ok_save(name)
				
				--insertName = display.newText(grp,name .. " has scored " .. score ,display.contentCenterX, bufferHeight + 600,"Base 02",35)
				store_score(name,score)
				--grp:removeSelf()
			end
		
		
		
			function inputListener(event)
				local  target = event.target
				
				function postScore(event)	
					ShareApp.score("117188648491159",2,score)
				end
				
				if(event.phase == "began") then
					if(target.text == target.placeholder) then
					target.text = ''
					end
				elseif(event.phase == "editing") then
					--insertName.text = event.text
				elseif(event.phase == "ended" or event.phase == "submitted") then
					if(target.text == '') then
					target.text = target.placeholder 
					end
					native.setKeyboardFocus( nil )
					shareScore = display.newImage(resetGroup,"images/share_score.png", display.contentCenterX , bufferHeight + 750 )
					shareScore:addEventListener("tap",postScore)
					ok_save(target.text)
					target:removeSelf()
					target = nil
					tempFlag = false
				end
			
			end
		
		
		
		playerName = native.newTextField(display.contentCenterX, display.contentCenterY, 450, 100 )
		playerName:setReturnKey("done")
		playerName.placeholder = "Enter Name"
		playerName.size = 28
		playerName:setTextColor(0,0,0)
		playerName.align = "center"
		native.setKeyboardFocus( playerName )
		
		playerName:addEventListener( "userInput", inputListener )
		
	end	
		
		 function min_score()
			min_high_score = minScore:retrieve("min")
			print(min_high_score,score)
			if(score > min_high_score) then
				enter_high_score(score)
			else
				tempFlag = false
			end
			
		end
	
	
	function restartGame(event)
		gameOver = false
		storyboard.gotoScene( "game", "fade", 600 )
                Analytics.logEvent("restart_game")
	end
	function menuReturn(event)
		gameOver = false
		storyboard.gotoScene( "menu", "fade", 600 )
                Analytics.logEvent("return_main_menu")
	end
	
	function onKeyEvent(event)
	
		local phase = event.phase
			
		if event.phase=="down" and event.keyName=="back" then 
				storyboard.gotoScene("menu", "fade", 600 )
				return true
		end
		return false
	end
	
	--SaveScore.new(900,resetGroup,playerName)
	min_score()
end

function scene:enterScene(event)
	-- if math.random(3) == 2 then
	-- 	ads.show( "banner", { x=0, y=1125,interval=40,appId="ca-app-pub-2883837174861368/5479620739"} )
	-- else
	-- 	ads.show( "interstitial", { x=0, y=1050,appId="ca-app-pub-2883837174861368/9196308735"} )
	-- end	
	myAds.show()
	restart:addEventListener("tap",restartGame)
	home:addEventListener("tap",menuReturn)
	Runtime:addEventListener( "key", onKeyEvent )
end


function scene:exitScene(event)
	myAds.hide()
	Runtime:removeEventListener( "key", onKeyEvent )
	if tempFlag then
		scoreIce:storeIfHigher( "No-Name", score )
		scoreIce:save()
		playerName:removeSelf()
		playerName = nil
	end
	
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene