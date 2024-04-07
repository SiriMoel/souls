dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  x, y )
	EntityLoad( "data/entities/items/pickup/sun/sunseed.xml",  x + 16, y )

	EntityLoad( "data/entities/items/wand_unshuffle_06.xml", x + 8, y )
	EntityLoad( "data/entities/items/wand_unshuffle_06.xml", x, y )
	EntityLoad( "data/entities/items/wand_unshuffle_06.xml", x - 8, y )
	EntityLoad( "data/entities/items/wand_unshuffle_06.xml", x - 16, y )

	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )
	
	AddFlagPersistent( "miniboss_ghost" )

	local spawntablet = math.random(1, 2)
	if spawntablet == 1 then
		EntityLoad( "mods/tales_of_kupoli/files/entities/revived/_tablets/ghost.xml", pos_x, pos_y)
	end
end