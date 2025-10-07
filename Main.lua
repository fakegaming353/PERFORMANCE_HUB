--// Night Hub | One-Button FPS Booster
--// Made by: Gonzales Official

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local BoostButton = Instance.new("TextButton")
local Credit = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Name = "NightHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 230, 0, 120)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame
UIStroke.Parent = Frame
UIStroke.Thickness = 2

-- Rainbow border animation
task.spawn(function()
	while task.wait() do
		for hue = 0, 255 do
			UIStroke.Color = Color3.fromHSV(hue / 255, 1, 1)
			task.wait(0.02)
		end
	end
end)

-- Boost FPS Button
BoostButton.Name = "BoostButton"
BoostButton.Parent = Frame
BoostButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BoostButton.BorderSizePixel = 0
BoostButton.Position = UDim2.new(0.1, 0, 0.25, 0)
BoostButton.Size = UDim2.new(0.8, 0, 0.4, 0)
BoostButton.Font = Enum.Font.GothamBold
BoostButton.Text = "Boost FPS"
BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BoostButton.TextSize = 20
BoostButton.AutoButtonColor = false
UICorner:Clone().Parent = BoostButton

-- Hover rainbow text animation
BoostButton.MouseEnter:Connect(function()
	task.spawn(function()
		for hue = 0, 255 do
			if not BoostButton:IsDescendantOf(game) then break end
			BoostButton.TextColor3 = Color3.fromHSV(hue / 255, 1, 1)
			task.wait(0.02)
		end
	end)
end)

BoostButton.MouseLeave:Connect(function()
	BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- Credit Label
Credit.Name = "Credit"
Credit.Parent = Frame
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0, 0, 0.72, 0)
Credit.Size = UDim2.new(1, 0, 0.25, 0)
Credit.Font = Enum.Font.Gotham
Credit.Text = "By: Gonzales Official"
Credit.TextColor3 = Color3.fromRGB(180, 180, 180)
Credit.TextSize = 12
Credit.TextWrapped = true

-- Function: Boost FPS & Reduce Lag
BoostButton.MouseButton1Click:Connect(function()
	-- Remove textures and decals
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
	end

	-- Lower graphics
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 9e9
	game.Lighting.Brightness = 1
	game.Lighting.Technology = Enum.Technology.Compatibility

	-- Remove particles, fire, smoke, trails
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
			v:Destroy()
		end
	end

	-- Clear accessories for all players
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.Character then
			for _, item in pairs(plr.Character:GetChildren()) do
				if item:IsA("Accessory") then item:Destroy() end
			end
		end
	end

	-- Cleanup and optimize memory
	game:GetService("Debris"):ClearAllChildren()
	collectgarbage("collect")
	settings().Network.IncomingReplicationLag = 0

	-- Button feedback
	BoostButton.Text = "✅ Boosted!"
	task.wait(2)
	BoostButton.Text = "Boost FPS"
end)
