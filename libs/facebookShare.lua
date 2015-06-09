local json = require("json")
local facebook = require("facebook")
local fbCommand
local fbAppId
local isLoggedIn = false
local M = {}


local function fbListener( event )
    
    if ( "session" == event.type ) then
        print( "Session Status: " .. event.phase )
        if event.phase ~= "login" then
            print("facebook login error" , event.response)
            native.showAlert( "Facebook", "Login Fail" .. event.response )
            return
        else
            isLoggedIn = true
            native.showAlert( "Facebook", "Login Successfull" .. event.response )
        end
        
    elseif ( "request" == event.type ) then
        -- event.response is a JSON object from the FB server
        local response = event.response
        
        if ( not event.isError ) then
            response = json.decode( event.response )
            
        native.showAlert( "Facebook", "Request " .. event.response )
            if fbCommand == GET_USER_INFO then
                --statusMessage.textObject.text = response.name
                print( "name", response.name )
                
                
            elseif fbCommand == SHARE_APP then
                
            else
                -- Unknown command response
                print( "Unknown command response" )
            end
            
        else
            -- Post Failed
            printTable( event.response, "Post Failed Response", 3 )
        end
        
    elseif ( "dialog" == event.type ) then
        native.showAlert( "Facebook", "Dialog " .. event.response )
        print( "dialog response:", event.response )
    end
end


M.login = function(appId)
    fbAppId = appId
    facebook.login( appId, fbListener, {"email","publish_actions"} )
end


M.showDialog  = function()
    facebook.showDialog( "feed", {
        name = "Ant Smasher",
        caption = "GAAK APPS" ,
        description = "Hey friends I scored " .. score  .. " in Ant Smasher. You want to give it a try ?",
        picture="http://i61.tinypic.com/2n0lgqq.png",
        link = "https://play.google.com/store/apps/details?id=com.gaakapps.antsmasher"
    })
end

M.shareApp = function()
    facebook.showDialog( "feed", {
        name = "Ant Smasher",
        caption = "GAAK APPS" ,
        description = "A cool and really simple game for children and adults. Play for joy and have fun smashing ants and bugs.",
        picture="http://i61.tinypic.com/2n0lgqq.png",
        link = "https://play.google.com/store/apps/details?id=com.gaakapps.antsmasher"
    })
end

M.sendAppRequest = function()
--    facebook.login( fbAppId, fbListener, {"publish_actions" } )
    facebook.showDialog( "apprequests", { message="Download this game and challenge me!" } )
end


M.requestMe = function()
    if isLoggedIn then
        facebook.request( "me" )
    else
        M.login(fbAppId,S)
    end
end

return M
