local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua'))()
local Flags = Library.Flags

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local weaponsFolder = game.ReplicatedStorage:FindFirstChild("Weapons")
local colorMod = game.Workspace.Camera.ColorCorrection

local aimbot_e
local chams_e
local nametags_e
local fov 
local smoothing = 1
local infmoney_e
local LocalPlayer = game.Players.LocalPlayer

-- Funkcja sprawdzająca, czy dany klawisz jest wciśnięty
local function IsKeyDown(key)
    return UserInputService:IsKeyDown(Enum.KeyCode[key])
end

local Window = Library:Window({
    Text = "Noname - Counter Blox"
})

local Aiming_Tab = Window:Tab({
    Text = "Aiming"
})

local Visual_Tab = Window:Tab({
    Text = "Visual"
})

local Misc_Tab = Window:Tab({
    Text = "Misc"
})

local Misc_Section = Misc_Tab:Section({
    Text = "Stuff"
})


local InfCash_Enabled = Misc_Section:Toggle({
    Text = "Inf. Cash",
    Callback = function(val)
        infmoney_e = val
    end
})

local Aimbot_Section = Aiming_Tab:Section({
    Text = "Aimbot"
})

local GunMods_Section = Aiming_Tab:Section({
    Text = "Gun Mods"
})


local InfAmmo_Enabled = GunMods_Section:Toggle({
    Text = "Inf. Ammo",
    Callback = function(val)
         if weaponsFolder and val then
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
                    local spread = weaponFolder:FindFirstChild("Ammo")
                    spread.Value = 999999
  
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


local RapidFire_Enabled = GunMods_Section:Toggle({
    Text = "Rapid Fire",
    Callback = function(val)
         if weaponsFolder and val then
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

local Nospread_Enabled = GunMods_Section:Toggle({
    Text = "No Spread",
    Callback = function(val)
         if weaponsFolder and val then
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

local ESP_Section = Visual_Tab:Section({
    Text = "ESP"
})

local World_Section = Visual_Tab:Section({
    Text = "World"
})

local NightMode_Enabled = World_Section:Toggle({
    Text = "Night Mode",
    Callback = function(val)
        if val then 
        colorMod.Brightness = -0.3
		else
		colorMod.Brightness = 0
        end
    end
})

local ESPChams_Enabled = ESP_Section:Toggle({
    Text = "Chams",
    Callback = function(val)
        chams_e = val
    end
})

local ESPNames_Enabled = ESP_Section:Toggle({
    Text = "Name Tags",
    Callback = function(val)
        nametags_e = val
    end
})


local Aimbot_Enabled = Aimbot_Section:Toggle({
    Text = "Enable",
    Callback = function(val)
        aimbot_e = val
    end
})

local label = Aimbot_Section:Label({
    Text = "Press Right-Click to lock!",
    Color = Color3.fromRGB(217, 97, 99),
})

local Aimbot_FOV = Aimbot_Section:Slider({
    Text = "FOV",
    Default = 60,
    Minimum = 0,
    Maximum = 180,
    Callback = function(v)
      fov = v
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

local function infmoney()
if infmoney_e then
LocalPlayer.Cash.Value = 9999999999
end
end

local function aimbot()
        local pressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) -- Right mouse button pressed
        local cam = workspace.CurrentCamera
        local zz = cam.ViewportSize / 2

        if pressed and aimbot_e then
            local curTar = getClosest(cam.CFrame)
            local ssHeadPoint = cam:WorldToScreenPoint(curTar.Character.Head.Position)
            ssHeadPoint = Vector2.new(ssHeadPoint.X, ssHeadPoint.Y)
            if (ssHeadPoint - zz).Magnitude < fov then
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, curTar.Character.Head.Position), smoothing)
            end
        end

end

local function drawEsp()
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and LocalPlayer.Team ~= v.Team and v.Character and v.Character:FindFirstChild("Head") and
            v.Character:FindFirstChild("HumanoidRootPart") and
            v.Team 
        then
            if chams_e then
                for _, part in ipairs(v.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local highlight = part:FindFirstChild("Highlight")
                        if not highlight then
                            highlight = Instance.new("BoxHandleAdornment")
                            highlight.Name = "Highlight"
                            highlight.Adornee = part
                            highlight.Size = part.Size
                            highlight.AlwaysOnTop = true -- Make it visible through walls
                            highlight.Transparency = 0.2
                            highlight.Color3 = Color3.fromRGB(163, 8, 104) -- red color
                            highlight.ZIndex = 5 -- Render above other parts
                            highlight.Parent = part
                        end
                    end
                end
            end
				
            if nametags_e then
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
                    nameLabel.Text = v.Name
                    nameLabel.TextColor3 = Color3.new(255, 255, 255) -- Red text color
                    nameLabel.TextScaled = true -- Enable automatic text scaling
                    nameLabel.TextStrokeTransparency = 0 -- Set to 0 to make outline visible
                    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- Color of the outline
                    nameLabel.Font = Enum.Font.Arial
                    nameLabel.Parent = label
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


local loop = RunService.Heartbeat:Connect(drawEsp)
local loop2 = RunService.Heartbeat:Connect(aimbot)
local loop3 = RunService.Heartbeat:Connect(infmoney)

