dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()

AddGunActionPermanent( weapon, "HITFX_EXPLOSION_ALCOHOL_GIGA" )

AddGunAction( weapon, "DISC_BULLET_BIGGER" )
AddGunAction( weapon, "MIST_ALCOHOL" )