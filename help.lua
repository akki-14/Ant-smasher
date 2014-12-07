local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true

local opGroup

--display objects
local bgImage
local bgTitle
local bgBack
local bgHelp

--functions
local goToMenu
local onKeyEvent


function goToMenu(event)
	SoundControl.Menu()
	storyboard.gotoScene( "menu", "fade", 500 )
end	

	function onKeyEvent(event)
	
		local phase = event.phase
			
		if event.phase=="down" and event.keyName=="back" then
			SoundControl.Menu()
			storyboard.gotoScene("menu", "fade", 500 )
			return true
		end
		return false
	end
	
	
function scene:createScene(event)
	opGroup = self.view
		
	
	bgImage = display.newImage(opGroup,"images/bg_image.jpg",display.contentCenterX,display.contentCenterY)	
	bgTitle = display.newText(opGroup,"HELP",display.contentCenterX ,bufferHeight + 120, "Easter Sunrise",80)
	bgBack = display.newText(opGroup,"BACK",display.contentCenterX ,display.viewableContentHeight - 80, "Easter Sunrise",80)
	bgHelp = display.newImage(opGroup,"images/help.png",display.contentCenterX,display.contentCenterY)	
	
end

function scene:enterScene(event)
	
	bgBack:addEventListener("tap",goToMenu)
	Runtime:addEventListener( "key", onKeyEvent )
end


function scene:exitScene(event)
	bgBack:removeEventListener("tap",goToMenu)
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