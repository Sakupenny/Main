local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Infinite Streak Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by @sakupenny",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

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