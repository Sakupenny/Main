local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window =
    Rayfield:CreateWindow(
    {
        Name = "infinite streak GUI",
        LoadingTitle = "We're preparing the GUI!",
        LoadingSubtitle = "by @sakupenny on YouTube",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil,
            FileName = "infinite_streak_config"
        },
        Discord = {
            Enabled = false
        },
        KeySystem = false
    }
)

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("Movement")

local settings = {
    DashToggle = false,
    AntiDCToggle = false
}

DashToggle = MainTab:CreateToggle({
    Name = "Dash (E to dash)",
    CurrentValue = false,
    Flag = "DashToggle",
    Callback = function(Value)
        settings[DashToggle.Flag] = Value
    end
})

AntiDCToggle = MainTab:CreateToggle({
    Name = "Anti Death-Counter",
    CurrentValue = false,
    Flag = "AntiDCToggle",
    Callback = function(Value)
        settings[DashToggle.Flag] = Value
    end
})

local Button =
    MainTab:CreateButton(
    {
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
            settings = {}
        end
    }
)

local function dash()
    local DashConnection = nil
    task.spawn(function()
        while task.wait() do
            if settings.DashToggle then
                DashConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, typing)
                    if typing then return end
                    if input.KeyCode == Enum.KeyCode.E then
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                        local forwardVector = humanoidRootPart.CFrame.LookVector
                        local newPosition = humanoidRootPart.Position + forwardVector * 35
                        humanoidRootPart.CFrame = CFrame.new(newPosition)
                    end
                end)
            else
                if DashConnection ~= nil then
                    DashConnection:Disconnect()
                    DashConnection = nil
                end
            end
        end
    end)
end

local function antidc()
    task.spawn(function()
        while task.wait() do
            for _, plyr in pairs(game:GetService("Players"):GetPlayers()) do
                if plyr.Backpack:FindFirstChild("Death Counter") then
                    for _, v in pairs(plyr.Character:GetChildren()) do
                        if v:IsA("Highlight") then v:Destroy() end
                    end
                    if settings.AntiDCToggle then
                        local new_highlight = Instance.new("Highlight", plyr.Character)
                        new_highlight.Name = "DC_HIGHLIGHT"
                        new_highlight.FillColor = Color3.new(1, 0.5, 0)
                    end
                elseif plyr.Character:FindFirstChild("Counter") then
                    for _, v in pairs(plyr.Character:GetChildren()) do
                        if v:IsA("Highlight") then v:Destroy() end
                    end
                    if settings.AntiDCToggle then
                        local new_highlight = Instance.new("Highlight", plyr.Character)
                        new_highlight.Name = "COUNTER_HIGHLIGHT"
                    end
                else
                    for _, v in pairs(plyr.Character:GetChildren()) do
                        if v:IsA("Highlight") then v:Destroy() end
                    end
                end
            end
        end
    end)
end

local function init()
    dash()
    antidc()
end

init()

Rayfield:LoadConfiguration()