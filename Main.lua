-- REDZ HUB (REDUSE LAG) - Universal Lag Reducer GUI for Roblox Executors
-- Features: Draggable, big buttons, all functions work, "X" to close, "-" to minimize
-- Enter "555" (type '5' three times) to unlock and show all button functions

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "REDZHUB_LagReducerGUI"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 540)
frame.Position = UDim2.new(0.5, -210, 0.4, -270)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "REDZ HUB (REDUSE LAG)"
title.Size = UDim2.new(1, -80, 0, 60)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 34

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 50, 0, 50)
closeBtn.Position = UDim2.new(1, -50, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 32
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local minBtn = Instance.new("TextButton", frame)
minBtn.Text = "-"
minBtn.Size = UDim2.new(0, 50, 0, 50)
minBtn.Position = UDim2.new(1, -100, 0, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 32

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, v in ipairs(frame:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("TextLabel") then
            if v ~= minBtn and v ~= closeBtn and v ~= title then
                v.Visible = not minimized
            end
        end
    end
    frame.Size = minimized and UDim2.new(0, 420, 0, 60) or UDim2.new(0, 420, 0, 540)
end)

local buttons = {
    {Name = "Remove Lag", Action = function()
        settings().RenderingQualityLevel = Enum.QualityLevel.Level01
    end},
    {Name = "Clear Lag", Action = function()
        pcall(function()
            if workspace:FindFirstChild("Debris") then
                for _, obj in ipairs(workspace.Debris:GetChildren()) do
                    obj:Destroy()
                end
            end
        end)
    end},
    {Name = "Lag Destroyer", Action = function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Explosion") or obj:IsA("Smoke") or obj:IsA("Fire") then
                obj:Destroy()
            end
        end
    end},
    {Name = "Boost FPS", Action = function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end
    end},
    {Name = "Optimize Game", Action = function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
    end},
    {Name = "Turbo Mode", Action = function()
        settings().RenderingQualityLevel = Enum.QualityLevel.Level00
    end},
    {Name = "Performance Boost", Action = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then
                obj.Enabled = false
            end
        end
    end},
    {Name = "Clean Map", Action = function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Trash" or obj.Name == "Debris" then
                obj:Destroy()
            end
        end
    end},
    {Name = "Disable Effects", Action = function()
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") then
                obj.Enabled = false
            end
        end
    end},
    {Name = "Lag Cleaner", Action = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Smoke") or obj:IsA("Fire") then
                obj:Destroy()
            end
        end
    end},
}

-- Create buttons but keep them locked (hidden) until "555" is entered
local buttonObjects = {}

for i, btn in ipairs(buttons) do
    local button = Instance.new("TextButton", frame)
    button.Text = btn.Name
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, 70 + (i-1)*46)
    button.BackgroundColor3 = Color3.fromRGB(50, 170, 50)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 24
    button.Visible = false -- locked by default
    button.MouseButton1Click:Connect(btn.Action)
    buttonObjects[i] = button
end

-- Listen for "555" key sequence, then unlock all buttons automatically
local keySeq = {}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        table.insert(keySeq, input.KeyCode)
        if #keySeq > 3 then
            table.remove(keySeq, 1)
        end
        if keySeq[1] == Enum.KeyCode.Five and keySeq[2] == Enum.KeyCode.Five and keySeq[3] == Enum.KeyCode.Five then
            for _, button in ipairs(buttonObjects) do
                button.Visible = true
            end
        end
    end
end)

-- Tab is always enabled unless closed
gui.Enabled = true
frame.Visible = true
