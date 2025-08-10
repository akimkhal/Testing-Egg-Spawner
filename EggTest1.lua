--[[
Egg Spawner Script with Start/Stop Button
Works with KRNL
]]

-- CONFIG
local eggModelName = "Egg" -- Change this to the exact name of your egg model in Workspace or ReplicatedStorage
local spawnInterval = 2    -- seconds between spawns
local maxEggs = 20         -- maximum eggs in the world at once

-- VARIABLES
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local eggsFolder = workspace:FindFirstChild("EggsFolder") or Instance.new("Folder", workspace)
eggsFolder.Name = "EggsFolder"

local isSpawning = false
local spawnConnection = nil

-- CREATE INTERFACE
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EggSpawnerGUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0, 100, 0, 50)
startButton.Position = UDim2.new(0, 20, 0, 200)
startButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
startButton.Text = "Start Spawning"
startButton.Parent = screenGui

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 100, 0, 50)
stopButton.Position = UDim2.new(0, 20, 0, 260)
stopButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
stopButton.Text = "Stop Spawning"
stopButton.Parent = screenGui

-- FUNCTION TO SPAWN EGG
local function spawnEgg()
    local eggTemplate = replicatedStorage:FindFirstChild(eggModelName) or workspace:FindFirstChild(eggModelName)
    if eggTemplate and #eggsFolder:GetChildren() < maxEggs then
        local newEgg = eggTemplate:Clone()
        newEgg.Parent = eggsFolder
        newEgg.Position = Vector3.new(
            math.random(-50, 50), 
            5, 
            math.random(-50, 50)
        )
    end
end

-- START SPAWNING
local function startSpawning()
    if not isSpawning then
        isSpawning = true
        spawnConnection = runService.Heartbeat:Connect(function(dt)
            spawnEgg()
            wait(spawnInterval)
        end)
    end
end

-- STOP SPAWNING
local function stopSpawning()
    isSpawning = false
    if spawnConnection then
        spawnConnection:Disconnect()
        spawnConnection = nil
    end
end

-- BUTTON EVENTS
startButton.MouseButton1Click:Connect(startSpawning)
stopButton.MouseButton1Click:Connect(stopSpawning)
