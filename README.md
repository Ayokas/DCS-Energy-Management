# DCS-Energy-Management
This server hook sets windows power plans depending if players are connected or not. It sets the system energy plan to "High Performance" when players are connected to eliminate stutters. When all players are disconnected it will set the "Balanced" plan, so the system consumes less energy and reduces your electricity bill =)

## Installation
Copy the `DCSEnergyManagement.lua` file into your servers `%SAVED_GAMES%\DCS.openbeta_server\Scripts\Hooks\` directory.

Use **powershell** or **CMD** to get the GUIDs for you powerplan (as they might be different).

The output will look like this (currently in german, will provide in english as soon as I can but it will be obvious which values you need):
```powershell
PS C:\Users\Administrator> powercfg /L

Bestehende Energieschemen (* Aktiv)
-----------------------------------
GUID des Energieschemas: 381b4222-f694-41f0-9685-ff5bb260df2e  (Ausbalanciert) *
GUID des Energieschemas: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c  (Höchstleistung)
GUID des Energieschemas: a1841308-3541-4fab-bc81-f71556f20b4a  (Energiesparmodus)
```

After that edit the configuration lines of the script:
``` lua
-- GUIDs for powercfg tool, get GUIDs for you system with cmd or powershell: powercfg /L
-- Balanced GUID, e.g. "381b4222-f694-41f0-9685-ff5bb260df2e"
local balancedGUID = "<insert blanced GUID here>"

-- High Performance GUID, e.g. "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
local highPerformanceGUID = "<insert high performance GUID here>"
```

Save and restart you DCS server. Now this script is active.

## Remarks
- Please make sure your energy plans are set correctly.
- If this hook is loaded properly you can look into the dcs.log file and search for the lines with `[EnergyManagement]`.
- The server admin user (that connects by default) is ignored.

### Log-examples
``` log
2022-08-09 18:48:08.272 INFO    LuaNET: [EnergyManagement] Loaded and ready!
2022-08-09 18:48:08.673 INFO    LuaNET: [EnergyManagement] Admin connected, total clients 1
2022-08-09 18:48:08.673 INFO    LuaNET: [EnergyManagement] No players connected - setting to energy saving / balanced

2022-08-09 18:48:51.917 INFO    LuaNET: [EnergyManagement] Sword 1-4 | Yokas connected, total clients 2
2022-08-09 18:48:51.918 INFO    LuaNET: [EnergyManagement] Player connected - setting to high performance

2022-08-09 18:49:55.550 INFO    LuaNET: [EnergyManagement] Player disconnected, total clients 1
2022-08-09 18:49:55.550 INFO    LuaNET: [EnergyManagement] No players connected - setting to energy saving / balanced
```

## GitHub
You will find this hook / script in the newest version over at [GitHub](https://github.com/Ayokas/DCS-Energy-Management).