local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP = {}

function ESP:CreateDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, value in pairs(properties) do
        drawing[prop] = value
    end
    return drawing
end

function ESP:TrackPlayer(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoidRootPart or not humanoid then return end
    
    local box = ESP:CreateDrawing("Square", {Thickness = 2, Color = Color3.fromRGB(255, 255, 255), Visible = false})
    local tracer = ESP:CreateDrawing("Line", {Thickness = 2, Color = Color3.fromRGB(255, 255, 255), Visible = false})
    local healthBar = ESP:CreateDrawing("Line", {Thickness = 3, Visible = false})
    local nameTag = ESP:CreateDrawing("Text", {Color = Color3.fromRGB(255, 255, 255), Size = 18, Center = true, Outline = true, Visible = false})

    RunService.RenderStepped:Connect(function()
        if character and humanoidRootPart and humanoid.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(humanoidRootPart.Position)
            if onScreen then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                local healthRatio = humanoid.Health / humanoid.MaxHealth
                
                box.Size = Vector2.new(1000 / rootPos.Z, 1500 / rootPos.Z)
                box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
                box.Visible = true

                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(rootPos.X, rootPos.Y + box.Size.Y / 2)
                tracer.Visible = true

                healthBar.From = Vector2.new(box.Position.X - 6, box.Position.Y + box.Size.Y)
                healthBar.To = Vector2.new(box.Position.X - 6, box.Position.Y + box.Size.Y * (1 - healthRatio))
                healthBar.Color = Color3.fromRGB(255 - (255 * healthRatio), 255 * healthRatio, 0)
                healthBar.Visible = true
                
                nameTag.Position = Vector2.new(rootPos.X, rootPos.Y - box.Size.Y / 2 - 15)
                nameTag.Text = string.format("%s | [%d HP] | %d Studs", player.Name, humanoid.Health, math.floor(distance))
                nameTag.Visible = true
            else
                box.Visible = false
                tracer.Visible = false
                healthBar.Visible = false
                nameTag.Visible = false
            end
        else
            box.Visible = false
            tracer.Visible = false
            healthBar.Visible = false
            nameTag.Visible = false
        end
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        ESP:TrackPlayer(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        ESP:TrackPlayer(player)
    end)
end)
