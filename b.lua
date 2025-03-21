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
    task.spawn(function()
        while player and player.Character do
            local character = player.Character
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChild("Humanoid")

            if rootPart and head and humanoid and humanoid.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                    
                    local box = self:CreateDrawing("Square", {
                        Color = Color3.fromRGB(255, 0, 0),
                        Thickness = 2,
                        Transparency = 1,
                        Filled = false,
                        Visible = true,
                        Position = Vector2.new(screenPos.X - 50, screenPos.Y - 75),
                        Size = Vector2.new(100, 150)
                    })
                    
                    local tracer = self:CreateDrawing("Line", {
                        Color = Color3.fromRGB(255, 255, 255),
                        Thickness = 1,
                        Transparency = 1,
                        Visible = true,
                        From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y),
                        To = Vector2.new(screenPos.X, screenPos.Y)
                    })
                    
                    local nameTag = self:CreateDrawing("Text", {
                        Text = player.Name,
                        Color = Color3.fromRGB(255, 255, 255),
                        Size = 16,
                        Outline = true,
                        Center = true,
                        Visible = true,
                        Position = Vector2.new(screenPos.X, screenPos.Y - 80)
                    })
                    
                    local healthBar = self:CreateDrawing("Line", {
                        Color = Color3.fromRGB(0, 255, 0),
                        Thickness = 2,
                        Transparency = 1,
                        Visible = true,
                        From = Vector2.new(screenPos.X - 55, screenPos.Y - 75),
                        To = Vector2.new(screenPos.X - 55, screenPos.Y - 75 + (150 * (humanoid.Health / humanoid.MaxHealth)))
                    })
                    
                    RunService.RenderStepped:Connect(function()
                        local newScreenPos, newOnScreen = Camera:WorldToViewportPoint(rootPart.Position)
                        if newOnScreen then
                            box.Position = Vector2.new(newScreenPos.X - 50, newScreenPos.Y - 75)
                            tracer.To = Vector2.new(newScreenPos.X, newScreenPos.Y)
                            nameTag.Position = Vector2.new(newScreenPos.X, newScreenPos.Y - 80)
                            healthBar.From = Vector2.new(newScreenPos.X - 55, newScreenPos.Y - 75)
                            healthBar.To = Vector2.new(newScreenPos.X - 55, newScreenPos.Y - 75 + (150 * (humanoid.Health / humanoid.MaxHealth)))
                        else
                            box.Visible = false
                            tracer.Visible = false
                            nameTag.Visible = false
                            healthBar.Visible = false
                        end
                    end)
                end
            end
            task.wait(0.1)
        end
    end)
end

function ESP:Start()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            player.CharacterAdded:Connect(function()
                task.wait(1) -- Đợi nhân vật load
                ESP:TrackPlayer(player)
            end)
            if player.Character then
                ESP:TrackPlayer(player)
            end
        end
    end
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(1)
            ESP:TrackPlayer(player)
        end)
    end)
end

ESP:Start()
