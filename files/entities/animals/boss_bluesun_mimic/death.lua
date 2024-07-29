dofile_once("mods/souls/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/souls/files/entities/items/wotc/weapon.xml", x + 16, y)

	EntityLoad("mods/souls/files/entities/sun/newsun_blue.xml", x, y)
end