-- !SCRIPT

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