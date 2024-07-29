dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local x, y = EntityGetTransform( GetUpdatedEntityID() )

	EntityLoad("mods/souls/files/entities/items/mechakolmiwand/weapon.xml", x, y)

	EntityLoad("mods/souls/files/entities/revived/_tablets/robot.xml", x, y)

	GameAddFlagRun("kupoli_better_weapons")
	GameAddFlagRun("ikkuna_robot")
	GamePrint("Newly dropped weapons are now stronger!")
	GamePrint("Trace found!")
end