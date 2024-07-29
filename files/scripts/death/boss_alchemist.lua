dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

	--[[local opts = { "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE" }
	
	for i=1,4 do
		CreateItemActionEntity( opts[i], x - 8 * 4 + (i-1) * 16, y )
	end]]--

	--CreateItemActionEntity("KUPOLI_TOME_BUFF", x - 8 * 4 + (4-4) * 16, y ) -- maybe

	EntityLoad("mods/souls/files/entities/revived/_tablets/alchemist.xml", x, y)

	GameAddFlagRun("ikkuna_alchemist")
	GamePrint("Trace found!")
end