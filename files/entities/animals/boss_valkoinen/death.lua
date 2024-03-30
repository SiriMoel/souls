dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    -- unsure of a reward

	GameAddFlagRun("ikkuna_valkoinen")
	GamePrint("Trace found!")
end