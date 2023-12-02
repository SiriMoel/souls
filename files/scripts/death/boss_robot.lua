dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local x, y = EntityGetTransform( GetUpdatedEntityID() )

	EntityLoad("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/weapon.xml", x, y)

	EntityLoad("mods/tales_of_kupoli/files/entities/revived/_tablets/robot.xml", x, y)
end