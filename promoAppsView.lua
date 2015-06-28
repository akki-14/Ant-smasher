-- slideView.lua
-- 
-- Version 1.0 
--
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

module(..., package.seeall)

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local images = nil
local prevX
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local cross
local imageNumberText, imageNumberTextShadow
local modeselector = {}
local imagePath

function new( promotionArray, path, slideBackground, top, bottom)	
    local pad = 0
    local top = top or 0 
    local bottom = bottom or 0
    
    local g = display.newGroup()
    
    if slideBackground then
        background = display.newImage(slideBackground, screenW / 2, (screenH-(top+bottom) )/ 2, true)
    else
        background = display.newRect( 0, 0, screenW, screenH-(top+bottom) )
        
        -- set anchors on the background
        background.anchorX = 0
        background.anchorY = 0
        
        background:setFillColor(0, 0, 0,0.8)
    end

    cross = display.newImage("images/no.png")
    cross.x = screenW - cross.contentWidth
    cross.y = (screenH-(top+bottom)) - cross.contentHeight

    if path then
        imagePath = system.DocumentsDirectory
    else
        imagePath = system.ResourceDirectory
    end    

    g:insert(background)
    g:insert(cross)

    cross:addEventListener("tap",function ()
        g.isVisible = false
    end)

    local function action(event)
        local target = event.target
        system.openURL( "market://details?id=" .. target.package_name )
        
    end
    
    
    
    images = {}
    local sel = {}
    local modes = {"kidMode","timeMode","arcade"}
    local arraySize = #promotionArray
    for i = 1,arraySize do
        local p = display.newImage(promotionArray[i].image_name,imagePath)
        local h = viewableScreenH-(top+bottom)
		--[[if p.width > viewableScreenW or p.height > h then
			if p.width/viewableScreenW > p.height/h then 
					p.xScale = viewableScreenW/p.width
					p.yScale = viewableScreenW/p.width
			else
					p.xScale = h/p.height
					p.yScale = h/p.height
			end		 
		end
        ]]--
        
        sel[i] = display.newImage("images/unselected_position.png")
        local center =  math.modf(arraySize * 0.5) + 1

        if arraySize % 2 == 0 then
            local diff	= sel[i].contentWidth * 1.5
            
            sel[i].x = screenW * 0.5 +  (i - center + 0.5) * diff 
            sel[i].y = screenH * 0.5 + 230
            print("modes",i,center)
        else
            
            --local sel[i] = display.newCircle(0,0,10)
            sel[i].x = screenW * 0.5 + (i - center) * sel[i].contentWidth * 2
            sel[i].y = screenH * 0.5 + 230
        end
        g:insert(p)
        g:insert(sel[i])
        
        if (i > 2) then
            p.x = screenW * 1.5 + pad -- all images offscreen except the first one
        elseif i == 2 then 
            p.x = screenW + pad
        else 
            p.x = screenW * .5 + pad
        end
        
        p.y = h * .5 - 85
        p.package_name = promotionArray[i].game_package_name
        p:addEventListener("tap",action)
        images[i] = p
    end
    
    local selected = display.newImage("images/selected_position.png")
    selected.x = sel[1].x
    selected.y = sel[1].y
    g:insert(selected)
    
    imgNum = 1
    
    g.x = 0
    g.y = top + display.screenOriginY
    
    function touchListener (self, touch) 
        local phase = touch.phase
        --print("slides", phase)
        if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the contentBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true
            
            startPos = touch.x
            prevPos = touch.x
            
            
        elseif( self.isFocus ) then
            
            if ( phase == "moved" ) then
                
                
                if tween then transition.cancel(tween) end
                
                --print(imgNum)
                
                local delta = touch.x - prevPos
                prevPos = touch.x
                
                images[imgNum].x = images[imgNum].x + delta
                
				--[[if(images[imgNum].x < screenW*.5  and images[imgNum].x > screenW*.5 - 100) then
					if prevX ~=nil and prevX - images[imgNum].x > 0 then
						images[imgNum]:scale(1 + (1 /100),1 + (1 /100))
					print("bbbb",delta)
					else
						images[imgNum]:scale(1 - (1 /100),1 - (1 /100))
					print(prevX)
					end
					prevX = images[imgNum].x
                end]]--
                
                
                if (images[imgNum-2]) then
                    images[imgNum-2].x = images[imgNum-2].x + delta
                end
                if (images[imgNum-1]) then
                    images[imgNum-1].x = images[imgNum-1].x + delta
                end
                
                if (images[imgNum+1]) then
                    images[imgNum+1].x = images[imgNum+1].x + delta
                end
                if (images[imgNum+2]) then
                    images[imgNum+2].x = images[imgNum+2].x + delta
                end
                
            elseif ( phase == "ended" or phase == "cancelled" ) then
                
                dragDistance = touch.x - startPos
                --print("dragDistance: " .. dragDistance)
                
                if (dragDistance < -40 and imgNum < #images) then
                    nextImage()
                elseif (dragDistance > 40 and imgNum > 1) then
                    prevImage()
                else
                    cancelMove()
                end
                
                if ( phase == "cancelled" ) then		
                    cancelMove()
                end
                
                -- Allow touch events to be sent normally to the objects they "hit"
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false
                
            end
        end
        
        return true
        
    end
    
    function setSlideNumber()
        --print("setSlideNumber", imgNum .. " of " .. #images)
    end
    
    function cancelTween()
        if prevTween then 
            transition.cancel(prevTween)
        end
        prevTween = tween 
    end
    
    function nextImage()
	print("next")
        tween = transition.to( images[imgNum-1], {time=400, x= (screenW * .5 + pad) * -1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum], {time=400, x= pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+2], {time=400, x=screenW + pad, transition=easing.outExpo } )
        
        imgNum = imgNum + 1
        selected.x = sel[imgNum].x
        selected.y = sel[imgNum].y
        -- initImage(imgNum)
    end
    
    function prevImage()
	print("prev")
        tween = transition.to( images[imgNum+1], {time=400, x=screenW * 1.5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum], {time=400, x=screenW + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-2], {time=400, x=pad, transition=easing.outExpo } )
        imgNum = imgNum - 1
        selected.x = sel[imgNum].x
        selected.y = sel[imgNum].y
        -- initImage(imgNum)
    end
    
    function cancelMove()
	print("cancel")
        tween = transition.to( images[imgNum], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x= pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-2], {time=400, x= (screenW * .5 + pad) * -1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=400, x=screenW + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+2], {time=400, x=screenW * 1.5 + pad, transition=easing.outExpo } )
    end
    
    function initImage(num)
        if (num < #images) then
            images[num+1].x = screenW * 1.5 + pad			
        end
        if (num > 1) then
            images[num-1].x = (screenW * .5 + pad) * -1
        end
        setSlideNumber()
    end
    
    background.touch = touchListener
    background:addEventListener( "touch", background )
    
    ------------------------
    -- Define public methods
    
    function g:jumpToImage(num)
        local i
        print("jumpToImage")
        print("#images", #images)
        for i = 1, #images do
            if i < num then
                images[i].x = -screenW*.5;
            elseif i > num then
                images[i].x = screenW*1.5 + pad
            else
                images[i].x = screenW*.5 - pad
            end
        end
        imgNum = num
        initImage(imgNum)
    end
    
    function g:cleanUp()
        print("slides cleanUp")
        background:removeEventListener("touch", touchListener)
    end
    
    return g	
end

