local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "VAK Script",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Why you cheating?",
    LoadingSubtitle = "by VAK",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

local MainTab = Window:CreateTab("Main", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local MiscTab = Window:CreateTab("Misc", nil) -- Title, Image
local MiscSection = MiscTab:CreateSection("Misc")

Rayfield:Notify({
    Title = "VAK Script",
    Content = "Thanks for executed my script :3",
    Duration = 5,
    Image = nil,
})

local IYButton = MiscTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end,
})

local DexButton = MiscTab:CreateButton({
    Name = "DEX by Moon",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/iAim13082010/testrb/refs/heads/main/DEXbyMoon.lua'))()
    end,
})

local TPbutton = MainTab:CreateButton({
    Name = "Teleport Player(GUI)",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        -- Tạo GUI
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = game.CoreGui

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 200, 0, 300)
        Frame.Position = UDim2.new(0.5, -100, 0.5, -150)
        Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Frame.BorderSizePixel = 2
        Frame.Parent = ScreenGui
        Frame.Active = true
        Frame.Draggable = true -- Cho phép kéo thả GUI

        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Size = UDim2.new(1, 0, 0.8, 0)
        ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.Parent = Frame

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = ScrollingFrame

        local TeleportButton = Instance.new("TextButton")
        TeleportButton.Size = UDim2.new(1, 0, 0.2, 0)
        TeleportButton.Position = UDim2.new(0, 0, 0.8, 0)
        TeleportButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        TeleportButton.Text = "Teleport"
        TeleportButton.Parent = Frame
        TeleportButton.Visible = false

        local SelectedPlayer = nil

        local function UpdatePlayerList()
            for _, child in pairs(ScrollingFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local PlayerButton = Instance.new("TextButton")
                    PlayerButton.Size = UDim2.new(1, 0, 0, 30)
                    PlayerButton.Text = player.Name
                    PlayerButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    PlayerButton.Parent = ScrollingFrame
                    
                    PlayerButton.MouseButton1Click:Connect(function()
                        SelectedPlayer = player
                        TeleportButton.Visible = true
                    end)
                end
            end
        end
        
        TeleportButton.MouseButton1Click:Connect(function()
            if SelectedPlayer and SelectedPlayer.Character and LocalPlayer.Character then
                local TargetRoot = SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")
                local LocalRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if TargetRoot and LocalRoot then
                    LocalRoot.CFrame = TargetRoot.CFrame + Vector3.new(0, 3, 0) -- Teleport lên trên để tránh va chạm
                end
            end
        end)

        Players.PlayerAdded:Connect(UpdatePlayerList)
        Players.PlayerRemoving:Connect(UpdatePlayerList)
        UpdatePlayerList()
    end,
})

local FBbutton = MainTab:CreateButton({
    Name = "Full Bright + NoFog",
    Callback = function()
        local Lighting = game:GetService("Lighting")

        local oldBrightness = Lighting.Brightness
        local oldClockTime = Lighting.ClockTime
        local oldFogStart = Lighting.FogStart
        local oldFogEnd = Lighting.FogEnd
        local oldGlobalShadows = Lighting.GlobalShadows
        local oldOutdoorAmbient = Lighting.OutdoorAmbient

        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.FogStart = 1e10
        Lighting.FogEnd = 1e10
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)

        Lighting.Changed:Connect(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.FogStart = 1e10
            Lighting.FogEnd = 1e10
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end)
    end,
})

