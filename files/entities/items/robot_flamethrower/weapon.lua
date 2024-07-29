dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

local x, y = EntityGetTransform(weapon)

weapon_rngstats(weapon, x, y, 2)
AddGunAction( weapon, "KUPOLI_ROBOT_FLAME" )