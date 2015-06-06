
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
                name="antBoss", 
                start=6,
                count=4,
                time=400,
                loopCount=0
            },
            
            {
                name="antBossSmash", 
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
    
    frog = function()
        
        local sequenceData =
	{
            {
                name="frog", 
                start=1,
                count=7,
                time=500, 
                loopCount=1
            },
            
            {
                name="frogSmash", 
                frames={8}
            }
	}
	
	
	local sheetData = { width=100, height=180, numFrames=8, sheetContentWidth=800, sheetContentHeight=180 }
        
	local spriteSheet = graphics.newImageSheet( "sprites/frog_sprite.png", sheetData )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	spriteSet.y = -40
	return spriteSet
    end,
    roamingBomb = function()
        
        local sequenceData =
	{
            
            {
                name="still", 
                frames={1}
            },
            {
                name="walk", 
                start=2,
                count=9,
                time=800, 
                loopCount=0
            },
            {
                name="walk_inv", 
                start=13,
                count=9,
                time=800, 
                loopCount=0
            },
            {
                name="explode", 
                frames={22}
            }
	}
	
	
	local sheetData = { width=102, height=142, numFrames=22, sheetContentWidth=1122, sheetContentHeight=284 }
        
	local spriteSheet = graphics.newImageSheet( "sprites/roaming_bomb.png", sheetData )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	return spriteSet
    end,
    
    roamingBombInv = function()
        
        local sequenceData =
	{
            {
                name="still", 
                frames={1}
            },
            {
                name="walk", 
                start=2,
                count=9,
                time=800, 
                loopCount=0
            },
            
            {
                name="explode", 
                frames={11}
            }
	}
	
	
	local sheetData = { width=102, height=142, numFrames=11, sheetContentWidth=1122, sheetContentHeight=142 }
        
	local spriteSheet = graphics.newImageSheet( "sprites/roaming_bomb_inv.png", sheetData )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
	return spriteSet
    end,
    
    explode = function()
        
        local sequenceData =
	{
            {
                start = 1,
                count = 11,
                time=1200,
                loopCount=1
            }
	}
	
	
	local sheetData = { width=253, height=128, numFrames=12, sheetContentWidth=768, sheetContentHeight=512 }
        
	local spriteSheet = graphics.newImageSheet( "sprites/explosion.png", sheetData )
  	local spriteSet = display.newSprite( spriteSheet, sequenceData )
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