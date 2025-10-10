local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Remove any existing GUI
if LocalPlayer.PlayerGui:FindFirstChild("PerformanceHubUI") then
    LocalPlayer.PlayerGui.PerformanceHubUI:Destroy()
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PerformanceHubUI"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false

local HubFrame = Instance.new("Frame")
HubFrame.Size = UDim2.new(0, 240, 0, 125)
HubFrame.Position = UDim2.new(0.5, -120, 0.5, -62)
HubFrame.BackgroundColor3 = Color3.fromRGB(245, 250, 255)
HubFrame.BorderColor3 = Color3.fromRGB(80, 180, 255)
HubFrame.BorderSizePixel = 3
HubFrame.AnchorPoint = Vector2.new(0.5, 0.5)
HubFrame.Parent = ScreenGui
HubFrame.Active = true
HubFrame.Draggable = true

-- Rainbow Text Function
local function updateRainbowText(textObj, speed)
    local t = 0
    RunService.RenderStepped:Connect(function()
        t = t + speed
        local r = math.abs(math.sin(t)) * 0.7
        local g = math.abs(math.sin(t + 2)) * 0.7
        local b = math.abs(math.sin(t + 4)) * 0.7
        textObj.TextColor3 = Color3.new(r, g, b)
    end)
end

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "PERFORMANCE HUB"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = HubFrame
updateRainbowText(Title, 1.2)

-- Turbo Button
local TurboBtn = Instance.new("TextButton")
TurboBtn.Size = UDim2.new(0.7, 0, 0, 38)
TurboBtn.Position = UDim2.new(0.15, 0, 0, 50)
TurboBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
TurboBtn.BorderColor3 = Color3.fromRGB(80, 180, 255)
TurboBtn.BorderSizePixel = 2
TurboBtn.Text = "🚀 Reduce Lag"
TurboBtn.Font = Enum.Font.GothamBold
TurboBtn.TextScaled = true
TurboBtn.Parent = HubFrame
updateRainbowText(TurboBtn, 2)

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, -20, 0, 16)
Credit.Position = UDim2.new(0, 10, 1, -22)
Credit.BackgroundTransparency = 1
Credit.Text = "By: Gonzales Official"
Credit.Font = Enum.Font.GothamSemibold
Credit.TextScaled = true
Credit.Parent = HubFrame
Credit.TextStrokeTransparency = 0.6
updateRainbowText(Credit, 3)

-- Lag Reduction Function
local function setLagReduction(state)
    Lighting.Brightness = state and 2 or 1
    Lighting.ColorShift_Bottom = state and Color3.fromRGB(60,60,60) or Color3.fromRGB(0,0,0)
    Lighting.ColorShift_Top = state and Color3.fromRGB(60,60,60) or Color3.fromRGB(0,0,0)
    Lighting.ShadowSoftness = state and 0 or 0.5
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = not state
        end
    end
    if state then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Network.IncomingReplicationLag = 0
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        settings().Network.IncomingReplicationLag = 0
    end
end

-- Button Behavior
local lagActive = false
TurboBtn.MouseButton1Click:Connect(function()
    TurboBtn.Text = "Please Wait..."
    TurboBtn.AutoButtonColor = false
    TurboBtn.Active = false
    wait(2)
    if not lagActive then
        TurboBtn.Text = "✓ Lag Reduction On"
        lagActive = true
        setLagReduction(true)
        TurboBtn.Active = true
        TurboBtn.AutoButtonColor = true
    else
        TurboBtn.Text = "Lag Reduction Off"
        setLagReduction(false)
        wait(2)
        lagActive = false
        TurboBtn.Text = "🚀 Reduce Lag"
        TurboBtn.Active = true
        TurboBtn.AutoButtonColor = true
    end
end)

setLagReduction(false)
