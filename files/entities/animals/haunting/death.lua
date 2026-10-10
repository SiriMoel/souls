dofile_once("mods/souls/files/scripts/souls.lua")
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
    SoulsDeath(this, entity_thats_responsible)
end