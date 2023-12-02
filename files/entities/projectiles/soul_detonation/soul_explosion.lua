dofile_once("mods/tales_of_kupoli/files/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local soul = GetRandomSoul()


if soul == nil or soul == 0 then
	GamePrint("You have no souls.")

	local projcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) or 0

	ComponentSetValue2( projcomp, "on_death_explode", false )
	ComponentSetValue2( projcomp, "on_lifetime_out_explode", false )
	ComponentSetValue2( projcomp, "collide_with_entities", false )
	ComponentSetValue2( projcomp, "collide_with_world", false )
	ComponentSetValue2( projcomp, "lifetime", 0 )

    EntityKill(entity_id)
else
	if ModSettingGet( "moles_souls.say_consumed_soul" ) then
		GamePrint( "You have consumed a soul." )
	end

	RemoveSoul(soul)
end