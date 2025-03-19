-- !MODULESCRIPT

return function (plr:Player?, folder1:Folder, folder2:Folder?, buildingCode:string)
	local Elec = game:GetService("ReplicatedStorage"):FindFirstChild("Electrical")
	local BuildingVar = Elec:FindFirstChild(buildingCode)
	local lightsfolder = folder1
	local lightsfolder2 = folder2
	if Elec[buildingCode] == nil then error("Building code not found") end
	if BuildingVar.Value == true then
		for i, r in pairs(lightsfolder:GetDescendants()) do
			if r:IsA("SurfaceLight") or r:IsA("PointLight") or r:IsA("SpotLight") then
				r.Enabled = false
				r.Parent.Material = Enum.Material.SmoothPlastic
			end
		end
		if lightsfolder2 ~= nil then
			for i, r in pairs(lightsfolder2:GetDescendants()) do
				if r:IsA("SurfaceLight") or r:IsA("PointLight") or r:IsA("SpotLight") then
					r.Enabled = false
					r.Parent.Material = Enum.Material.SmoothPlastic
				end
			end
		else
			return
		end
	elseif BuildingVar.Value == false then
		for i, r in pairs(lightsfolder:GetDescendants()) do
			if r:IsA("SurfaceLight") or r:IsA("PointLight") or r:IsA("SpotLight") then
				r.Enabled = true
				r.Parent.Material = Enum.Material.Neon
			end
		end
		if lightsfolder2 ~= nil then
			for i, r in pairs(lightsfolder2:GetDescendants()) do
				if r:IsA("SurfaceLight") or r:IsA("PointLight") or r:IsA("SpotLight") then
					r.Enabled = true
					r.Parent.Material = Enum.Material.Neon
				end
			end
		else 
			return
		end
	else
		return
	end
end