dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/particles/souls_to_power.xml", x, y)
EntityAddChild( root_id, effect_id )