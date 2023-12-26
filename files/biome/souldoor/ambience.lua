dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

SetRandomSeed(x, y + GameGetFrameNum())

EntityLoad( "data/entities/particles/treble_eye.xml", x+(math.random(-90,90)), y+(math.random(-15,-150)) )