-- require the library and call the first method initDefaults then make api call and pass listener to it onApiComplete
-- rest just check for canShowPromo if true then showProtion else exit

module(..., package.seeall)

local M = {}
require("ice")
local loadsave = require("loadsave")
local json = require("json")
local Utils = require("libs.Utils")


local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local images = nil
local prevX
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local closePromotions
local promotionTitle
local imageNumberText, imageNumberTextShadow
local modeselector = {}
local imagePath


--Promotions
local promotionGroup
local promotionSavedData
local promotionSettings


M.new = function( promotionArray, path, slideBackground, top, bottom)	
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
        
        background:setFillColor(0, 0, 0,0.9)
    end
    
    closePromotions = display.newImage("images/no.png")
    closePromotions.x = screenW - closePromotions.contentWidth
    closePromotions.y = (screenH-(top+bottom)) - closePromotions.contentHeight
    
    promotionTitle = display.newImage("images/promotion_title.png")
    promotionTitle.x = CENTER_X
    promotionTitle.y = top + bottom + 200  
    
    if path then
        imagePath = system.DocumentsDirectory
    else
        imagePath = system.ResourceDirectory
    end    
    
    g:insert(background)
    g:insert(closePromotions)
    g:insert(promotionTitle)
    
    closePromotions:addEventListener("tap",function ()
        M.hidePromotion()
    end)
    
    local function action(event)
        local target = event.target
        system.openURL( "market://details?id=" .. target.package_name )
        Analytics.logEvent("promotion_click",{name = target.game_title})
    end
    
    
    
    images = {}
    local sel = {}
    local modes = {"kidMode","timeMode","arcade"}
    local arraySize = #promotionArray
    local showSide = 50
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
            sel[i].y = screenH * 0.5 + 400
            print("modes",i,center)
        else
            
            --local sel[i] = display.newCircle(0,0,10)
            sel[i].x = screenW * 0.5 + (i - center) * sel[i].contentWidth * 2
            sel[i].y = screenH * 0.5 + 400
        end
        g:insert(p)
        g:insert(sel[i])
        
        if (i > 2) then
            p.x = screenW * 1.5 + pad -- all images offscreen except the first one
        elseif i == 2 then
            local imageWidth = p.contentWidth
            p.x =  screenW + imageWidth/2 - showSide + pad
        else 
            p.x = screenW * .5 + pad
        end
        p.y = h * .5 
        p.package_name = promotionArray[i].game_package_name
        p.game_title = promotionArray[i].game_title
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
                
                if (images[imgNum-1]) then
                    images[imgNum-1].x = images[imgNum-1].x + delta
                end
                
                if (images[imgNum+1]) then
                    images[imgNum+1].x = images[imgNum+1].x + delta
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
    
    function cancelTween()
        if prevTween then 
            transition.cancel(prevTween)
        end
        prevTween = tween 
    end
    
    function nextImage()
        local sides = images[imgNum].contentWidth * 0.5 - showSide
        tween = transition.to( images[imgNum-1], {time=400, x= (screenW * .5 + pad) * -1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum], {time=400, x= pad - sides, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+2], {time=400, x=screenW + pad + sides, transition=easing.outExpo } )
        
        imgNum = imgNum + 1
        selected.x = sel[imgNum].x
        selected.y = sel[imgNum].y
        -- initImage(imgNum)
    end
    
    function prevImage()
        local sides = images[imgNum].contentWidth * 0.5 - showSide
        
        tween = transition.to( images[imgNum+1], {time=400, x=screenW * 1.5 + pad + sides , transition=easing.outExpo } )
        tween = transition.to( images[imgNum], {time=400, x=screenW + pad + sides, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-2], {time=400, x=pad - sides, transition=easing.outExpo } )
        imgNum = imgNum - 1
        selected.x = sel[imgNum].x
        selected.y = sel[imgNum].y
        -- initImage(imgNum)
    end
    
    function cancelMove()
        local sides = images[imgNum].contentWidth * 0.5 - showSide
        
        tween = transition.to( images[imgNum], {time=400, x=screenW * .5 + pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x= pad - sides, transition=easing.outExpo } )
        --        tween = transition.to( images[imgNum-2], {time=400, x= (screenW * .5 + pad - sides) * -1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=400, x=screenW + pad + sides, transition=easing.outExpo } )
        --        tween = transition.to( images[imgNum+2], {time=400, x=screenW * 1.5 + pad + sides, transition=easing.outExpo } )
    end
    
    background.touch = touchListener
    background:addEventListener( "touch", background )
    
    function g:cleanUp()
        print("slides cleanUp")
        background:removeEventListener("touch", touchListener)
    end
    
    return g	
