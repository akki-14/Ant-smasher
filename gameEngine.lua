require("antCreate")
require("antCreateTwin")
require("antCreateLine")
require("antCreateRoam")
require("antCreateZigZag")
require("antCreateCross")
require("antCreateOrbit")
require("antCreateFast")
require("flyCreate")
require("antCreateSShape")
require("antCreateBoss")
require("antCreateKing")
require("gainLife")

local gameEngineTimer = nil
local tempGroup
GameEngine = {
    new = function(group)
        tempGroup = group
        local calculate
        local seq = {"ant1","ant2","scorpio","antBoss"}
        local type1
        local type2
        local type3
        local NORMAL_ANT = 1
        local TWIN_ANT = 2
        local LINE_ANT = 3
        local FREE_ROAM_ANT = 4
        local ZIG_ZAG_ANT = 5
        local CROSSING_ANT = 6
        local ANT_WITH_ORBIT = 7
        local FAST_ANT = 8
        local FLY_ROUTE = 9
        local S_SHAPE_ANT = 10
        local BOSS_ANT = 11
        local KING_ANT = 12
        
        local displayAnts
        
        
        local function getRandomAntPattern(...)
            local args = {...}
            --            for i,v in ipairs(args) do
            --                table.insert( values, v )
            --            end
            return args[math.random(#args)]
        end
        
        function calculate(points,totalKilled)
            
            
            local numOfAnts = math.random(5,8)
            local antPattern
            local antType
            local DELAY_TIME
            local posX
            if score  < 750 then
                antPattern = getRandomAntPattern(NORMAL_ANT,FREE_ROAM_ANT,LINE_ANT,
                ZIG_ZAG_ANT,TWIN_ANT)
                antType = math.random(3)
                DELAY_TIME = math.random(1300,1600)
                posX = 0
                if(antPattern == NORMAL_ANT ) then
                    if score < 300 then
                        DELAY_TIME = math.random(800,1000)
                    else
                        DELAY_TIME = math.random(650,900)
                    end
                elseif(antPattern == FREE_ROAM_ANT) then
                    posX = math.random(700)
                    numOfAnts = math.random(7,10)
                    DELAY_TIME = 90
                elseif(antPattern == LINE_ANT) then
                    posX = math.random(bufferWidth + 50,670 - bufferWidth)
                    if score < 300 then
                        DELAY_TIME = math.random(1100,1400)
                    else
                        DELAY_TIME = math.random(1000,1200)
                    end
                elseif(antPattern == ZIG_ZAG_ANT ) then
                    if score < 300 then
                        DELAY_TIME = math.random(1100,1400)
                    else
                        DELAY_TIME = math.random(900,1200)
                    end
                elseif(antPattern == TWIN_ANT ) then
                    if score < 300 then
                        DELAY_TIME = math.random(1100,1400)
                    else
                        DELAY_TIME = math.random(1000,1200)
                    end
                end
                
            elseif score  < 1500 then
                
                antPattern = getRandomAntPattern(BOSS_ANT,TWIN_ANT,FAST_ANT,CROSSING_ANT
                ,LINE_ANT,S_SHAPE_ANT,FLY_ROUTE,FREE_ROAM_ANT)
                antType = math.random(3)
                DELAY_TIME = math.random(1000,1500)
                posX = 0
                if(antPattern == LINE_ANT) then
                    posX = math.random(bufferWidth + 30,680 - bufferWidth)
                    DELAY_TIME = DELAY_TIME - 100
                elseif(antPattern == FLY_ROUTE ) then
                    DELAY_TIME = DELAY_TIME - 200
                elseif(antPattern == FREE_ROAM_ANT ) then
                    DELAY_TIME = DELAY_TIME - 300
                elseif(antPattern == TWIN_ANT ) then
                    DELAY_TIME = math.min(DELAY_TIME,1300)
                elseif(antPattern == S_SHAPE_ANT ) then
                    DELAY_TIME = math.min(DELAY_TIME-300,1100)
                elseif(antPattern == CROSSING_ANT or antPattern==FAST_ANT ) then
                    DELAY_TIME = math.min(DELAY_TIME-200,1200) 
                elseif(antPattern == BOSS_ANT ) then
                    numOfAnts = 1
                end
                
            elseif score  < 3500 then
                antPattern = getRandomAntPattern(CROSSING_ANT,FREE_ROAM_ANT,TWIN_ANT,LINE_ANT,
                ZIG_ZAG_ANT,FLY_ROUTE,KING_ANT)
                antType = math.random(3)
                DELAY_TIME = math.random(700,1400)
                posX = 0
                if(antPattern == FREE_ROAM_ANT) then
                    posX = math.random(bufferWidth + 50,660 - bufferWidth)
                    DELAY_TIME = 90
                elseif(antPattern == LINE_ANT) then
                    posX = math.random(bufferWidth + 50,680 - bufferWidth)
                    DELAY_TIME = DELAY_TIME - 200
                elseif(antPattern == ZIG_ZAG_ANT ) then
                    DELAY_TIME = DELAY_TIME - 300
                elseif(antPattern == LINE_ANT ) then
                    DELAY_TIME = DELAY_TIME - 300
                elseif(antPattern == CROSSING_ANT  or antPattern == FAST_ANT) then
                    DELAY_TIME = DELAY_TIME - 200
                elseif(antPattern == KING_ANT ) then
                    numOfAnts = math.min(numOfAnts,4)
                    DELAY_TIME = DELAY_TIME + 2000
                end
                
            else
                
                antPattern = getRandomAntPattern(S_SHAPE_ANT,BOSS_ANT,FREE_ROAM_ANT,FLY_ROUTE,LINE_ANT,
                CROSSING_ANT,FAST_ANT,KING_ANT)
                antType = math.random(3)
                DELAY_TIME = math.random(900,1200)
                posX = 0
                if(antPattern == FREE_ROAM_ANT) then
                    posX = math.random(bufferWidth + 50,660 - bufferWidth)
                    DELAY_TIME = 90
                elseif(antPattern == S_SHAPE_ANT ) then
                    DELAY_TIME = DELAY_TIME
                elseif(antPattern == LINE_ANT) then
                    posX = math.random(bufferWidth + 50,680 - bufferWidth)
                    DELAY_TIME = DELAY_TIME- 300
                elseif(antPattern == CROSSING_ANT or antPattern==FAST_ANT ) then
                    DELAY_TIME = DELAY_TIME-400
                elseif(antPattern == KING_ANT ) then
                    DELAY_TIME = DELAY_TIME + 2000
                elseif(antPattern == BOSS_ANT ) then
                    numOfAnts = 1
                elseif(antPattern == KING_ANT ) then
                    numOfAnts = math.min(numOfAnts,4)
                    DELAY_TIME = DELAY_TIME + 1800
                end
                
            end
            gameEngineTimer = timer.performWithDelay(DELAY_TIME,displayAnts,numOfAnts)
            gameEngineTimer.params = {num = numOfAnts,pattern = antPattern,positionX = posX, category = antType}
        end
        
        function displayAnts(event)
            if gameOver == false then	
                local ant = event.source.params
                local antPattern = ant.pattern
                local posX = ant.positionX
                local antType = ant.category
                local delay = nil
                if antPattern == NORMAL_ANT then
                    CreateAnt.new(group,seq[math.random(2)])
                elseif antPattern == TWIN_ANT then
                    CreateAntTwin.new(group,seq[math.random(2)])
                elseif antPattern == LINE_ANT then
                    CreateAntLine.new(group,seq[math.random(2)],posX)
                elseif antPattern == FREE_ROAM_ANT then
                    CreateAntRoam.new(group,seq[1],posX)
                elseif antPattern == ZIG_ZAG_ANT then
                    CreateAntZigZag.new(group,seq[math.random(2)])
                elseif antPattern == CROSSING_ANT then
                    CreateAntCross.new(group,seq[math.random(3)])
                elseif antPattern == ANT_WITH_ORBIT then
                    CreateAntOrbit.new(group,"bee")
                elseif antPattern == FAST_ANT then
                    CreateAntFast.new(group,seq[math.random(3)])
                elseif antPattern == FLY_ROUTE then
                    FlyCreate.new(group,"fly")
                elseif antPattern == S_SHAPE_ANT then
                    CreateAntSShape.new(group,seq[math.random(2)])
                elseif antPattern == BOSS_ANT then
                    CreateAntBoss.new(group,seq[4])
                    delay = 5000
                elseif antPattern == KING_ANT then
                    CreateKingAnt.new(group,seq[math.random(2)])
                end
                
                
                if(event.count == ant.num) then
                    if delay == nil then
                        delay = math.random(1800,2500)
                    end
                    gameEngineTimer = timer.performWithDelay(delay,function()
                        calculate(score,10)
                    end)
                end
            else
                timer.cancel(event.source)
            end	
        end
        
        function aaa(event)
            CreateAnt.new(group,seq[1])
            --CreateAntBoss.new(group,seq[4])
            --CreateAntRoam.new(group,seq[4],200)
            --CreateKingAnt.new(group,seq[1])
            --CreateAntSShape.new(group,seq[1])
            --CreateAntOrbit.new(group,"bee")
            --FlyCreate.new(group,seq[1])
            if(event.count == 2) then
                local temp = function(event)
                    calculate(score,10)
                end
                
                gameEngineTimer = timer.performWithDelay(math.random(2000,3200),temp)
                
            end
        end
        
        gameEngineTimer = timer.performWithDelay(math.random(1500,2500),aaa,2)
    end,
    pause = function (view)
        timer.pause( gameEngineTimer )
        transition.pause()
        gamePause = true ; 
        transition.to(view, { time=100, x=display.contentCenterX})
        --SpriteAnim.pause()
    end,
    resume = function (view)
        timer.resume( gameEngineTimer )
        transition.resume()
        gamePause = false
        transition.to( view, { time=100, x=-display.contentCenterX})
        --SpriteAnim.resume()
        
    end
}	