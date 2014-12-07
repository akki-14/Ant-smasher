local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true

local opGroup
local selectedIndex

--display objects
local bgImage
local bgTitle
local bgBack
local selectBgText
local background = {}
local selectedBg
local border = {}
local musicSound
local gameSound
local musicSoundText
local gameSoundText
local musicSoundBtn
local gameSoundBtn


--functions
local selectBg
local manageMusicSound
local manageGameSound
local toggle
local goToMenu
local onKeyEvent

function toggle(value,soundObj)
		SoundControl.Tick()
		local tempY = soundObj.y
		local tempX = soundObj.x
		soundObj:removeSelf()
		soundObj = nil
	if value == 1 then
		value = 0
		soundObj =  display.newImage(opGroup,"images/sound_off.png",tempX,tempY)
	else
		value = 1
		soundObj =  display.newImage(opGroup,"images/sound_on.png",tempX,tempY)
	end
		
	return value,soundObj
end

function manageMusicSound(event)
	local target = event.target
	musicSound,musicSoundBtn = toggle(musicSound,target)
	musicSoundBtn:addEventListener("tap",manageMusicSound)
	optionIce:store("musicSound",musicSound)
	if musicSound == 0 then
		audio.setVolume(0,{channel = 1})
	else
		audio.setVolume(1,{channel = 1})	
	end
	
end

function manageGameSound(event)
	local target = event.target
	gameSound,gameSoundBtn = toggle(gameSound,target)
	gameSoundBtn:addEventListener("tap",manageGameSound)
	optionIce:store("gameSound",gameSound)
	if gameSound == 0 then
		audio.setVolume(0,{channel = 2})
	else
		audio.setVolume(1,{channel = 2})	
	end
	
	
end

function selectBg(event)
		SoundControl.Tick()
		local target = event.target
		selectedBg:removeSelf()
		selectedBg = nil
		selectedBg = display.newImage(opGroup,"images/selected.png",display.contentCenterX,display.contentCenterY)
		selectedBg.x = target.x
		selectedBg.y = target.y + background[selectedIndex].contentHeight / 2 - 25
		selectedBg:scale(0.7,0.7)
		
		optionIce:store("background",target.index)
	end

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
		
	 
	selectedIndex = optionIce:retrieve("background")
	
	bgImage = display.newImage(opGroup,"images/bg_image.jpg",display.contentCenterX,display.contentCenterY)	
	bgTitle = display.newText(opGroup,"OPTIONS",display.contentCenterX ,bufferHeight + 120, "Easter Sunrise",80)
	bgBack = display.newText(opGroup,"BACK",display.contentCenterX ,display.viewableContentHeight - 80, "Easter Sunrise",80)
	
	selectBgText = display.newText(opGroup,"Select Background",display.contentCenterX ,bufferHeight + 260 , "Base 02",40)
	for i = 1,5 do	
		background[i] = display.newImage(opGroup,"images/bg_game" .. i .. ".jpg",display.contentCenterX,display.contentCenterY)
		background[i]:scale(0.17,0.17)
		background[i]:addEventListener("tap",selectBg)
		background[i].index = i
		
		border[i] = display.newImage(opGroup,"images/border.png",display.contentCenterX,display.contentCenterY)
		border[i]:scale(0.178,0.178)
		if i < 4 then
			local free = (display.viewableContentWidth - (background[i].contentWidth) * 3) / 4
			background[i].y = 250 + background[i].contentHeight
			background[i].x = (( (i * free) + bufferWidth ) + background[i].contentWidth * (i-1)) + background[i].contentWidth / 2
			border[i].x = background[i].x
			border[i].y = background[i].y
		else
			local free = (display.viewableContentWidth - (background[i].contentWidth) * 2 ) / 3
			background[i].y = 220 +  (5 * background[i].contentHeight) / 2
			background[i].x = (( ( (i-3) * free) + bufferWidth ) + background[i].contentWidth * (i-4) ) + background[i].contentWidth / 2
			border[i].x = background[i].x
			border[i].y = background[i].y
		
		end
	end
	
	selectedBg = display.newImage(opGroup,"images/selected.png",display.contentCenterX,display.contentCenterY)
	selectedBg.x = background[selectedIndex].x
	selectedBg.y = background[selectedIndex].y + background[selectedIndex].contentHeight / 2 - 25
	selectedBg:scale(0.7,0.7)
	
	
	musicSound = optionIce:retrieve("musicSound")
	gameSound = optionIce:retrieve("gameSound")
	
	musicSoundText = display.newText(opGroup,"Music Sound",display.contentCenterX - 80,display.contentCenterY + 340, "Base 02",40)
	gameSoundText = display.newText(opGroup,"Game Sound",display.contentCenterX - 80,display.contentCenterY + 450, "Base 02",40)
	
	if	musicSound == 1 then
		audio.setVolume(1,{channel = 1})	
		musicSoundBtn =  display.newImage(opGroup,"images/sound_on.png",display.contentCenterX + 130,display.contentCenterY + 340)
	else
		audio.setVolume(0,{channel = 1})			
		musicSoundBtn =  display.newImage(opGroup,"images/sound_off.png",display.contentCenterX + 130,display.contentCenterY + 340)
	end
	
	
	if	gameSound == 1 then
		audio.setVolume(1,{channel = 2})	
		gameSoundBtn =  display.newImage(opGroup,"images/sound_on.png",display.contentCenterX + 130,display.contentCenterY + 450)
	else
		audio.setVolume(0,{channel = 2})
		gameSoundBtn =  display.newImage(opGroup,"images/sound_off.png",display.contentCenterX + 130,display.contentCenterY + 450)
	end
	
	
	
	
	
	
	
end

function scene:enterScene(event)
	
	bgBack:addEventListener("tap",goToMenu)
	musicSoundBtn:addEventListener("tap",manageMusicSound)
	gameSoundBtn:addEventListener("tap",manageGameSound)
	Runtime:addEventListener( "key", onKeyEvent )
end


function scene:exitScene(event)
	optionIce:save()

	bgBack:removeEventListener("tap",goToMenu)
	musicSoundBtn:removeEventListener("tap",manageMusicSound)
	gameSoundBtn:removeEventListener("tap",manageGameSound)
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