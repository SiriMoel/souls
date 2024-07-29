dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "card_unlocked_duplicate" )
	
	local pw = check_parallel_pos( x )
	SetRandomSeed( pw, 60 )
	
	local opts = { "ALPHA", "OMEGA", "GAMMA", "MU", "RESET", "ZETA", "PHI", "TAU", "SIGMA" }
	local rnd = Random( 1, #opts )
	
	if flag_status then
		for i=1,4 do
			rnd = Random( 1, #opts )
			CreateItemActionEntity( opts[rnd], x - 8 * 4 + (i-1) * 16, y )
			table.remove( opts, rnd )
		end
	else
		for i=1,4 do
			rnd = Random( 1, #opts )
			CreateItemActionEntity( opts[rnd], x - 8 * 4 + (i-1) * 16, y )
			table.remove( opts, rnd )
		end
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  x, y )
	end
	
	--[[local optsdos = { "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE" }
	
	for i=1,2 do
		CreateItemActionEntity( optsdos[i], x - 8 * 4 + (i-1) * 16, y )
	end]]--

	EntityLoad( "data/entities/animals/boss_alchemist/key.xml",  x, y )

	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )

	local spawntablet = math.random(1, 2)
	if spawntablet == 1 then
		EntityLoad( "mods/souls/files/entities/revived/_tablets/alchemist.xml", x, y)
	end
	
	AddFlagPersistent( "card_unlocked_duplicate" )
	AddFlagPersistent( "miniboss_alchemist" )
end