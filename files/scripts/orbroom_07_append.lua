dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local init_old = init

RegisterSpawnFunction(0xfff1a275, "sunbook")

function init( x, y, w, h )
    init_old( x, y, w, h)
    LoadPixelScene( "mods/tales_of_kupoli/files/biome/sunlab/sunlab.png", "mods/tales_of_kupoli/files/biome/sunlab/sunlab_visual.png", x, y + 512, "mods/tales_of_kupoli/files/biome/sunlab/sunlab_background.png", true )
    EntityLoad("mods/tales_of_kupoli/files/sunbook/item/item.xml", 4352, 1230)
end

function sunbook(x, y)
    EntityLoad("mods/tales_of_kupoli/files/sunbook/item/item.xml", x, y)
end