local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "TEST",
    Icon = 0,
    LoadingTitle = "Grow a Garden | TEST",
    LoadingSubtitle = "by TEST",
    ShowText = "TEST",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "TEST"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

local farmTab = Window:CreateTab("Farm & Movement", 4483362458)

farmTab:CreateToggle({
    Name = "Auto Correct (Replant)",
    CurrentValue = false,
    Flag = "AutoCorrect",
    Callback = function(v)
        spawn(function()
            while Rayfield.Flags["AutoCorrect"] do
                for _, plot in pairs(workspace.Plots:GetChildren()) do
                    if plot:FindFirstChild("Plant") and plot.Plant.Health.Value <= 0 then
                        plot.Plant:Destroy()
                        local seed = Instance.new("Model", plot)
                        seed.Name = "Plant"
                    end
                end
                wait(1)
            end
        end)
    end,
})

farmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(v)
        spawn(function()
            while Rayfield.Flags["AutoFarm"] do
                for _, plot in pairs(workspace.Plots:GetChildren()) do
                    if plot:FindFirstChild("Plant") and plot.Plant.Harvestable.Value == true then
                        plot.Plant.HarvestEvent:FireServer()
                    end
                end
                wait(0.5)
            end
        end)
    end,
})

farmTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(v)
        local plr = game.Players.LocalPlayer
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if v then
            local bg = Instance.new("BodyGyro", plr.Character.PrimaryPart)
            local bv = Instance.new("BodyVelocity", plr.Character.PrimaryPart)
            bg.P = 9e4; bg.maxTorque = Vector3.new(9e9,9e9,9e9)
            bv.velocity = Vector3.new(0,0,0); bv.maxForce = Vector3.new(9e9,9e9,9e9)
            spawn(function()
                while Rayfield.Flags["Fly"] and hum and plr.Character do
                    hum.PlatformStand = true
                    local cam = workspace.CurrentCamera
                    local dir = Vector3.new()
                    if Rayfield.Input:KeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                    if Rayfield.Input:KeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                    if Rayfield.Input:KeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                    if Rayfield.Input:KeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                    bv.velocity = dir * (Rayfield.Flags["FlySpeed"] or 50)
                    bg.cframe = cam.CFrame
                    wait()
                end
                hum.PlatformStand = false
                bg:Destroy(); bv:Destroy()
            end)
        end
    end,
})

farmTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10,200},
    Increment = 5,
    Suffix = "speed",
    CurrentValue = 50,
    Flag = "FlySpeed"
})

farmTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16,200},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(v)
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
        end
    end,
})

farmTab:CreateSlider({
    Name = "Jump Power",
    Range = {50,300},
    Increment = 5,
    Suffix = "jump",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(v)
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = v
        end
    end,
})
