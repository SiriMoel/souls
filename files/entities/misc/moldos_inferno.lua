dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

GamePrint("a")

local entity = GetUpdatedEntityID()

GamePrint(EntityGetName(entity))

local parent = EntityGetParent(entity)

GamePrint(EntityGetName(parent))