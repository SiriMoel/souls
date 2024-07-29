dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

shoot_projectile_from_projectile( entity_id, "mods/souls/files/entities/items/mechakolmiwand/rocket.xml", x, y, 0, 0 )