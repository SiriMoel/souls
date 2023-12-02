dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

	--[[local opts = { "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE" }
	
	for i=1,4 do
		CreateItemActionEntity( opts[i], x - 8 * 4 + (i-1) * 16, y )
	end]]--

	EntityLoad("mods/tales_of_kupoli/files/entities/revived/_tablets/grandmaster.xml", x, y)

	GameAddFlagRun("ikkuna_wizard")
end