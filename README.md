# ElectricalBreakerBoxes

## Overview

The **PowerService** system manages electrical breaker boxes and controls power states in Roblox Studio. It includes functionality for locking/unlocking doors, cutting power, and toggling light states based on building codes and player interactions.



**If you are going to use PowerService, please download the** [Roblox Model](https://create.roblox.com/store/asset/87794851304341/ElectricalBreakerBoxes). **This github repo is purely for viewing the code.**

---

## Directory Structure

```
ElectricalBreakerBoxes
├── Workspace
│   └── PowerBoxes
│       └── Box1
│           ├── PowerCut
│           │   └── ProximityPrompt
│           └── door
│               ├── DoorProxPrompt
│               └── UnlockProxPrompt
├── ReplicatedStorage
│   └── PowerBoxFolders
│       └── Electrical
│           └── Box1
├── ServerScriptService
│   ├── PowerBoxScripts
│   │   ├── Box1Power
│   │   └── Box1Door
│   ├── PowerService
│   │   ├── Door
│   │   ├── HDAdminBypass
│   │   └── Power
│   └── KeyCreator

```

---

## Script Descriptions

### `Door`

- **Purpose:** Controls the door animation and locking mechanism.
- **Key Variables:**
  - `IsOpened`: Tracks whether the door is opened.
  - `Locked`: Indicates if the door is locked.
  - `PlayingAnimation`: Prevents animation overlap.
- **Functions:**
  - `lock()`: Re-locks the door after a delay.
  - `UnlockProxPrompt.Triggered`: Unlocks the door if the player has the correct key.
  - `DoorProxPrompt.Triggered`: Opens or closes the door with animation.

### `Power`

- **Purpose:** Controls power toggling for lights based on the building code.
- **Key Variables:**
  - `GV`: References `GlobalVariables` in ReplicatedStorage.
  - `Elec`: Electrical variables.
  - `BuildingVar`: The building’s power state.
- **Behavior:**
  - If power is ON, lights are enabled and material is set to `Neon`.
  - If power is OFF, lights are disabled and material is set to `SmoothPlastic`.

### `KeyCreator`

- **Purpose:** Creates lockbox folders and keys for players.
- **Behavior:**
  - Adds a `Lockboxes` folder to the player.
  - Creates `Box1Key` as a `BoolValue` with a default value of `false`.

### `HDAdminBypass`

- **Purpose:** Allows administrators to control power bypassing player restrictions.
- **Behavior:**
  - Checks for the existence of building code in `GlobalVariables`.
  - Retrieves folders associated with the building code.
  - Calls the `Power` function with the appropriate parameters.

---

## Usage Instructions

1. **Setup:**
   - Place contents of base folders in their services, all labeled for your convenience.
   - The `PowerBoxes` instances should contain `PowerCut` and `door` with proper proximity prompts. An example power box has been included.
2. **Interacting with Doors:**
   - Players with the correct key can unlock the door. Keys are just `BoolValue`s in a folder under the player, created by `KeyCreator.lua`
   - Doors animate to open and close when prompted.
3. **Power Control:**
   - Custom commands for Admin Systems can be created using `HDAdminBypass`. Originally for HDAdmin, I will include the HD Admin command below so you can figure out how to make it work with your Admin System.
   - Lights switch between `Neon` (on) and `SmoothPlastic` (off).

---

## Variables and Parameters

### `Door Script`

- `box`: The box instance containing the door and PowerCut.
- `key`: The key name used to verify access.

### `Power Script`

- `plr`: The player instance. Gotten from the ProximityPrompt.
- `folder1`: The first light folder.
- `folder2`: The second light folder (optional).
- `buildingCode`: The building’s code for identifying power state.

## Additional Scripts

### `Box1Power`

- **Purpose:** Retrieves the lighting folders linked to the power box and sets the `BuildingCode`.
- **Key Variables:**
  - `BuildingCode`: The name of the power box (e.g., `Box1`).
  - `ProxPrompt`: References the proximity prompt in the power box.
  - `LightingFolder`: Stores the first lighting folder.
  - `LightingFolder2`: Stores the second lighting folder (if it exists).
- **Functionality:**
  - Uses `GetFolders()` to fetch the lighting folders from `ReplicatedStorage.PowerBoxFolders`.

```lua
local BuildingCode = "Box1"
local ProxPrompt = workspace.PowerBoxes:FindFirstChild(BuildingCode).PowerCut.ProximityPrompt
local LightingFolder = Instance
local LightingFolder2 = Instance
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function GetFolders(bCode)
	local folder = ReplicatedStorage.PowerBoxFolders:FindFirstChild(BuildingCode)
	LightingFolder = folder.folder1.Value
	if folder.folder2 == nil then 
		LightingFolder2 = nil
	else
		LightingFolder2	= folder.folder2
	end
end

ProxPrompt.Triggered:Connect(function(plr)
	require(game.ServerScriptService.PowerService.Power)(plr, LightingFolder, LightingFolder2, BuildingCode)
end)
```

### `Box1Door`

- **Purpose:** Triggers the power control functionality and connects to the door script.
- **Key Variables:**
  - `BuildingCode`: The name of the power box (e.g., `Box1`).
  - `box`: References the door instance.
- **Functionality:**
  - Listens for proximity prompt triggers.
  - Calls the `Power` function with relevant parameters.
  - Requires the `Door` script to handle the door's animation.

```lua
local BuildingCode = "Box1"
local box = workspace.PowerBoxes:WaitForChild(BuildingCode) 
local DoorFunction = require(game:GetService("ServerScriptService"):FindFirstChild("PowerService").Door)

DoorFunction(box, BuildingCode)
```

## HD Admin Command -- Can be made to work with other admin systems

```lua
{
	Name = "togglePower";
	Aliases = {"togpower", "power"};
	Prefixes = {settings.Prefix};
	Rank = 2;
	RankLock = true;
	Loopable = false;
	Tags = {"Power"};
	Description = "Toggle power on a building. SPELLING AND CAPITALIZATION MATTERS";
	Contributors = {"ApraxCraftz"};
	--
	Args = {"Code"}; -- Code is just string, but it bypasses the Roblox filter
	Function = function(speaker:Player, args)
		local func = game:GetService("ServerScriptService"):FindFirstChild("PowerService"):FindFirstChild("HDAdminBypass")
		require(func)(speaker, args[1])
	end;
};
```