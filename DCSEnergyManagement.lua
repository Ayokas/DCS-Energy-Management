-- Updates Windows Energy Management based on playercount. Boosts to "High Performance" when players connect.
-- If no players are connected (IDLE) sets windows energy plan to balanced to save power.
--
-- Author: Ayokas (August.2022)
-- See GitHub: https://github.com/Ayokas/DCS-Energy-Management

-- GUIDs for powercfg tool, get GUIDs for you system with cmd or powershell: powercfg /L
-- Balanced GUID, e.g. "381b4222-f694-41f0-9685-ff5bb260df2e"
local balancedGUID = "<insert blanced GUID here>"

-- High Performance GUID, e.g. "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
local highPerformanceGUID = "<insert high performance GUID here>"


-- Leave this as it is =)

local energyHandler = {}
local clients = 0


function energyHandler.log(str)
    net.log(string.format("[EnergyManagement] %s", str))
end

energyHandler.onPlayerConnect = function(id)
    clients = clients + 1
    energyHandler.log(string.format("%s connected, total clients %d", net.get_player_info(id, 'name'), clients))

    if clients == 2 then
        energyHandler.log("Player connected - setting to high performance")
        -- execute os command via os.execute: http://www.lua.org/manual/5.4/manual.html#pdf-os.execute
        os.execute(string.format("powercfg /S %s", highPerformanceGUID))
    end

    -- if server starts set to energy saving, just to be sure
    if clients == 1 then
        energyHandler.log("No players connected - setting to energy saving / balanced")
        os.execute(string.format("powercfg /S %s", balancedGUID))
    end
end


energyHandler.onPlayerDisconnect = function(id)
    clients = clients - 1
    energyHandler.log(string.format("Player disconnected, total clients %d", clients))

    if clients == 1 then
        energyHandler.log("No players connected - setting to energy saving / balanced")
        os.execute(string.format("powercfg /S %s", balancedGUID))
    end
end

DCS.setUserCallbacks(energyHandler)
energyHandler.log("Loaded and ready!")
