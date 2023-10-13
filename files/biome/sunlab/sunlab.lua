CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xfff1ff75, "spawnbook" )

function init( x, y, w, h )
    LoadPixelScene( "mods/tales_of_kupoli/files/biome/sunlab/sunlab.png", "mods/tales_of_kupoli/files/biome/sunlab/sunlab_visual.png", x, y, "mods/tales_of_kupoli/files/biome/sunlab/sunlab_background.png", true )
end

function spawnbook(x, y)
    EntityLoad("mods/tales_of_kupoli/files/sunbook/item/item.xml", x, y)
end