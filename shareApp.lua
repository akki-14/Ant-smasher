local json = require("json")
local facebook = require("facebook")
local fbCommand			
local score-- forward reference
local LOGOUT = 1
local SHOW_DIALOG = 2
local SHARE_APP = 3
local POST_PHOTO = 4
local GET_USER_INFO = 5
local GET_PLATFORM_INFO = 6

local function listener( event )

-----------------------------------------------------------------------------------------
	-- After a successful login event, send the FB command
	-- Note: If the app is already logged in, we will still get a "login" phase
	--
    if ( "session" == event.type ) then
        -- event.phase is one of: "login", "loginFailed", "loginCancelled", "logout"
		
		print( "Session Status: " .. event.phase )
		
		if event.phase ~= "login" then
			-- Exit if login error
			return
		end
		
		-- The following displays a Facebook dialog box for posting to your Facebook Wall
		if fbCommand == SHOW_DIALOG then

			-- "feed" is the standard "post status message" dialog
			
			facebook.showDialog( "feed", {
				name = "Ant Smasher",
				caption = "GAAK APPS" ,
				description = "Hey friends I scored " .. score  .. " in Ant Smasher. You want to give it a try ?",
				picture="http://i61.tinypic.com/2n0lgqq.png",
				link = "https://play.google.com/store/apps/details?id=com.gaakapps.antsmasher"
			})
			-- for "apprequests", message is required; other options are supported
			--[[
			facebook.showDialog( "apprequests", {
				message = "Example message."
			})
			--]]
		end
	

		-- Request the current logged in user's info
		if fbCommand == GET_USER_INFO then
			facebook.request( "me" )
--			facebook.request( "me/friends" )		-- Alternate request
		end

	
		
		-- This code posts a message to your Facebook Wall
		if fbCommand == SHARE_APP then
				
			facebook.showDialog( "feed", {
				name = "Ant Smasher",
				caption = "GAAK APPS" ,
				description = "A cool and really simple game for children and adults. Play for joy and have fun smashing ants and bugs.",
				picture="http://i61.tinypic.com/2n0lgqq.png",
				link = "https://play.google.com/store/apps/details?id=com.gaakapps.antsmasher"
			})
			
		
		end
-----------------------------------------------------------------------------------------

    elseif ( "request" == event.type ) then
        -- event.response is a JSON object from the FB server
        local response = event.response
        
		if ( not event.isError ) then
	        response = json.decode( event.response )
	        
	        if fbCommand == GET_USER_INFO then
				--statusMessage.textObject.text = response.name
				print( "name", response.name )
				
							
			elseif fbCommand == SHARE_APP then
				--statusMessage.textObject.text = "Message Posted"
				
			else
				-- Unknown command response
				print( "Unknown command response" )
			end

        else
        	-- Post Failed
			printTable( event.response, "Post Failed Response", 3 )
		end
		
	elseif ( "dialog" == event.type ) then
		-- showDialog response
		--
		print( "dialog response:", event.response )
    end
end


ShareApp = 
{
		app = function(appId,id)
			fbCommand = id
			facebook.login( appId, listener,  {"publish_actions"}  )	
		
		end,
		score = function(appId,id,sc)
			fbCommand = id
			score = sc
			facebook.login( appId, listener,  {"publish_actions"}  )	
		
		end,
	
}
