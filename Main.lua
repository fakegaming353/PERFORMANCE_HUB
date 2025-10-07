-- Night Hub | Robust Version (Safe & Future-Proof)
-- By: Gonzales Official

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NightHub"

--------------------------------------------------
-- Compact Frame
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 120) -- small UI
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2

-- Rainbow border
task.spawn(function()
	while task.wait() do
		for h = 0, 255 do
			stroke.Color = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

--------------------------------------------------
-- Boost Fps Button (Flat / Minimal)
--------------------------------------------------
local boostBtn = Instance.new("TextButton", frame)
boostBtn.Size = UDim2.new(0.8,0,0.25,0)
boostBtn.Position = UDim2.new(0.1,0,0.1,0)
boostBtn.Text = "Boost Fps"
boostBtn.Font = Enum.Font.GothamBold
boostBtn.TextSize = 16
boostBtn.BackgroundColor3 = Color3.fromRGB(60,60,60) -- flat grey
boostBtn.TextColor3 = Color3.fromRGB(255,255,255)
boostBtn.AutoButtonColor = false
Instance.new("UICorner", boostBtn)

-- Recommended Phone label (like Blox Fruits)
local recLabel = Instance.new("TextLabel", frame)
recLabel.Size = UDim2.new(0.8,0,0.1,0)
recLabel.Position = UDim2.new(0.1,0,0.36,0)
recLabel.BackgroundTransparency = 1
recLabel.Text = "Recommended Phone"
recLabel.Font = Enum.Font.Gotham
recLabel.TextSize = 12
recLabel.TextColor3 = Color3.fromRGB(200,200,200)

-- Boost Fps function (official APIs only)
boostBtn.MouseButton1Click:Connect(function()
	boostBtn.Text = "Processing..."
	task.wait(2)
	-- Remove decals & textures
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
	end
	-- Remove grass
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
	-- Remove particles
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
			v:Destroy()
		end
	end
	boostBtn.Text = "✅ Boosted!"
	task.wait(2)
	boostBtn.Text = "Boost Fps"
end)

--------------------------------------------------
-- Report Bug Button (auto-copy Discord)
--------------------------------------------------
local reportBtn = Instance.new("TextButton", frame)
reportBtn.Size = UDim2.new(0.8,0,0.25,0)
reportBtn.Position = UDim2.new(0.1,0,0.55,0)
reportBtn.Text = "Report Bug"
reportBtn.Font = Enum.Font.GothamBold
reportBtn.TextSize = 14
reportBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
reportBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", reportBtn)

local discordLink = "https://discord.gg/v65zvUw2xk"
reportBtn.MouseButton1Click:Connect(function()
	pcall(function()
		setclipboard(discordLink)
		reportBtn.Text = "Copied!"
		task.wait(2)
		reportBtn.Text = "Report Bug"
	end)
end)

--------------------------------------------------
-- Rainbow Name
--------------------------------------------------
local credit = Instance.new("TextLabel", frame)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(0,0,0.85,0)
credit.Size = UDim2.new(1,0,0.1,0)
credit.Font = Enum.Font.GothamBold
credit.Text = "By: Gonzales Official"
credit.TextSize = 12
task.spawn(function()
	while task.wait() do
		for h = 0,255 do
			credit.TextColor3 = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

--------------------------------------------------
-- Small FPS Counter (optional)
--------------------------------------------------
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0,60,0,15)
fpsLabel.Position = UDim2.new(0.47,0,0.05,0)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.BackgroundColor3 = Color3.fromRGB(15,15,15)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 12
fpsLabel.Text = "FPS: 0"
local fpsStroke = Instance.new("UIStroke", fpsLabel)
fpsStroke.Thickness = 1

local last, frames, fps = tick(),0,0
game:GetService("RunService").RenderStepped:Connect(function()
	frames += 1
	local now = tick()
	if now - last >= 1 then
		fps = frames / (now - last)
		last, frames = now, 0
		fpsLabel.Text = string.format("FPS: %.0f", fps)
	end
end)