local ESPbutton = MainTab:CreateButton({
    Name = "ESP Player",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = game:GetService("Workspace").CurrentCamera
        local LocalPlayer = Players.LocalPlayer
        local ESP = {}
        local Drawings = {}

        function ESP:CreateDrawing(type, properties)
            local drawing = Drawing.new(type)
            for prop, value in pairs(properties) do
                drawing[prop] = value
            end
            return drawing
        end
        
        function ESP:TrackPlayer(player)
            task.spawn(function()
                while player and player.Character do
                    local character = player.Character
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    local head = character:FindFirstChild("Head")
                    local humanoid = character:FindFirstChild("Humanoid")
        
                    if rootPart and head and humanoid and humanoid.Health > 0 then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                        if onScreen then
                            local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) or 0
                            
                            local box = ESP:CreateDrawing("Square", {
                                Color = Color3.fromRGB(255, 0, 0),
                                Thickness = 2,
                                Transparency = 1,
                                Filled = false,
                                Visible = true,
                                Position = Vector2.new(screenPos.X - 50, screenPos.Y - 75),
                                Size = Vector2.new(100, 150)
                            })
                            
                            local tracer = ESP:CreateDrawing("Line", {
                                Color = Color3.fromRGB(255, 255, 255),
                                Thickness = 1,
                                Transparency = 1,
                                Visible = true,
                                From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y),
                                To = Vector2.new(screenPos.X, screenPos.Y)
                            })
                            
                            local nameTag = ESP:CreateDrawing("Text", {
                                Text = player.Name .. " | " .. math.floor(humanoid.Health) .. " HP | " .. math.floor(distance) .. " Studs",
                                Color = Color3.fromRGB(255, 255, 255),
                                Size = 16,
                                Outline = true,
                                Center = true,
                                Visible = true,
                                Position = Vector2.new(screenPos.X, screenPos.Y - 80)
                            })
                            
                            local healthBar = ESP:CreateDrawing("Line", {
                                Color = Color3.fromRGB(0, 255, 0),
                                Thickness = 2,
                                Transparency = 1,
                                Visible = true,
                                From = Vector2.new(screenPos.X - 55, screenPos.Y - 75),
                                To = Vector2.new(screenPos.X - 55, screenPos.Y - 75 + (150 * (humanoid.Health / humanoid.MaxHealth)))
                            })
                            
                            Drawings[player] = {box, tracer, nameTag, healthBar}
                            
                            while humanoid and humanoid.Health > 0 and character and rootPart do
                                local newScreenPos, newOnScreen = Camera:WorldToViewportPoint(rootPart.Position)
                                if newOnScreen then
                                    distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) or 0
                                    box.Position = Vector2.new(newScreenPos.X - 50, newScreenPos.Y - 75)
                                    tracer.To = Vector2.new(newScreenPos.X, newScreenPos.Y)
                                    nameTag.Position = Vector2.new(newScreenPos.X, newScreenPos.Y - 80)
                                    nameTag.Text = player.Name .. " | " .. math.floor(humanoid.Health) .. " HP | " .. math.floor(distance) .. " Studs"
                                    healthBar.From = Vector2.new(newScreenPos.X - 55, newScreenPos.Y - 75)
                                    healthBar.To = Vector2.new(newScreenPos.X - 55, newScreenPos.Y - 75 + (150 * (humanoid.Health / humanoid.MaxHealth)))
                                    
                                    box.Visible = true
                                    tracer.Visible = true
                                    nameTag.Visible = true
                                    healthBar.Visible = true
                                else
                                    box.Visible = false
                                    tracer.Visible = false
                                    nameTag.Visible = false
                                    healthBar.Visible = false
                                end
                                task.wait(0.01)
                            end
                            
                            box:Remove()
                            tracer:Remove()
                            nameTag:Remove()
                            healthBar:Remove()
                            Drawings[player] = nil
                        end
                    end
                    task.wait(0.01)
                end
            end)
        end
        
        function ESP:Start()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    player.CharacterAdded:Connect(function()
                        task.wait(0.5)
                        ESP:TrackPlayer(player)
                    end)
                    if player.Character then
                        ESP:TrackPlayer(player)
                    end
                end
            end
            
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    ESP:TrackPlayer(player)
                end)
            end)
            
            Players.PlayerRemoving:Connect(function(player)
                if Drawings[player] then
                    for _, drawing in pairs(Drawings[player]) do
                        drawing:Remove()
                    end
                    Drawings[player] = nil
                end
            end)
        end

        ESP:Start()
    end,
})
