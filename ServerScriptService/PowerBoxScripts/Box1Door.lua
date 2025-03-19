-- !SCRIPT

local BuildingCode = "Box1"

local box = workspace.PowerBoxes:WaitForChild(BuildingCode)

local DoorFunction = require(game:GetService("ServerScriptService"):FindFirstChild("PowerService").Door)

DoorFunction(box, "Box1")