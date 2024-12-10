dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local comp_proj = EntityGetFirstComponent( entity_id, "ProjectileComponent" ) or 0
local damage = ComponentGetValue2( comp_proj, "damage" )

local player = GetPlayer()
local wand = HeldItem(player)

local count = 0

if DoesWandUseSpecificSoul(wand) then
	if (GetSoulsCount(GetWandSoulType(wand)) * 0.3) >= 1 then
		count = math.floor(GetSoulsCount(GetWandSoulType(wand)) * 0.3)
		for i=1,count do
			RemoveSoul(GetWandSoulType(wand))
			damage = damage + (count * 0.25)
			ComponentSetValue2(comp_proj, "damage", damage)
		end
		local effect_id = EntityLoad("mods/souls/files/entities/particles/souls_to_power.xml", x, y)
		EntityAddChild( root_id, effect_id )
		edit_component( effect_id, "ParticleEmitterComponent", function(comp3,vars)
			local part_min = 30 * count
			local part_max = 50 * count
			ComponentSetValue2( comp3, "count_min", part_min )
			ComponentSetValue2( comp3, "count_max", part_max )
		end)
	else
		GamePrint("You do not have enough souls for this.")
	end
else
	local soulscount = GetSoulsCount("all") - GetSoulsCount("boss")
	if (soulscount * 0.3) >= 1 then
		count = math.floor(soulscount * 0.3)
		for i=1,count do
			RemoveSoul(GetRandomSoul(false))
			damage = damage + (count * 0.25)
			ComponentSetValue2(comp_proj, "damage", damage)
		end
		local effect_id = EntityLoad("mods/souls/files/entities/particles/souls_to_power.xml", x, y)
		EntityAddChild( root_id, effect_id )
		edit_component( effect_id, "ParticleEmitterComponent", function(comp3,vars)
			local part_min = 30 * count
			local part_max = 50 * count
			ComponentSetValue2( comp3, "count_min", part_min )
			ComponentSetValue2( comp3, "count_max", part_max )
		end)
	end
end