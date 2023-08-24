dofile_once("mods/moles_things/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunActionPermanent( entity_id, "TELEPORT_PROJECTILE_SHORT" )