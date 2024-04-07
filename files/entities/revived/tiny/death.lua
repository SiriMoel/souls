dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	-- do some kind of an effect? throw some particles into the air?
	EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x - 24, pos_y )
	EntityLoad( "data/entities/items/pickup/heart_fullhp.xml", pos_x + 24, pos_y )
	EntityLoad( "data/entities/items/wand_unshuffle_10.xml", pos_x - 16, pos_y )
	EntityLoad( "data/entities/items/wand_unshuffle_10.xml", pos_x + 16, pos_y )
	
	GameAddFlagRun( "miniboss_maggot" )
	AddFlagPersistent( "miniboss_maggot" )
	AddFlagPersistent( "card_unlocked_maggot" )
	
	--StatsLogPlayerKill( entity_id )

	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", pos_x - 16, pos_y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", pos_x + 16, pos_y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", pos_x, pos_y + 8 )

	--EntityKill( entity_id )

	local pw = check_parallel_pos( x )
	SetRandomSeed( pw, 30 )

	local spawntablet = math.random(1, 2)
	if spawntablet == 1 then
		EntityLoad( "mods/tales_of_kupoli/files/entities/revived/_tablets/tiny.xml", x, y)
	end
end