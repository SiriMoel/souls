dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

AddGunAction( weapon, "HEAVY_BULLET" )
AddGunActionPermanent( weapon, "BLOOD_TO_ACID" )