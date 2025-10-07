-- Night Hub | Key & Button HUD
-- By: Gonzales Official

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NightHub"

--------------------------------------------------
-- First UI: Key Input
--------------------------------------------------
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 200, 0, 100)
keyFrame.Position = UDim2.new(0.5, -100, 0.5, -50) -- center of screen
keyFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
keyFrame.Active = true
keyFrame.Draggable = true

local keyCorner = Instance.new("UICorner", keyFrame)
local keyStroke = Instance.new("UIStroke", keyFrame)
keyStroke.Thickness = 2

-- Rainbow border
task.spawn(function()
	while task.wait() do
		for h = 0,255 do
			keyStroke.Color = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(0.8,0,0.3,0)
keyLabel.Position = UDim2.new(0.1,0,0.1,0)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Enter Key:"
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextSize = 16
keyLabel.TextScaled = true
keyLabel.TextXAlignment = Enum.TextXAlignment.Center
keyLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Rainbow text
task.spawn(function()
	while task.wait() do
		for h = 0,255 do
			keyLabel.TextColor3 = Color3.fromHSV(h/255,1,1)
			task.wait(0.02)
		end
	end
end)

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8,0,0.3,0)
keyBox.Position = UDim2.new(0.1,0,0.45,0)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 14
keyBox.TextScaled = true
keyBox.TextXAlignment = Enum.TextXAlignment.Center
keyBox.TextYAlignment = Enum.TextYAlignment.Center
keyBox.ClearTextOnFocus = true
Instance.new("UICorner", keyBox)

local unlockBtn = Instance.new("TextButton", keyFrame)
unlockBtn.Size = UDim2.new(0.8,0,0.2,0)
unlockBtn.Position = UDim2.new(0.1,0,0.75,0)
unlockBtn.Text = "Unlock"
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 14
unlockBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
unlockBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", unlockBtn)

--------------------------------------------------
-- Second UI: Button HUD (Hidden initially)
--------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 160, 0, 120)
frame.Position = UDim2.new(0.02, 0, 0.02, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true
frame.Visible = false

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

-- Boost Fps Button
local boostBtn = Instance.new("TextButton", frame)
boostBtn.Size = UDim2.new(0.8,0,0.15,0)
boostBtn.Position = UDim2.new(0.1,0,0.1,0)
boostBtn.Text = "Boost Fps"
boostBtn.Font = Enum.Font.GothamBold
boostBtn.TextSize = 14
boostBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
boostBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", boostBtn)

-- Recommended For Mobile label
local recLabel = Instance.new("TextLabel", frame)
recLabel.Size = UDim2.new(0.8,0,0.1,0)
recLabel.Position = UDim2.new(0.1,0,0.35,0)
recLabel.BackgroundTransparency = 1
recLabel.Text = "Recommended For Mobile"
recLabel.Font = Enum.Font.Gotham
recLabel.TextSize = 10
recLabel.TextColor3 = Color3.fromRGB(200,200,200)
recLabel.TextScaled = true
recLabel.TextXAlignment = Enum.TextXAlignment.Center
recLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Report Bug Button
local reportBtn = Instance.new("TextButton", frame)
reportBtn.Size = UDim2.new(0.8,0,0.15,0)
reportBtn.Position = UDim2.new(0.1,0,0.55,0)
reportBtn.Text = "Report Bug"
reportBtn.Font = Enum.Font.GothamBold
reportBtn.TextSize = 12
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

-- Boost FPS functionality
boostBtn.MouseButton1Click:Connect(function()
	boostBtn.Text = "Processing..."
	task.wait(2)
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
	end
	if workspace:FindFirstChild("Terrain") then
		workspace.Terrain.WaterWaveSize = 0
		workspace.Terrain.WaterWaveSpeed = 0
		workspace.Terrain.WaterReflectance = 0
		workspace.Terrain.WaterTransparency = 1
		workspace.Terrain:SetMaterialColor(Enum.Material.Grass, Color3.new(0.5,0.5,0.5))
	end
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 1e6
	game.Lighting.Brightness = 1
	game.Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
	game.Lighting.Technology = Enum.Technology.Compatibility
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
-- Unlock Button Logic
--------------------------------------------------
unlockBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == "555" then
		keyFrame:Destroy() -- remove key input UI
		frame.Visible = true -- show second UI
	else
		unlockBtn.Text = "❌ Wrong Key"
		task.wait(2)
		unlockBtn.Text = "Unlock"
	end
end)
