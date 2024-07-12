-- made by @the_sakupen on discord

-- kj anims obviously
local KJ_Animations = {
    ["Ravage_STARTUP"] = 123456789,
    ["Ravage_FULL"] = 123456789,
    ["Ravage_VICTIM"] = 123456789,
    ["SwiftSweep_HIT"] = 123456789
}

-- variables
local players = game:GetService("Players")
local plr = players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- main

local function stop_all_animations()
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
end


local function on_animation_played(player, animation_id)

end

-- my lazy ass used chatgpt for this
local function onAnimationPlayed(humanoid, animationTrack)
    local player = players:GetPlayerFromCharacter(humanoid.Parent)
    if player then
        local animation = animationTrack.Animation
        if animation then
            on_animation_played(player, animation.AnimationId)
        end
    end
end

local function onCharacterAdded(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.AnimationPlayed:Connect(function(animationTrack)
            onAnimationPlayed(humanoid, animationTrack)
        end)
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then
        onCharacterAdded(player.Character)
    end
end

players.PlayerAdded:Connect(onPlayerAdded)
for _, Player in pairs(players:GetPlayers()) do
    onPlayerAdded(Player)
end
--chatgpt code ends here

local function give_moveset()

end