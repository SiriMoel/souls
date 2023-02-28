CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("mods/moles_n_more/files/scripts/utils.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )

function init( x, y, w, h )
    LoadPixelScene( "mods/moles_n_more/files/biome/sunlab/sunlab.png", "mods/moles_n_more/files/biome/sunlab/sunlab_visual.png", x, y, "mods/moles_n_more/files/biome/sunlab/sunlab_background.png", true )
end