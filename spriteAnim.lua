
SpriteAnim = {
  new = function()
  
	  local sequenceData =
	{
		 {
			 name="ant1", 
			 start=1,
			 count=4,
			 time=200, 
			 loopCount=0
		 },
		 
		 {
			 name="ant1Smash", 
			 frames={5}
		 },
		 {
			 name="ant2", 
			 start=6,
			 count=4,
			 time=250,
			 loopCount=0
		 },
		 
		 {
			 name="ant2Smash", 
			 frames={10}
		 },
		 {
			 name="scorpio", 
			 start=11,
			 count=4,
			 time=200, 
			 loopCount=0
		 },
		 
		 {
			 name="scorpioSmash", 
			 frames={15}
		 }
	}
	
	local isPause = false
	local sheetData1 = { width=100, height=140, numFrames=15, sheetContentWidth=500, sheetContentHeight=420 }
  
	local spriteSheet = graphics.newImageSheet( "sprites/ants1.png", sheetData1 )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	spriteSet.y = -40
	return spriteSet
  end,
  
  new2 = function()
  
	  local sequenceData =
	{
		 {
			 name="bee", 
			 start=1,
			 count=4,
			 time=200, 
			 loopCount=0
		 },
		 
		 {
			 name="beeSmash", 
			 frames={5}
		 },
		 {
			 name="ladybird", 
			 start=6,
			 count=4,
			 time=200, 
			 loopCount=0
		 },
		 
		 {
			 name="ladybirdSmash", 
			 frames={9}
		 },
		 {
			 name="fly", 
			 start=11,
			 count=4,
			 time=200, 
			 loopCount=0
		 },
		 
		 {
			 name="flySmash", 
			 frames={15}
		 }
	}
	
	
	local sheetData1 = { width=100, height=140, numFrames=15, sheetContentWidth=500, sheetContentHeight=420 }
  
	local spriteSheet = graphics.newImageSheet( "sprites/ants2.png", sheetData1 )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	spriteSet.y = -40
	
	return spriteSet
  end,
  
  spriteListener = function(event)
 
		if gameOver == true then
			event.target:pause()
		end

		
	 end,
	 
	 endLife = function(obj)
	 
		if obj.sequence ~= "scorpio" and numLives > 0 then
			SoundControl.Smash("lifeLost")
			lives[numLives]:removeSelf()
			lives[numLives] = nil
			numLives = numLives - 1
			system.vibrate()
		end
		
	 end,
	 pause = function ()
	 	isPause = true
	 end,
	 resume = function ()
	 	isPause = false
	 end
	 
}