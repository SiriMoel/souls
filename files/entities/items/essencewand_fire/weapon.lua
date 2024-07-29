dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

AddGunActionPermanent( weapon, "HITFX_BURNING_CRITICAL_HIT" )

AddGunAction( weapon, "BURN_TRAIL" )
AddGunAction( weapon, "ORBIT_FIREBALLS" )
AddGunAction( weapon, "LIGHT_BULLET" )