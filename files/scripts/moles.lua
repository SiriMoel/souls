dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local xcoord = 0
local ycoord = 0

local coords_list = {}

local player = GetPlayer()
local px, py = EntityGetTransform(player)

-- yes, my mod uses 4gb or ram. why do you ask?

if not GameHasFlagRun("moles_n_more_moles_generated") then
    for i=1,1000 do
        xcoord = math.random(-11000, 11000)
        ycoord = math.random(0, 5000)
        table.insert(coords_list, {
            x = xcoord,
            y = ycoord,
        })
    end
end

for i,v in coords_list do
    if IsInRadiusOf(px, py, v.x, v.y, 100) then
        GamePrint("MOLE SPAWNED")
        table.remove(coords_list, i)
    end
end