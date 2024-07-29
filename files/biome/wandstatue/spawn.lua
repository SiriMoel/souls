dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/drop_money_append.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

LoadPixelScene( "mods/souls/files/biome/wandstatue/wandstatue.png", "mods/souls/files/biome/wandstatue/wandstatue_visual.png", x-64, y-64, "", true )

local wx = x - 14
local wy = y - 17

local wand = "data/entities/items/wand_unshuffle_04.xml"

for i,biometable in ipairs(biomethings) do
    if biometable.biome == BiomeMapGetName(x, y) then
        if biometable.wand ~= "" then
            wand = biometable.wand
        end
    end
end

EntityLoad(wand, wx, wy)