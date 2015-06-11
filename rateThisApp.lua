
module( ..., package.seeall )
local json = require("json")

function rateThis()
    local thisRate = ice:loadBox( "myRate" );
    local time = thisRate:retrieve( "time" );
    local currentVersion = thisRate:retrieve( "popup_version" );
    local previousVersion = thisRate:retrieve( "popup_previous_version" );
    
    network.request( "http://gaak.atwebpages.com/rate_popup.php", "GET", function(event)
        print ( "call back"  )
        if ( event.isError ) then
            print( "Network error!")
        else
            local t = json.decode( event.response )
            if previousVersion == nil or t.popup_version > previousVersion then
                currentVersion = t.popup_version
                thisRate:store("popup_version",currentVersion);
                thisRate:save();
                print("version", currentVersion)
            end
            
        end
    end
    )
    local function votarandroid( event )
        if "clicked" == event.action then
            local i = event.index
            if 1 == i then
                Analytics.logEvent("rate_app_click")
                time = 5
                thisRate:store("time",time);
                thisRate:save();
                system.openURL("market://details?id=" .. system.getInfo("androidAppPackageName") )
            elseif 2 == i then
                time = -5
                thisRate:store("popup_previous_version",currentVersion);
                thisRate:store("time",time);
                thisRate:save();
            end
        end
    end
    
    if currentVersion ~= nil and previousVersion ~= nil and currentVersion ~= previousVersion and time ~= 5 then
        Analytics.logEvent("rate_app_shown")
        native.showAlert("ENJOYING The Game!!" , "How would you rate Ant Smasher",
        { "Rate 5 stars", "Later" }, votarandroid )
        
    elseif time == nil  then
        -- FIRST TIME ENTERING YOUR APP
        time =1;
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 5 then
        -- THE USER DO NOT WANT TO RATE YOUR APP OR HE ALREADY MADE
        return true;
    elseif time < 4 then
        time = time+1
        print(time)
        thisRate:store("time",time);
        thisRate:save();
        return true; 
    elseif time == 4 then
        Analytics.logEvent("rate_app_shown")
        native.showAlert("ENJOYING The Game!!" , "How would you rate Ant Smasher",
        { "Rate 5 stars", "Later" }, votarandroid )
        
    end
    
end