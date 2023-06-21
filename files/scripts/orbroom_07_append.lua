dofile_once("mods/moles_things/files/scripts/utils.lua")

local init_old = init

RegisterSpawnFunction(0xfff1a275, "sunbook")

function init( x, y, w, h )
    init_old( x, y, w, h)
    print("soldos")
    LoadPixelScene( "mods/moles_things/files/biome/sunlab/sunlab.png", "mods/moles_things/files/biome/sunlab/sunlab_visual.png", x, y + 512, "mods/moles_things/files/biome/sunlab/sunlab_background.png", true )
    EntityLoad("mods/moles_things/files/sunbook/item/item.xml", 4352, 1230)
end

function sunbook(x, y)
    print("soldos")
    EntityLoad("mods/moles_things/files/sunbook/item/item.xml", x, y)
end