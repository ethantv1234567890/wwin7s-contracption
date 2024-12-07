-- Grid size and part size
local gridWidth = 15
local gridHeight = 35
local partSize = 0.5

-- Origin point for the grid
local origin = Vector3.new(82, 7, 202)

-- Function to create the grid
local function createGrid()
    local parts = {}
    for x = 1, gridWidth do
        for y = 1, gridHeight do
            local part = Instance.new("Part")
            part.Size = Vector3.new(partSize, partSize, partSize)
            part.Anchored = true
            part.Position = origin + Vector3.new((x - 1) * partSize, (y - 1) * partSize, 0)
            part.Material = Enum.Material.SmoothPlastic
            part.TopSurface = Enum.SurfaceType.Smooth
            part.BottomSurface = Enum.SurfaceType.Smooth
            part.Parent = game.Workspace
            table.insert(parts, part)
        end
    end
    return parts
end

-- Function to convert hex color to Color3
local function hexToColor3(hex)
    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    return Color3.new(r, g, b)
end

-- Function to update the grid with colors from hex values
local function updateGrid(parts, hexColors)
    for i = 1, math.min(#parts, #hexColors) do
        parts[i].Color = hexToColor3(hexColors[i])
    end
end

-- Create the grid
local parts = createGrid()

-- Main loop to handle input and update the grid
while true do
    local hexColorData = script.inputs.a:GetState()
    
    if type(hexColorData) == "string" and #hexColorData > 0 then
        -- Split the input string into individual hex color values
        local hexColors = {}
        for hex in hexColorData:gmatch("%x%x%x%x%x%x") do
            table.insert(hexColors, hex)
        end
        
        -- Update the grid with the provided hex colors
        updateGrid(parts, hexColors)
    end

    wait(1)  -- Slow down rendering to approximately 1Hz (1 second delay)
end
