dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local x, y = EntityGetTransform(weapon)

AddGunAction( weapon, "KUPOLI_REAPING_SHOT" )
AddGunAction( weapon, "LIGHT_BULLET" )