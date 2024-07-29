dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()

GamePlayAnimation(entity, "digup", 10)
GamePrint("A mole has appeared!")