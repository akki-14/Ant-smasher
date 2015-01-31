storyboard = require "storyboard"
require("antCreate")
require("antCreateZigZag")
require("antCreateCross")
require("antCreateOrbit")
require("ice")
require("saveScore")
require("shareApp")
require("bounce")
require("beat")
require("rateThisApp").rateThis("market://details?id=com.gaakapps.antsmasher")
settings = require("gameSettings")
local loadsave = require("loadsave")
local json = require("json")
myAds = require("myAds")

local musicSound
local gameSound

score = 0
orbitFlag = true
timerId = nil
gamePause = false

serverSettings = loadsave.loadTable("settings.json")
if serverSettings ~=nil then
	print("ffffffff",serverSettings.game_speed )
	if serverSettings.ad_type == "vungle" then
		myAds.initVungle()
	-- elseif serverSettings.adtype == "chartboost" then
	-- 	myAds.initChartboost()
	elseif serverSettings.ad_type == "inneractive" then
		myAds.initInneractive()
	else	
		myAds.initAdmob()
	end
else
	myAds.initVungle()
end

TOTAL_WIDTH = display.viewableContentWidth
TOTAL_HEIGHT = display.viewableContentHeight
bufferWidth = (display.contentWidth - display.viewableContentWidth ) / 2
bufferWidthRatio = display.viewableContentWidth / display.contentWidth 
bufferHeight = (display.contentHeight - display.viewableContentHeight ) / 2
bufferHeightRatio = display.viewableContentHeight / display.contentHeight


audio.reserveChannels(2)
mainMenuBgSound = audio.loadSound( "sounds/menu_bg.ogg" )
antSound = {}
for i = 1,8 do
	antSound[i] = audio.loadSound( "sounds/ant" .. i .. ".ogg" )
end
optionSound = audio.loadSound( "sounds/option.ogg" )
tickSound = audio.loadSound( "sounds/tick.mp3" )  -- change sound  in option menu
beeSmashSound = audio.loadSound( "sounds/ouch.ogg" ) 
beeSound = audio.loadSound( "sounds/bee.ogg" ) 
lifeLost = audio.loadSound( "sounds/life_lost.wav" ) 
lifeGain = audio.loadSound( "sounds/life_gain.ogg" )

--audio.setVolume( 0.15, { channel=2 } )

	
		optionIce = ice:loadBox( "values" )
		optionIce:storeIfNew( "background", 1 )
		optionIce:storeIfNew( "musicSound", 1 )
		optionIce:storeIfNew( "gameSound", 1 )
		
		
		-- default scores
			scoreIce = ice:loadBox( "scores" )
			scoreIce:storeIfNew( "Player 1", 50 )
			scoreIce:storeIfNew( "Player 2", 100 )
			scoreIce:storeIfNew( "Player 3", 150 )
			scoreIce:storeIfNew( "Player 4", 200 )
			scoreIce:storeIfNew( "Player 5", 300 )
			scoreIce:storeIfNew( "Player 6", 400 )
			scoreIce:storeIfNew( "Player 7", 500 )
			scoreIce:storeIfNew( "Player 8", 600 )
			scoreIce:storeIfNew( "Player 9", 700 )
			scoreIce:storeIfNew( "Player 10", 800 )
			
			minScore = ice:loadBox( "minScore" )
			maxScore = ice:loadBox( "maxScore" )
			scoreIce:save()
			optionIce:save()
		

	musicSound = optionIce:retrieve("musicSound")
	gameSound = optionIce:retrieve("gameSound")
	if musicSound == 1 then 
		audio.setVolume(1,{channel = 1})
	else
		audio.setVolume(0,{channel = 1})	
	end
	if gameSound == 1 then
		audio.setVolume(1,{channel = 2})	
	else
		audio.setVolume(0,{channel = 2})	
	end		

bgChannel = audio.play( mainMenuBgSound, { channel=1, loops=-1, fadein=3000 } )
storyboard.gotoScene( "menu", "fade", 1000 )

local function networkListener( event )
	if ( event.isError ) then
		print( "Network error!")
	else
		print ( "RESPONSE: " .. event.response )
		local t = json.decode( event.response )

		-- Go through the array in a loop
		if t.save_settings == true then
			print("settings saved")
			loadsave.saveTable( t, "settings.json" )
		end

	end
end



network.request( "http://gaak.atwebpages.com/antsmasher.php", "GET", networkListener )


print("buffer width",bufferWidth,bufferWidthRatio)
print("buffer height",bufferHeight,bufferHeightRatio)
print(display.viewableContentHeight,display.viewableContentWidth)
print(display.contentHeight,display.contentWidth)
print(display.actualContentHeight,display.actualContentWidth)