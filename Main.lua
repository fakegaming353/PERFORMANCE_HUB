-- Night Hub | FPS Booster + Bug Report
-- Made by: Gonzales Official

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NightHub"

--------------------------------------------------------------------
-- Frame
--------------------------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 3

-- Rainbow border animation
task.spawn(function()
	while task.wait() do
		for h = 0, 255 do
			stroke.Color = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

--------------------------------------------------------------------
-- Boost FPS Button
--------------------------------------------------------------------
local boostBtn = Instance.new("TextButton", frame)
boostBtn.Size = UDim2.new(0.6,0,0.35,0)
boostBtn.Position = UDim2.new(0.2,0,0.15,0)
boostBtn.Text = "Boost FPS"
boostBtn.Font = Enum.Font.GothamBold
boostBtn.TextSize = 20
boostBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
boostBtn.TextColor3 = Color3.new(1,1,1)
boostBtn.AutoButtonColor = false
Instance.new("UICorner", boostBtn)

-- Hover rainbow text animation
boostBtn.MouseEnter:Connect(function()
	task.spawn(function()
		for h=0,255 do
			if not boostBtn:IsDescendantOf(game) then break end
			boostBtn.TextColor3 = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end)
end)
boostBtn.MouseLeave:Connect(function()
	boostBtn.TextColor3 = Color3.new(1,1,1)
end)

-- Boost FPS function with 2s delay
boostBtn.MouseButton1Click:Connect(function()
	boostBtn.Text = "Processing..."
	task.wait(2)
	-- Remove decals and textures
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
	end
	-- Remove grass colors
	if workspace:FindFirstChild("Terrain") then
		workspace.Terrain.WaterWaveSize = 0
		workspace.Terrain.WaterWaveSpeed = 0
		workspace.Terrain.WaterReflectance = 0
		workspace.Terrain.WaterTransparency = 1
		workspace.Terrain:SetMaterialColor(Enum.Material.Grass, Color3.new(0.5,0.5,0.5))
	end
	-- Lighting cleanup
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 1e6
	game.Lighting.Brightness = 1
	game.Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
	game.Lighting.Technology = Enum.Technology.Compatibility
	-- Remove heavy particles
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
			v:Destroy()
		end
	end
	boostBtn.Text = "✅ Boosted!"
	task.wait(2)
	boostBtn.Text = "Boost FPS"
end)

--------------------------------------------------------------------
-- Report Bug Button
--------------------------------------------------------------------
local reportBtn = Instance.new("TextButton", frame)
reportBtn.Size = UDim2.new(0.6,0,0.25,0)
reportBtn.Position = UDim2.new(0.2,0,0.65,0)
reportBtn.Text = "Report Bug"
reportBtn.Font = Enum.Font.GothamBold
reportBtn.TextSize = 18
reportBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
reportBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", reportBtn)

-- Hover rainbow text animation
reportBtn.MouseEnter:Connect(function()
	task.spawn(function()
		for h=0,255 do
			if not reportBtn:IsDescendantOf(game) then break end
			reportBtn.TextColor3 = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end)
end)
reportBtn.MouseLeave:Connect(function()
	reportBtn.TextColor3 = Color3.new(1,1,1)
end)

-- Open Discord link
reportBtn.MouseButton1Click:Connect(function()
	local success, result = pcall(function()
		return game:GetService("Players").LocalPlayer:Kick("Opening Discord: https://discord.gg/v65zvUw2xk")
	end)
end)

--------------------------------------------------------------------
-- Rainbow Name Label
--------------------------------------------------------------------
local credit = Instance.new("TextLabel", frame)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(0,0,0.92,0)
credit.Size = UDim2.new(1,0,0.08,0)
credit.Font = Enum.Font.GothamBold
credit.Text = "By: Gonzales Official"
credit.TextSize = 14
credit.TextColor3 = Color3.fromHSV(0,1,1)

-- Rainbow animation for name
task.spawn(function()
	while task.wait() do
		for h = 0,255 do
			credit.TextColor3 = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

--------------------------------------------------------------------
-- FPS Counter (top-right)
--------------------------------------------------------------------
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0,150,0,40)
fpsLabel.Position = UDim2.new(0.85,0,0.05,0)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.BackgroundColor3 = Color3.fromRGB(15,15,15)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextScaled = true
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.new(1,1,1)
local fpsStroke = Instance.new("UIStroke", fpsLabel)
fpsStroke.Thickness = 2

-- Rainbow FPS + real count
local last, frames, fps = tick(), 0, 0
task.spawn(function()
	while task.wait(0.03) do
		for h = 0,255 do
			local c = Color3.fromHSV(h/255,1,1)
			fpsLabel.TextColor3 = c
			fpsStroke.Color = c
			task.wait(0.02)
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	frames += 1
	local now = tick()
	if now - last >= 1 then
		fps = frames / (now - last)
		last, frames = now, 0
		fpsLabel.Text = string.format("FPS: %.0f", fps)
	end
end)
