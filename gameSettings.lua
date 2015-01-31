
local loadsave = require("loadsave")
local serverSettings = loadsave.loadTable("settings.json")

local GameSettings = {}

local GameSettings_mt = { __index = GameSettings }



--- Initiates a new GGFont object.
-- @return The new object.
function GameSettings:new()
    
    local self = {}

    setmetatable( self, GameSettings_mt )
    
	self.gameSpeed = GameSettings:getGameSpeed()

    return self
    
end

function GameSettings:getGameSpeed()
	print("server",serverSettings)
	if serverSettings ~= nil and serverSettings.game_speed ~= nil then
		return serverSettings.game_speed
	else
		return 0.85
	end	
end

_G.gameSettings = GameSettings:new()
return _G.gameSettings