end

M.initPromotion = function()
    if promotionSettings ~= nil and promotionSettings.show_promotion == true then
        local t = Utils.shuffleTable(promotionSettings.data)
        promotionGroup = M.new(t ,promotionSettings.image_path )
        return(promotionGroup)
    else 
        return nil
    end
end

M.showPromotion = function()
    if promotionGroup ~= nil then
        promotionGroup.isVisible = true
    else
        return M.initPromotion()
    end
    return promotionGroup
end

M.hidePromotion = function()
    if promotionGroup ~= nil then
        promotionGroup.isVisible = false
    end
end

M.canShowPromotion = function()
    local defaultReshow = 10
    promotionSettings = loadsave.loadTable("gamePromotion.json")
    if promotionSettings ~= nil and promotionSettings.reshow_interval then
        defaultReshow = promotionSettings.reshow_interval
    end
    
    local time = promotionSavedData:retrieve("promtionShowTime")
    if not time then
        promotionSavedData:store( "promtionShowTime", os.time() )
        promotionSavedData:save()
        return true
    else
        local timeDiff = os.difftime(os.time() - time)
        if timeDiff > defaultReshow or timeDiff < 0 then
            promotionSavedData:store( "promtionShowTime", os.time() )
            promotionSavedData:save()
            return true
        else
            print(defaultReshow - timeDiff,"seconds left to show promotions")
            return false
        end       
    end
    return true
end

M.initDefaults = function()
    promotionSavedData = ice:loadBox( "promotionBox" )
    promotionSavedData:storeIfNew( "promotionLastRefreshTime", os.time() )
    promotionSavedData:storeIfNew( "promotionVersion", 0 )
    promotionSavedData:storeIfNew( "promotionRefreshInterval", 100 )
    promotionSavedData:save()
end

M.onApiComplete = function( event )
    if ( event.isError ) then
        print( "Network error!")
    else
        local promotionVersion = promotionSavedData:retrieve("promotionVersion")
        local promotionLastRefreshTime = promotionSavedData:retrieve("promotionLastRefreshTime")
        local promotionRefreshInterval = promotionSavedData:retrieve("promotionRefreshInterval")
        
        local t = json.decode( event.response )
        -- Go through the array in a loop
        if t then 
            for k,v in pairs(t.data) do
                if v.game_package_name == system.getInfo( "androidAppPackageName" ) then
                    table.remove(t.data,table.indexOf(t.data,v))
                end
            end
            if  promotionVersion < t.version or os.time() - promotionLastRefreshTime > promotionRefreshInterval then
                print("new promotion settings")
                promotionSavedData:store( "promotionVersion", t.version )
                promotionSavedData:store( "promotionLastRefreshTime", os.time() )
                promotionSavedData:store( "promotionRefreshInterval", t.refresh_interval )
                promotionSavedData:save()
                for k,v in pairs(t.data) do
                    
                    network.download( v.image_url, "GET", function(event)
                        if ( event.isError ) then
                            print( "Network error - download failed" )
                        elseif ( event.phase == "ended" ) then
                            print( "image downloaded successfully" )
                        end
                    end, v.image_name, system.DocumentsDirectory )
                    
                    
                end	
            else
                print("Time to refresh promotion data",promotionRefreshInterval - (os.time() - promotionLastRefreshTime) .. " seconds")
            end	
            if t.save_promotion then
                print("saving promotion settings")
                loadsave.saveTable( t, "gamePromotion.json" )
            end
        end
        
    end
    
end


return M
