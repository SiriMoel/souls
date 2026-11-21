function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
	EntityLoad("mods/souls/files/entities/items/soulcrystals/apotheosis/toxic_worm.xml", x, y)
end