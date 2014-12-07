
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
		 }
	}
	
	
	local sheetData1 = { width=100, height=140, numFrames=5, sheetContentWidth=500, sheetContentHeight=420 }
  
	local spriteSheet = graphics.newImageSheet( "sprites/ants1.png", sheetData1 )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	
	return spriteSet
  end,
}