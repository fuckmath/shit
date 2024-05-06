
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Matrix - Counter Blox - DC: mtx422", HidePremium = false, SaveConfig = false, ConfigFolder = "CFG"})

local colorMod = game.Workspace.Camera.ColorCorrection
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local colorMod = game.Workspace.Camera.ColorCorrection
local cameraFov = game.Workspace.Camera.FieldOfView
local Flash = game.ReplicatedStorage.Events.Flash
local weaponsFolder = game.ReplicatedStorage:FindFirstChild("Weapons")


local Aimbot_FOV 
local Aimbot_Enabled 
local Chams_Enabled
local Chams_Color
local Nametags_Enabled
local Nametags_Color
local BulletTracers_Enabled
local BulletTracers_Color
local Thirdperson_Enabled
local Thirdperson_Distance
local FOVtoSet = 75

local smoothing = 1

local AimAssist_Tab = Window:MakeTab({
    Name = "Aim assist",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Visuals_Tab = Window:MakeTab({
    Name = "Players",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local World_Tab = Window:MakeTab({
    Name = "World",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Misc_Tab = Window:MakeTab({
    Name = "Miscellaneous",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local World_Section = World_Tab:AddSection({
    Name = "World"
})

local AimAssist_Section = AimAssist_Tab:AddSection({
    Name = "Aim Assist"
})

local Visuals_Section = Visuals_Tab:AddSection({
    Name = "ESP"
})

local Visuals_Section1 = Visuals_Tab:AddSection({
    Name = "Local"
})


local Misc_Section = Misc_Tab:AddSection({
       Name = "Stuff"
})

Misc_Section:AddButton({
    Name = "Give Money",
    Callback = function()
     LocalPlayer.Cash.Value = 9999999999
    end    
})

Visuals_Section1:AddToggle({
    Name = "Enable Thirdperson",
    Default = false,
    Callback = function(Value)
       Thirdperson_Enabled = Value    
    end    
})

Visuals_Section1:AddSlider({
    Name = "Thirdperson Distance",
    Min = 0,
    Max = 200,
    Default = 60,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "l",
    Callback = function(Value)
        Thirdperson_Distance = Value
    end    
})


Visuals_Section1:AddSlider({
    Name = "Camera Field of view",
    Min = 75,
    Max = 120,
    Default = 60,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Degrees",
    Callback = function(Value)
        FOVtoSet = Value
        game.Workspace.CurrentCamera.FieldOfView = FOVtoSet  -- Update the camera's FOV
    end    
})


Visuals_Section1:AddToggle({
    Name = "Enable Bullet Tracers",
    Default = false,
    Callback = function(Value)
       BulletTracers_Enabled = Value    
    end    
})

Visuals_Section1:AddColorpicker({
    Name = "Bullet Tracers Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        BulletTracers_Color = Value
    end      
})

Visuals_Section:AddToggle({
    Name = "Enable Chams",
    Default = false,
    Callback = function(Value)
        Chams_Enabled = Value    
    end    
})


Visuals_Section:AddColorpicker({
    Name = "Chams Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        Chams_Color = Value
    end      
})

World_Section:AddColorpicker({
    Name = "World Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        colorMod.TintColor = Value
    end      
})

World_Section:AddButton({
    Name = "Remove Flash",
    Callback = function()
            Flash:Destroy()
    end    
})

World_Section:AddButton({
    Name = "Remove Smoke",
    Callback = function()
    local smokesP = workspace:FindFirstChild("Ray_Ignore")
    local smokes = smokesP:FindFirstChild("Smokes")
     smokes:Destroy()
    end    
})

Visuals_Section:AddToggle({
    Name = "Name Tags",
    Default = false,
    Callback = function(Value)
        Nametags_Enabled = Value
    end    
})

Visuals_Section:AddColorpicker({
    Name = "Name Tags Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        Nametags_Color = Value
    end      
})

AimAssist_Section:AddToggle({
    Name = "Enable",
    Default = false,
    Callback = function(Value)
        Aimbot_Enabled = Value
    end    
})



AimAssist_Section:AddSlider({
    Name = "Field of view",
    Min = 0,
    Max = 180,
    Default = 60,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Degrees",
    Callback = function(Value)
        Aimbot_FOV = Value
    end    
})


AimAssist_Section:AddButton({
    Name = "Remove Recoil",
    Callback = function()
             if weaponsFolder then
            local weaponNames = {
                "DesertEagle",
                "AK47",
                "AWP",
                "Tec9",
                "Nova",
                "CZ",
                "AUG",
                "SawedOff",
                "P250",
                "M4A1",
                "USP",
                "UMP",
                "Glock",
                "P2000",
                "M4A4"
            }

            for _, weaponName in ipairs(weaponNames) do
                local weaponFolder = weaponsFolder:FindFirstChild(weaponName)

                if weaponFolder then
                    local spread = weaponFolder:FindFirstChild("Spread")
                    spread.Value = 0
  
                    if spread then
                        -- Set the value of the Spread property to 0 for all child elements
                        for _, child in ipairs(spread:GetChildren()) do
                            child.Value = 0
                        end
                    end
                end
            end
        end
    end    
})

AimAssist_Section:AddButton({
    Name = "Rapid Fire",
    Callback = function()
             if weaponsFolder then
            local weaponNames = {
                "DesertEagle",
                "AK47",
                "AWP",
                "Tec9",
                "Nova",
                "CZ",
                "AUG",
                "SawedOff",
                "P250",
                "M4A1",
                "USP",
                "UMP",
                "Glock",
                "P2000",
                "M4A4"
            }

            for _, weaponName in ipairs(weaponNames) do
                local weaponFolder = weaponsFolder:FindFirstChild(weaponName)

                if weaponFolder then
                    local spread = weaponFolder:FindFirstChild("FireRate")
                    spread.Value = 0
  
                    if spread then
                        -- Set the value of the Spread property to 0 for all child elements
                        for _, child in ipairs(spread:GetChildren()) do
                            child.Value = 0
                        end
                    end
                end
            end
        end
    end    
})


local function getClosest(cframe)
    local ray = Ray.new(cframe.Position, cframe.LookVector).Unit

    local target = nil
    local mag = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if
            v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and
                v.Character:FindFirstChild("HumanoidRootPart") and
                v.Team ~= LocalPlayer.Team
         then
            local magBuf = (v.Character.Head.Position - ray:ClosestPoint(v.Character.Head.Position)).Magnitude

            if magBuf < mag then
                mag = magBuf
                target = v
            end
        end
    end

    return target
end

local function DoAimbot()

        local pressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) -- Right mouse button pressed
        local cam = workspace.CurrentCamera
        local zz = cam.ViewportSize / 2

        if pressed and Aimbot_Enabled then
            local curTar = getClosest(cam.CFrame)
            local ssHeadPoint = cam:WorldToScreenPoint(curTar.Character.Head.Position)
            ssHeadPoint = Vector2.new(ssHeadPoint.X, ssHeadPoint.Y)
            if (ssHeadPoint - zz).Magnitude < Aimbot_FOV then
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, curTar.Character.Head.Position), smoothing)
            end
        end

end

local function DrawNameTags()
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and LocalPlayer.Team ~= v.Team and v.Character and v.Character:FindFirstChild("Head") and
            v.Character:FindFirstChild("HumanoidRootPart") and
            v.Team 
        then
            if Nametags_Enabled then
                local label = v.Character:FindFirstChild("PlayerLabel")
                if not label then
                    label = Instance.new("BillboardGui")
                    label.Name = "PlayerLabel"
                    label.AlwaysOnTop = true
                    label.Size = UDim2.new(0, 100, 0, 20)
                    label.StudsOffset = Vector3.new(0, 4, 0) -- Height above the player's head
                    label.Parent = v.Character
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.Text = v.Name .. " - " .. v.Character.Humanoid.Health -- Concatenate name 
                    nameLabel.TextColor3 = Nametags_Color -- Set text color to Chams_Color
                    nameLabel.TextScaled = true -- Enable automatic text scaling
                    nameLabel.TextStrokeTransparency = 0 -- Set to 0 to make outline visible
                    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- Color of the outline
                    nameLabel.Font = Enum.Font.Gotham
                    nameLabel.Parent = label
                else
                    -- Update text color if the label exists
                    local nameLabel = label:FindFirstChild("TextLabel")
                    if nameLabel then
                        nameLabel.TextColor3 = Nametags_Color -- Set text color to Chams_Color
                          nameLabel.Text = v.Name .. " - " .. v.Character.Humanoid.Health -- Concatenate name 
            
                    end
                end
            else
                -- If nametags are disabled, destroy the labels
                local label = v.Character:FindFirstChild("PlayerLabel")
                if label then
                    label:Destroy()
                end
            end
        end
    end
end




local function DrawChams()
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and LocalPlayer.Team ~= v.Team and v.Character and v.Character:FindFirstChild("Head") and
            v.Character:FindFirstChild("HumanoidRootPart") and
            v.Team 
        then
            if Chams_Enabled then
                for _, part in ipairs(v.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local highlight = part:FindFirstChild("Highlight")
                        if not highlight then
                            highlight = Instance.new("BoxHandleAdornment")
                            highlight.Name = "Highlight"
                            highlight.Adornee = part
                            highlight.Size = part.Size * 0.6 -- Increase size slightly for better visibility
                            highlight.AlwaysOnTop = true -- Make it visible through walls
                            highlight.Transparency = 0.2
                            highlight.Color3 = Chams_Color
                            highlight.ZIndex = 5 -- Render above other parts
                            highlight.Parent = part
                        else
                            highlight.Size = part.Size * 0.6 -- Update size if the highlight exists
                            highlight.Color3 = Chams_Color
                        end
                    end
                end
            else
                -- Destroy chams if Chams_Enabled is false
                for _, part in ipairs(v.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local highlight = part:FindFirstChild("Highlight")
                        if highlight then
                            highlight:Destroy()
                        end
                    end
                end
            end
        end
    end
end


local function DoVisuals()
     game.Workspace.CurrentCamera.FieldOfView = FOVtoSet  -- Update the camera's FOV = FOVtoSet
end

local function createBulletTracer(startPos, endPos)
    local BulletTracers = Instance.new("Part")
    BulletTracers.Anchored = true
    BulletTracers.CanCollide = false
    BulletTracers.Material = Enum.Material.ForceField
    BulletTracers.Color = BulletTracers_Color
    BulletTracers.Size = Vector3.new(0.1, 0.1, (startPos - endPos).magnitude)
    BulletTracers.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -BulletTracers.Size.Z / 2)
    BulletTracers.Name = "BulletTracers"
    BulletTracers.Parent = game.Workspace 
    wait(2)
    BulletTracers:Destroy()
end


local function onMouseButton1Down()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    if mouse then
        local startPos = player.Character.Head.Position
        local endPos = mouse.Hit.p
		if BulletTracers_Enabled then
        createBulletTracer(startPos, endPos)
		end
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onMouseButton1Down()
    end
end)


RunService:BindToRenderStep("ThirdPerson", 100, function()
			if Thirdperson_Enabled and LocalPlayer.CameraMinZoomDistance ~= Thirdperson_Distance then
				LocalPlayer.CameraMinZoomDistance = Thirdperson_Distance
				LocalPlayer.CameraMaxZoomDistance = Thirdperson_Distance
				workspace.ThirdPerson.Value = true
			end
		end)

local ChamsLoop = RunService.Heartbeat:Connect(DrawChams)
local NameTagsLoop = RunService.Heartbeat:Connect(DrawNameTags)
local AimbotLoop = RunService.Heartbeat:Connect(DoAimbot)
local VisualsLoop = RunService.Heartbeat:Connect(DoVisuals)
