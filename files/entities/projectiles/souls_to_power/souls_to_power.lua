dofile_once("mods/moles_things/files/scripts/utils.lua")
dofile_once("mods/moles_things/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local soul_count = GetSoulsCount("all") or 0

local count = math.ceil(soul_count * 0.3) 

if soul_count == 0 or count == 0 or count == nil then
	GamePrint("Not enough souls.")
	return 
end

if count == 1 then
	GamePrint(count .. " soul consumed!")
else
	GamePrint(count .. " souls consumed!")
end

--increase damage
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" ) or 0

local damage = ComponentGetValue2( comp, "damage" )

damage = damage + (count * 0.3) -- should this be adjusted?

ComponentSetValue2( comp, "damage", damage )

--effects
local effect_id = EntityLoad("mods/moles_things/files/entities/particles/souls_to_power.xml", x, y)
EntityAddChild( root_id, effect_id )

edit_component( effect_id, "ParticleEmitterComponent", function(comp3,vars)
	local part_min = 30 * count
	local part_max = 50 * count
	
	ComponentSetValue2( comp3, "count_min", part_min )
	ComponentSetValue2( comp3, "count_max", part_max )
end)

RemoveSouls(count)