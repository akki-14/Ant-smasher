require("soundControl")
local scene = storyboard.newScene()
gameNetwork = require "gameNetwork"

-- Init game network to use Google Play game services
gameNetwork.init("google")

leaderboardId = "CgkIo9uxveYPEAIQAQ" -- Your leaderboard id here

storyboard.purgeOnSceneChange = true

local bgImage
local bgTitle
local bgStart
local bgStartBack
local bgOptions
local bgOptionsBack
local bgHelp
local bgHelpBack
local bgExit
local bgExitBack
local leaderBoard
local googleLogin
local googleLoginBack
local googleLeaderBoard
local googleLeaderBoardBack
local bgGroup
local adBalloon
local adDress
local bgLogo
local rateApp
local ad2048
local adNum
local promoBanner
local promoYes
local promoNo
local promoGroup 
local shouldExit = false


	-- Submits the score from the scoreTextField into the leaderboard
	local function submitScoreListener(event)
		local val = tonumber(SaveScore.getMax())
		gameNetwork.request("setHighScore", 
			{
				localPlayerScore = 
				{
					category = leaderboardId, -- Id of the leaderboard to submit the score into
					value = val -- The score to submit
				}
			})
	end



function scene:createScene(event)
	if 	audio.isChannelPlaying( 1 ) == false then
		bgChannel = audio.play( mainMenuBgSound, { channel=1, loops=-1, fadein=3000 } )
	end
	-- Tries to automatically log in the user without displaying the login screen if the user doesn't want to login
	gameNetwork.request("login",
	{
		userInitiated = false
	})

	bgGroup = self.view
	promoGroup = display.newGroup()
	bgImage = display.newImage(bgGroup,"images/bg_image.jpg",display.contentCenterX,display.contentCenterY)
	--bgImage:scale(bufferWidthRatio,bufferHeightRatio)
	bgTitle = display.newImage(bgGroup,"images/title.png",display.contentCenterX, bufferHeight + 230)
	bgLogo = display.newImage(bgGroup,"images/ant_logo.png",display.contentWidth - 110 ,display.contentHeight - 230)
	bgStart = display.newImage(bgGroup,"images/start1.png",display.contentCenterX,display.contentCenterY - 90)
	bgStartBack = display.newImage(bgGroup,"images/start2.png",display.contentCenterX,display.contentCenterY - 90)
	bgStartBack.isVisible = false
	bgHelp = display.newImage(bgGroup,"images/help1.png",display.contentCenterX,display.contentCenterY + 70)
	bgHelpBack = display.newImage(bgGroup,"images/help2.png",display.contentCenterX,display.contentCenterY + 70 )
	bgHelpBack.isVisible = false
	bgOptions = display.newImage(bgGroup,"images/options1.png",display.contentCenterX,display.contentCenterY + 230)
	bgOptionsBack = display.newImage(bgGroup,"images/options2.png",display.contentCenterX,display.contentCenterY + 230)
	bgOptionsBack.isVisible = false
	bgExit = display.newImage(bgGroup,"images/exit1.png",display.contentCenterX,display.contentCenterY + 390)
	bgExitBack = display.newImage(bgGroup,"images/exit2.png",display.contentCenterX,display.contentCenterY + 390)
	bgExitBack.isVisible = false
	
	leaderBoard = display.newImage(bgGroup,"images/leaderboard.png",bufferWidth + 100 , display.viewableContentHeight - 200)
	leaderBoard:scale(0.7,0.7)
	googleLogin = display.newImage(bgGroup,"images/login.png",bufferWidth + 100 , display.viewableContentHeight - 350)
	googleLogin:scale(0.7,0.7)
	googleLoginBack = display.newImage(bgGroup,"images/login_selected.png",bufferWidth + 100 , display.viewableContentHeight - 350)
	googleLoginBack:scale(0.7,0.7)
	googleLoginBack.isVisible = false
	googleLeaderBoard = display.newImage(bgGroup,"images/leaderboard_online.png",bufferWidth + 100 , display.viewableContentHeight - 500)
	googleLeaderBoard:scale(0.7,0.7)
	googleLeaderBoardBack = display.newImage(bgGroup,"images/leaderboard_online_selected.png",bufferWidth + 100 , display.viewableContentHeight - 500)
	googleLeaderBoardBack:scale(0.7,0.7)
	googleLeaderBoardBack.isVisible = false


	promoBanner = display.newImage(promoGroup,"images/promo.jpg",display.contentCenterX, display.contentCenterY - 200 - bufferHeight)
	promoYes = display.newImage(promoGroup,"images/yes.png",display.contentCenterX - promoBanner.contentWidth / 2 , display.contentCenterY - 200  - promoBanner.contentHeight / 2 - bufferHeight)
	promoNo = display.newImage(promoGroup,"images/no.png",display.contentCenterX + promoBanner.contentWidth / 2, display.contentCenterY - 200 - promoBanner.contentHeight / 2 - bufferHeight)
	bgGroup:insert(promoGroup)
	promoGroup.isVisible = false

	adNum = math.random(1,3)
	adBalloon = display.newImage(bgGroup,"images/ad_balloon.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adBalloon.isVisible = true
	adDress = display.newImage(bgGroup,"images/ad_dress.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	adDress.isVisible = false
	ad2048 = display.newImage(bgGroup,"images/ad_2048.png",display.contentCenterX,display.contentHeight - bufferHeight - 50)
	ad2048.isVisible = false
	if adNum == 1 then
		adDress.isVisible = true
		adBalloon.isVisible = false
		ad2048.isVisible = false
	elseif adNum == 2 then 
		adDress.isVisible = false
		adBalloon.isVisible = false
		ad2048.isVisible = true
	end
	
	local function checkLoggedIn( event )
		if gameNetwork.request("isConnected") then
			googleLeaderBoard.isVisible = false
			googleLogin.isVisible = false
			googleLoginBack.isVisible = true
		else
			googleLogin.isVisible = true
			googleLoginBack.isVisible = false
			googleLeaderBoardBack.isVisible = false
		end
	end

	timer.performWithDelay( 2000, checkLoggedIn )
	
	
	
end




function scene:enterScene(event)
	--sort the scores
	SaveScore.scoreSort()

	local function goStart(event)
		local target = event.target
		local bounds = target.contentBounds
		
		 if event.phase == "began" then
			
			bgStartBack.isVisible = true
			bgStart.isVisible = false
	        display.getCurrentStage():setFocus( target )
	        self.isFocus = true
	    elseif self.isFocus then
	        if event.phase == "moved" then
	        elseif event.phase == "ended" or event.phase == "cancelled" then
				print(event.x,event.y)
				if(event.x > bounds.xMin  and event.x < bounds.xMax) then
					if  (event.y > bounds.yMin  and event.y < bounds.yMax) then
						audio.stop( bgChannel )
						SoundControl.Menu()
						storyboard.gotoScene( "game", "fade", 400 )
					end
				end
				bgStartBack.isVisible = false
				bgStart.isVisible = true
	            display.getCurrentStage():setFocus( nil )
	            target.isFocus = false
	        end
	    end

    return true
	end
	
	
	
	local function goHelp(event)
		local target = event.target
		local bounds = target.contentBounds
		
	 if event.phase == "began" then
		
		bgHelpBack.isVisible = true
		bgHelp.isVisible = false
        display.getCurrentStage():setFocus( target )
        self.isFocus = true
    elseif self.isFocus then
        if event.phase == "moved" then
        elseif event.phase == "ended" or event.phase == "cancelled" then
			print(event.x,event.y)
			if(event.x > bounds.xMin  and event.x < bounds.xMax) then
				if  (event.y > bounds.yMin  and event.y < bounds.yMax) then
					SoundControl.Menu()
					storyboard.gotoScene( "help", "fade", 400 )
				end
			end
			bgHelpBack.isVisible = false
			bgHelp.isVisible = true
            display.getCurrentStage():setFocus( nil )
            target.isFocus = false
        end
    end

    return true
	end
	
	
	local function goOptions(event)
		local target = event.target
		local bounds = target.contentBounds
		
	 if event.phase == "began" then
		
		bgOptionsBack.isVisible = true
		bgOptions.isVisible = false
        display.getCurrentStage():setFocus( target )
        self.isFocus = true
    elseif self.isFocus then
        if event.phase == "moved" then
        elseif event.phase == "ended" or event.phase == "cancelled" then
			print(event.x,event.y)
			if(event.x > bounds.xMin  and event.x < bounds.xMax) then
				if  (event.y > bounds.yMin  and event.y < bounds.yMax) then
					SoundControl.Menu()
					storyboard.gotoScene( "options", "fade", 400 )
				end
			end
			bgOptionsBack.isVisible = false
			bgOptions.isVisible = true
            display.getCurrentStage():setFocus( nil )
            target.isFocus = false
        end
    end

    return true
	end
	
	
	local function goExit(event)
		local target = event.target
		local bounds = target.contentBounds
		
		 if event.phase == "began" then
			
			bgExitBack.isVisible = true
			bgExit.isVisible = false
			display.getCurrentStage():setFocus( target )
			self.isFocus = true
		elseif self.isFocus then
			if event.phase == "moved" then
			elseif event.phase == "ended" or event.phase == "cancelled" then
				print(event.x,event.y)
				if(event.x > bounds.xMin  and event.x < bounds.xMax) then
					if  (event.y > bounds.yMin  and event.y < bounds.yMax) then
						SoundControl.Menu()
						--storyboard.gotoScene( "restartView", "fade", 1000 )

						promoGroup.isVisible = true

						
					end
				end
				bgExitBack.isVisible = false
				bgExit.isVisible = true
				display.getCurrentStage():setFocus( nil )
				target.isFocus = false
			end
		end

		return true
	end
	
	local function goBalloon(event)
		if event.phase == "began" then
			system.openURL("market://details?id=com.gaakapps.balloonburst" )
		end
	end
	local function goDress(event)
		if event.phase == "began" then
			system.openURL("market://details?id=com.gaakapps.dressup" )
		end	
	end
	local function go2048(event)
		if event.phase == "began" then
			system.openURL("market://details?id=com.gaakapps.pro2048" )
		end	
	end
	
	local function highScore(event)
		

		local target = event.target
		local bounds = target.contentBounds
		
		 if event.phase == "began" then
			
			target:scale(0.8,0.8)
	        display.getCurrentStage():setFocus( target )
	        self.isFocus = true
		elseif self.isFocus then
		        if event.phase == "moved" then
		        elseif event.phase == "ended" or event.phase == "cancelled" then
					
					local function onKeyEvent(event)
	
						local phase = event.phase
							
						if event.phase=="up" and event.keyName=="back" then 
								Bounce.pullUp(bgGroup)
								Runtime:removeEventListener( "key", onKeyEvent )
								return true
						end
						return false
					end
				
					local function pullUp(event)
						Bounce.pullUp(bgGroup)
						Runtime:removeEventListener( "key", onKeyEvent )
					end
				
					--local gp = display.newGroup()
					local gp = self.view
					local container = display.newImage(gp,"images/bg_image.jpg",display.contentCenterX, -display.contentCenterY)
					local bgTitle = display.newText(gp,"Local Scores",display.contentCenterX ,- display.viewableContentHeight +  bufferHeight + 120, "Easter Sunrise",70)
					local bgBack = display.newText(gp,"BACK",display.contentCenterX , -bufferHeight-150, "Easter Sunrise",80)
					local tempName,tempScores = SaveScore.scoreSort()
					SaveScore.print(tempName,tempScores,gp)
					Bounce.new(gp)
					
					Runtime:addEventListener( "key", onKeyEvent )
					bgBack:addEventListener("tap",pullUp)	
		            display.getCurrentStage():setFocus( nil )
		            target.isFocus = false
		            target:scale(1.25,1.25)
		        end
		    end
		return true
	end
	


	local function googleServiceLogin(event)
		

		local target = event.target
		local bounds = target.contentBounds
		
		 if event.phase == "began" then
			
			target:scale(0.8,0.8)
	        display.getCurrentStage():setFocus( target )
	        self.isFocus = true
		elseif self.isFocus then
		        if event.phase == "moved" then
		        elseif event.phase == "ended" or event.phase == "cancelled" then
					
					local function loginListener(event1)
						-- Checks to see if there was an error with the login.
						if event1.isError then
						else
							googleLeaderBoard.isVisible = false
							googleLeaderBoardBack.isVisible = true
							googleLogin.isVisible = false
							googleLoginBack.isVisible = true
							submitScoreListener()
						end
					end

					if gameNetwork.request("isConnected") then
						gameNetwork.request("logout")
						googleLeaderBoard.isVisible = true
						googleLeaderBoardBack.isVisible = false
						googleLogin.isVisible = true
						googleLoginBack.isVisible = false

					else
						-- Tries to login the user, if there is a problem then it will try to resolve it. eg. Show the log in screen.
						gameNetwork.request("login",
							{
								listener = loginListener,
								userInitiated = true
							})
					end
					
		            display.getCurrentStage():setFocus( nil )
		            target.isFocus = false
		            target:scale(1.25,1.25)
		        end
		    end
		return true
	end


	local function showLeaderboardListener(event)

		local target = event.target
		local bounds = target.contentBounds
		
		 if event.phase == "began" then
			
			target:scale(0.8,0.8)
	        display.getCurrentStage():setFocus( target )
	        self.isFocus = true
		elseif self.isFocus then
		        if event.phase == "moved" then
		        elseif event.phase == "ended" or event.phase == "cancelled" then
			
					gameNetwork.show("leaderboards") -- Shows all the leaderboards.
					
		            display.getCurrentStage():setFocus( nil )
		            target.isFocus = false
		            target:scale(1.25,1.25)
		        end
		    end
		return true
	end

	function rateApp(event)
		system.openURL("market://details?id=com.gaakapps.antsmasher" )
	end
	local function yes( event )
			native.requestExit()
						
	end

		local function no( event )
			promoGroup.isVisible = false
								
		end

		local function openApp( event)
				promoGroup.isVisible = false
				system.openURL("market://details?id=com.gaakapps.fruitshoot" )
		end 
	local function onKeyEvent(event)
	
		local phase = event.phase
			
		if event.phase=="up" and event.keyName=="back" then
				promoGroup.isVisible = true
				if shouldExit then
					native.requestExit()
				end
				shouldExit = true
			return true
		end
		return false
	end

	promoBanner:addEventListener("tap",openApp)
	promoYes:addEventListener("tap",yes)
	promoNo:addEventListener("tap",no)
	bgStart:addEventListener("touch",goStart)
	bgStartBack:addEventListener("touch",goStart)
	
	bgHelp:addEventListener("touch",goHelp)
	bgHelpBack:addEventListener("touch",goHelp)
	
	bgOptions:addEventListener("touch",goOptions)
	bgOptionsBack:addEventListener("touch",goOptions)
	
	bgExit:addEventListener("touch",goExit)
	bgExitBack:addEventListener("touch",goExit)
	
	adDress:addEventListener("touch", goDress)
	adBalloon:addEventListener("touch", goBalloon)
	ad2048:addEventListener("touch", go2048)
	
	bgLogo:addEventListener("tap", rateApp)
	leaderBoard:addEventListener("touch", highScore)
	googleLogin:addEventListener("touch", googleServiceLogin)
	googleLoginBack:addEventListener("touch", googleServiceLogin)
	googleLeaderBoard:addEventListener("touch", showLeaderboardListener)
	googleLeaderBoardBack:addEventListener("touch", showLeaderboardListener)
	Runtime:addEventListener( "key", onKeyEvent )

end


function scene:exitScene(event)
	
	
	bgLogo:removeEventListener("tap", rateApp)
	Runtime:removeEventListener( "key", onKeyEvent )
	
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene