local M = {}

M.share = function()
    local popupName = "social"
    local isAvailable = native.canShowPopup( popupName, "share" )
    if isAvailable then
        local listener = {}
        function listener:popup( event )
            print( "name(" .. event.name .. ") type(" .. event.type .. ") action(" .. tostring(event.action) .. ") limitReached(" .. tostring(event.limitReached) .. ")" )			
        end
        
        -- Show the popup
        native.showPopup( popupName,
        {
            service = "share", -- The service key is ignored on Android.
            message = "Checkouth this awesome new Game i Played",
            listener = listener,
            image = 
            {
                { filename = "images/ant_logo.png", baseDir = system.ResourceDirectory },
            },
            url = 
            { 
                "https://play.google.com/store/apps/details?id=com.gaakapps.antsmasher",
                "market://details?id=com.gaakapps.antsmasher"
            }
        })
    else
        print("Android Share Error")
    end
end


return M

