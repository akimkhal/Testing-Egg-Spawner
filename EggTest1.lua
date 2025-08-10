-- Egg Finder for Grow a Garden
print("Scanning for eggs...")

local function scanForEggs()
    for _, obj in ipairs(game:GetDescendants()) do
        if string.find(string.lower(obj.Name), "egg") then
            print("Found:", obj:GetFullName(), " | Class:", obj.ClassName)
        end
    end
end

-- Initial scan
scanForEggs()

-- Optional: rescan every 5 seconds
while true do
    task.wait(5)
    scanForEggs()
end
