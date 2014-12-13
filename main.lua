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
ads = require("ads")

local musicSound
local gameSound

score = 0
orbitFlag = true
timerId = nil
gamePause = false

ads.init( "admob", "ca-app-pub-2883837174861368/5479620739" )  --ant smasher
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
			scoreIce:storeIfNew( "Player 1", 100 )
			scoreIce:storeIfNew( "Player 2", 200 )
			scoreIce:storeIfNew( "Player 3", 300 )
			scoreIce:storeIfNew( "Player 4", 400 )
			scoreIce:storeIfNew( "Player 5", 500 )
			scoreIce:storeIfNew( "Player 6", 750 )
			scoreIce:storeIfNew( "Player 7", 1000 )
			scoreIce:storeIfNew( "Player 8", 1250 )
			scoreIce:storeIfNew( "Player 9", 1500 )
			scoreIce:storeIfNew( "Player 10", 2000 )
			
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


print("buffer width",bufferWidth,bufferWidthRatio)
print("buffer height",bufferHeight,bufferHeightRatio)
print(display.viewableContentHeight,display.viewableContentWidth)
print(display.contentHeight,display.contentWidth)
print(display.actualContentHeight,display.actualContentWidth)