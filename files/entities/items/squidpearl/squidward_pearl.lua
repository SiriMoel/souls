dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunActionPermanent( entity_id, "RUBBER_BALL" )
AddGunActionPermanent( entity_id, "ROCKET" )
AddGunActionPermanent( entity_id, "ROCKET_TIER_2" )
AddGunActionPermanent( entity_id, "ROCKET_TIER_3" )
AddGunActionPermanent( entity_id, "GRENADE" )
AddGunActionPermanent( entity_id, "GRENADE_TIER_2" )
AddGunActionPermanent( entity_id, "GRENADE_TIER_3" )