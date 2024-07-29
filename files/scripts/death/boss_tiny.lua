dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

	EntityLoad("mods/souls/files/entities/items/tinywand/weapon.xml", x-8, y)

	EntityLoad("mods/souls/files/entities/revived/_tablets/tiny.xml", x+8, y)
end