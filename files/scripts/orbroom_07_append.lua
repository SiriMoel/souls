dofile_once("mods/souls/files/scripts/utils.lua")

local init_old = init

RegisterSpawnFunction(0xfff1a275, "sunbook")

function init( x, y, w, h )
    init_old( x, y, w, h)
    LoadPixelScene( "mods/souls/files/biome/sunlab/sunlab.png", "mods/souls/files/biome/sunlab/sunlab_visual.png", x, y + 512, "mods/souls/files/biome/sunlab/sunlab_background.png", true )
    EntityLoad("mods/souls/files/sunbook/item/item.xml", 4352, 1230)
end

function sunbook(x, y)
    EntityLoad("mods/souls/files/sunbook/item/item.xml", x, y)
end