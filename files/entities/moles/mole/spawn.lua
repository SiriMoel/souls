dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()

GamePlayAnimation(entity, "digup", 10)
GamePrint("A mole has appeared!")