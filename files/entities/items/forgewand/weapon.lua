dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("mods/tales_of_kupoli/files/alterants.lua")

local weapon = GetUpdatedEntityID()

AddGunAction( weapon, "BULLET_TRIGGER" )
AddGunAction( weapon, "BULLET_TRIGGER" )
AddGunAction( weapon, "BULLET_TRIGGER" )

AddAlterant(wand, alterants[math.random(1,#alterants)].id)