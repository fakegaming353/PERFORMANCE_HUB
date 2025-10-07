{
    -- Night Hub FPS Boost UI by Gonzales Official

    -- Draggable function (drag anywhere on MainFrame)
    local function makeDraggable(frame)
        local UIS = game:GetService("UserInputService")
        local dragging, dragInput, dragStart, startPos

        local function update(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)
    end

    -- Main UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "NightHubFPS"

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -160, 0.35, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    makeDraggable(MainFrame)

    -- Top Bar
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1,0,0,32)
    TopBar.BackgroundColor3 = Color3.fromRGB(35,35,55)
    TopBar.BorderSizePixel = 0

    -- Title
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -64, 1, 0)
    Title.Position = UDim2.new(0,0,0,0)
    Title.Text = "Night Hub - Boost FPS"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(220,220,255)
    Title.BackgroundTransparency = 1

    -- X Button
    local XBtn = Instance.new("TextButton", TopBar)
    XBtn.Size = UDim2.new(0,32, 1, 0)
    XBtn.Position = UDim2.new(1,-32,0,0)
    XBtn.Text = "X"
    XBtn.Font = Enum.Font.SourceSansBold
    XBtn.TextSize = 24
    XBtn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    XBtn.TextColor3 = Color3.new(1,1,1)
    XBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Minimize Button
    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.new(0,32,1,0)
    MinBtn.Position = UDim2.new(1,-64,0,0)
    MinBtn.Text = "-"
    MinBtn.Font = Enum.Font.SourceSansBold
    MinBtn.TextSize = 24
    MinBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
    MinBtn.TextColor3 = Color3.new(1,1,1)

    -- Main Area
    local MainArea = Instance.new("Frame", MainFrame)
    MainArea.Size = UDim2.new(1,-24,1,-72)
    MainArea.Position = UDim2.new(0,12,0,44)
    MainArea.BackgroundTransparency = 1

    -- Signature
    local Signature = Instance.new("TextLabel", MainFrame)
    Signature.Size = UDim2.new(1,0,0,28)
    Signature.Position = UDim2.new(0,0,1,-28)
    Signature.Text = "By: Gonzales Official"
    Signature.Font = Enum.Font.SourceSans
    Signature.TextSize = 18
    Signature.TextColor3 = Color3.fromRGB(180,180,180)
    Signature.BackgroundTransparency = 1

    -- Hide/Show functionality
    local isHidden = false
    MinBtn.MouseButton1Click:Connect(function()
        isHidden = not isHidden
        MainArea.Visible = not isHidden
        Signature.Visible = not isHidden
        if isHidden then
            MinBtn.Text = "+"
        else
            MinBtn.Text = "-"
        end
    end)

    -- FPS Counter
    local FPSLabel = Instance.new("TextLabel", MainArea)
    FPSLabel.Size = UDim2.new(1,0,0,28)
    FPSLabel.Position = UDim2.new(0,0,0,0)
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Font = Enum.Font.SourceSansBold
    FPSLabel.TextSize = 20
    FPSLabel.TextColor3 = Color3.fromRGB(200,255,200)
    FPSLabel.Text = "FPS: ..."

    -- FPS Calculation
    local RunService = game:GetService("RunService")
    local frames, lastTime = 0, tick()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastTime >= 1 then
            FPSLabel.Text = "FPS: "..frames
            frames = 0
            lastTime = tick()
        end
    end)

    -- Boost FPS Function (all 4 in one)
    local function boostFPS()
        -- 1. Disable shadows & simple lighting
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.fromRGB(128,128,128)
        lighting.Brightness = 1
        lighting.FogEnd = 10000

        -- 2. Remove grass & set terrain to gray
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.GrassThickness = 0
            terrain.MaterialColors = {
                [Enum.Material.Grass] = Color3.fromRGB(128,128,128),
                [Enum.Material.Ground] = Color3.fromRGB(128,128,128),
                [Enum.Material.Mud] = Color3.fromRGB(128,128,128),
            }
        end

        -- 3. Remove textures/decals & set material to SmoothPlastic
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end

        -- 4. Disable particle effects (ParticleEmitter, Trail, Smoke, Fire)
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
    end

    -- Main Button
    local BoostBtn = Instance.new("TextButton", MainArea)
    BoostBtn.Size = UDim2.new(1,0,0,50)
    BoostBtn.Position = UDim2.new(0,0,0,32)
    BoostBtn.Text = "Boost FPS"
    BoostBtn.Font = Enum.Font.SourceSansBold
    BoostBtn.TextSize = 28
    BoostBtn.BackgroundColor3 = Color3.fromRGB(50,50,80)
    BoostBtn.TextColor3 = Color3.new(1,1,1)
    BoostBtn.MouseButton1Click:Connect(boostFPS)
}
