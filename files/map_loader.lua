dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local w = 70
local h = 48 + 4

if ModIsEnabled("Apotheosis") then
    w = 102
    BiomeMapSetSize( w, h )
    BiomeMapLoadImage(0, 0, "mods/souls/files/biome_maps/biome_map_apoth.png")
else
    BiomeMapSetSize( w, h )
    BiomeMapLoadImage(0, 0, "mods/souls/files/biome_maps/biome_map.png")
end