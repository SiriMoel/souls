dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

AddGunActionPermanent( weapon, "MATERIAL_WATER" )

AddGunAction( weapon, "HITFX_CRITICAL_WATER" )
AddGunAction( weapon, "KUPOLI_WATER_ESSENCE_PROJ" )