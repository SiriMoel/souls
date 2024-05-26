dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local x, y = EntityGetTransform(weapon)

AddGunActionPermanent( weapon, "KUPOLI_TOME_BATTERY" )
--AddGunAction( weapon, "KUPOLI_TOME_CHARGE" )
AddGunAction( weapon, "KUPOLI_TOME_SHOT" )