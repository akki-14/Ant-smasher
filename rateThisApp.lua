
module( ..., package.seeall )

function rateThis(gameUrl)
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
            --local url_app = "http://www.getjar.mobi/mobile/766867"
            --local url_app = "amzn://apps/android?p=com.cappoapps.antsmasher"
            local url_app = gameUrl
            
            
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    system.openURL(url_app )
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 2 == i then
                    time = -3
                    thisRate:store("time",time);
                    thisRate:save();
                end
            end
        end
        
        native.showAlert("Rate This App" , "How many Stars You'll Give !!!",
        { "Ok", "Not Now" }, votarandroid )
        
    end
    
    
    
end