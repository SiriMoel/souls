dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/drop_money_append.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/tales_of_kupoli/files/biome/wandstatue/wandstatue.png", "mods/tales_of_kupoli/files/biome/wandstatue/wandstatue_visual.png", x-64, y-64, "", true )

local wx = x + 20
local wy = y - 40

local wand = "data/entities/items/wand_unshuffle_06.xml"

for i,biometable in ipairs(biomethings) do
    if biometable.biome == BiomeMapGetName(x, y) then
        if biometable.wand ~= "" then
            wand = biometable.wand
        end
    end
end

EntityLoad(wand, wx, wy)