storyboard = require "storyboard"
require("antCreate")
require("antCreateZigZag")
require("antCreateCross")
require("antCreateOrbit")
require("ice")
require("saveScore")
-- require("shareApp")
require("bounce")
require("beat")
require("rateThisApp").rateThis("market://details?id=com.gaakapps.antsmasher")
settings = require("gameSettings")
local loadsave = require("loadsave")
local json = require("json")
local promotionView = require("libs.promotionView")
myAds = require("myAds")
Analytics = require("analytics")

local musicSound
local gameSound
local promotionVersion
local promotionLastRefreshTime
local promotionRefreshInterval




score = 0
orbitFlag = true
timerId = nil
gamePause = false

serverSettings = loadsave.loadTable("settings.json")

if serverSettings ~=nil then
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
    myAds.initAdmob()
end




TOTAL_WIDTH = display.viewableContentWidth
TOTAL_HEIGHT = display.viewableContentHeight
CENTER_X = display.contentCenterX
CENTER_Y = display.contentCenterY
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
explosionSound = audio.loadSound( "sounds/bomb_explosion.mp3" )

--audio.setVolume( 0.15, { channel=2 } )


optionIce = ice:loadBox( "values" )
optionIce:storeIfNew( "background", 1 )
optionIce:storeIfNew( "musicSound", 1 )
optionIce:storeIfNew( "gameSound", 1 )
optionIce:storeIfNew( "tutorial_shown", false )


-- default scores
scoreIce = ice:loadBox( "scores" )
scoreIce:storeIfNew( "Player 1", 100 )
scoreIce:storeIfNew( "Player 2", 500 )
scoreIce:storeIfNew( "Player 3", 1000 )
scoreIce:storeIfNew( "Player 4", 2500 )
scoreIce:storeIfNew( "Player 5", 5000 )

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

local function gameSettings( event )
    if ( event.isError ) then
        print( "Network error!")
    else
        print ( "game settings RESPONSE:"  )
        local t = json.decode( event.response )
        
        -- Go through the array in a loop
        if t.save_settings == true then
            print("settings saved")
            loadsave.saveTable( t, "settings.json" )
        end
        
    end
end

network.request( "http://gaak.atwebpages.com/game_settings.php", "GET", gameSettings )
promotionView.initDefaults()
network.request( "http://gaak.atwebpages.com/test_promotion.php", "GET", promotionView.onApiComplete )
Analytics.init("XWNJRSQMWTQKGC3WYWWN")

storyboard.gotoScene( "menu", "fade", 1000 )

-- print("buffer width",bufferWidth,bufferWidthRatio)
-- print("buffer height",bufferHeight,bufferHeightRatio)
-- print(display.viewableContentHeight,display.viewableContentWidth)
-- print(display.contentHeight,display.contentWidth)
-- print(display.actualContentHeight,display.actualContentWidth)