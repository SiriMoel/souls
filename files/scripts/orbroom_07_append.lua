dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local init_old = init

function init( x, y, w, h )
    init_old( x, y, w, h)
    LoadPixelScene( "mods/moles_n_more/files/biome/sunlab/sunlab.png", "mods/moles_n_more/files/biome/sunlab/sunlab_visual.png", x, y + 512, "mods/moles_n_more/files/biome/sunlab/sunlab_background.png", true )
end