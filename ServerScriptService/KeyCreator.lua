-- !SCRIPT

game.Players.PlayerAdded:Connect(function(plr)
	-- Lockboxes
	local lockboxes = Instance.new("Folder")
	lockboxes.Name = "Lockboxes"
	lockboxes.Parent = plr

	local Box1Key = Instance.new("BoolValue")
	Box1Key.Name = "Box1"
	Box1Key.Value = false
	Box1Key.Parent = lockboxes
end)