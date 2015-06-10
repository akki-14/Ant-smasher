
module( ..., package.seeall )

function rateThis()
    local thisRate = ice:loadBox( "myRate" );
    local time = thisRate:retrieve( "time" );
    -- IF YOU RESET THE CODE UNCOMMENT THE CODE BELLOW
    --thisRate:store("time",nil);
    --thisRate:save();
    if time == nil  then
        -- FIRST TIME ENTERING YOUR APP
        time =1;
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 5 then
        -- THE USER DO NOT WANT TO RATE YOUR APP OR HE ALREADY MADE
        return true;
    elseif time < 1 then
        -- IF TIME == 2 W8 FOR THE NEXT TIME
        time = time+1
        print(time)
        thisRate:store("time",time);
        thisRate:save();
        return true; 
    elseif time == 1 then
        -- IF TIME == 2 W8 FOR THE NEXT TIME
        time = time+1
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 2 then
        -- IF TIME == 2 W8 FOR THE NEXT TIME
        time = time+1
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 3 then
        -- IF TIME == 3 W8 FOR THE NEXT TIME
        time = time+1
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 4 then
        -- IF TIME == 3 CALL THE VOTE;
        -- EVENT NATIVE ALERT FOR ANDROID
        local function votarandroid( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    Analytics.logEvent("rate_app_click")
                    system.openURL("market://details?id=" .. system.getInfo("androidAppPackageName") )
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 2 == i then
                    time = -2
                    thisRate:store("time",time);
                    thisRate:save();
                end
            end
        end
        Analytics.logEvent("rate_app_shown")
        native.showAlert("ENJOYING The Game!!" , "How would you rate Ant Smasher",
        { "Rate 5 stars", "Later" }, votarandroid )
        
    end
    
    
    
end