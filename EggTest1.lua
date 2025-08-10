-- Egg Spawner Script with Start/Stop
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local EggModelName = "Egg" -- Name of the egg model in ReplicatedStorage
local SpawnInterval = 3 -- Seconds between each spawn
local MaxEggs = 10 -- Maximum eggs allowed in the world

-- Variables
local spawning = false
local spawnedEggs = {}

-- Function to spawn an egg
local function spawnEgg()
    if not spawning then return end
    if #spawnedEggs >= MaxEggs then return end

    local eggTemplate = ReplicatedStorage:FindFirstChild(EggModelName)
    if eggTemplate then
        local newEgg = eggTemplate:Clone()
        newEgg.Position = Vector3.new(
            math.random(-50, 50), 
            5, 
            math.random(-50, 50)
        )
        newEgg.Parent = workspace
        table.insert(spawnedEggs, newEgg)

        -- Remove from list when destroyed
        newEgg.AncestryChanged:Connect(function()
            for i, egg in ipairs(spawnedEggs) do
                if egg == newEgg then
                    table.remove(spawnedEggs, i)
                    break
                end
            end
        end)
    else
        warn("Egg model not found in ReplicatedStorage")
    end
end

-- Start spawning
local function startSpawning()
    spawning = true
    while spawning do
        spawnEgg()
        wait(SpawnInterval)
    end
end

-- Stop spawning
local function stopSpawning()
    spawning = false
end

-- UI
local ScreenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))

local StartButton = Instance.new("TextButton", ScreenGui)
StartButton.Size = UDim2.new(0, 100, 0, 50)
StartButton.Position = UDim2.new(0, 50, 0, 50)
StartButton.Text = "Start Eggs"

local StopButton = Instance.new("TextButton", ScreenGui)
StopButton.Size = UDim2.new(0, 100, 0, 50)
StopButton.Position = UDim2.new(0, 160, 0, 50)
StopButton.Text = "Stop Eggs"

StartButton.MouseButton1Click:Connect(startSpawning)
StopButton.MouseButton1Click:Connect(stopSpawning)
