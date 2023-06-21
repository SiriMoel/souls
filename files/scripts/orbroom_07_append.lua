dofile_once("mods/moles_things/files/scripts/utils.lua")

local init_old = init

RegisterSpawnFunction(0xfff1ff75, "sunbook")

function init( x, y, w, h )
    init_old( x, y, w, h)
    LoadPixelScene( "mods/moles_things/files/biome/sunlab/sunlab.png", "mods/moles_things/files/biome/sunlab/sunlab_visual.png", x, y + 512, "mods/moles_things/files/biome/sunlab/sunlab_background.png", true )
end

function sunbook(x, y)
    
end