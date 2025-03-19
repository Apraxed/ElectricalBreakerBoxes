-- !MODULESCRIPT

local TweenService = game:GetService("TweenService")

return function (box:Instance, key:string)
	local Door = box.door
	local DoorProxPrompt:ProximityPrompt = Door.DoorProxPrompt
	local UnlockProxPrompt:ProximityPrompt = Door.UnlockProxPrompt
	local PowerCutPrompt:ProximityPrompt = box.PowerCut.ProximityPrompt	

	local Hinge = box.Hinge

	local ClosedCFrame = box.Hinge.CFrame
	local IsOpened = false
	local Locked = true
	local PlayingAnimation = false
	local test = false
	
	local function lock()
		if Locked == false and test == true then 
			DoorProxPrompt.Enabled = false
			UnlockProxPrompt.Enabled = true
			Locked = true
			test = false
		end
	end

	UnlockProxPrompt.Triggered:Connect(function(plr)
		if plr.Lockboxes:FindFirstChild(key).Value == true and Locked == true then
			Locked = false
			test = true
			UnlockProxPrompt.Enabled = false
			DoorProxPrompt.Enabled = true
			task.wait(240)
			if IsOpened then
				TweenService:Create(Hinge,TweenInfo.new(1),{CFrame = ClosedCFrame}):Play()
			end
			lock()
		else
			return
		end
	end)

	-- Door Function
	Door.Transparency = 0

	DoorProxPrompt.Triggered:Connect(function(plr)
		if PlayingAnimation then return end
		PlayingAnimation = true
		DoorProxPrompt.Enabled = false
		if IsOpened then
			PowerCutPrompt.Enabled = false
			DoorProxPrompt.HoldDuration = 5
			TweenService:Create(Hinge,TweenInfo.new(1),{CFrame = ClosedCFrame}):Play()
			IsOpened = false
			task.wait(1)
			lock()
		else
			UnlockProxPrompt.Enabled = false
			PowerCutPrompt.Enabled = true
			DoorProxPrompt.HoldDuration = 0.5
			TweenService:Create(Hinge,TweenInfo.new(1),{CFrame = ClosedCFrame * CFrame.Angles(math.rad(-90),0,0)}):Play()
			IsOpened = true
			task.wait(1)
			DoorProxPrompt.Enabled = true
		end
		PlayingAnimation = false
	end)
end