-- Egg Spawner Test
-- Make sure an "Egg" model exists in ReplicatedStorage

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("Egg Spawner Loaded!")

-- Function to spawn an egg in front of player
local function spawnEgg()
    local player = Players.LocalPlayer
    if not player.Character or not player.Character.PrimaryPart then
        warn("Player character not ready")
        return
    end

    -- Find the egg model
    local eggTemplate = ReplicatedStorage:FindFirstChild("Egg")
    if not eggTemplate then
        warn("No 'Egg' found in ReplicatedStorage!")
        return
    end

    -- Clone and position the egg
    local newEgg = eggTemplate:Clone()
    local playerPos = player.Character.PrimaryPart.Position
    newEgg.Position = playerPos + Vector3.new(0, 5, -5) -- 5 studs in front
    newEgg.Parent = workspace

    print("Egg spawned!")
end

-- Spawn one egg every 5 seconds
while true do
    spawnEgg()
    task.wait(5)
end
