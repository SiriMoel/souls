CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("mods/moles_things/files/scripts/utils.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xfff1ff75, "spawnbook" )

function init( x, y, w, h )
    LoadPixelScene( "mods/moles_things/files/biome/sunlab/sunlab.png", "mods/moles_things/files/biome/sunlab/sunlab_visual.png", x, y, "mods/moles_things/files/biome/sunlab/sunlab_background.png", true )
end

function spawnbook(x, y)
    EntityLoad("mods/moles_things/files/sunbook/item/item.xml", x, y)
end