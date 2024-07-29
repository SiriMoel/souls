dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	-- StatsLogPlayerKill( GetUpdatedEntityID() )
	
	local pw = check_parallel_pos( x )
	SetRandomSeed( pw, 30 )
	
	local opts = { "ADD_TRIGGER", "ADD_TIMER", "ADD_DEATH_TRIGGER", "RESET", "DUPLICATE" }
	
	for i=1,4 do
		CreateItemActionEntity( opts[i], x - 8 * 4 + (i-1) * 16, y )
	end
	
	EntityLoad( "data/entities/items/books/book_mestari.xml",  x - 16, y )
	EntityLoad( "data/entities/items/pickup/wandstone.xml",  x + 16, y )

	--[[local optsdos = { "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE", "KUPOLI_DIAHEART_LENSE" }
	
	for i=1,2 do
		CreateItemActionEntity( optsdos[i], x - 8 * 4 + (i-1) * 16, y )
	end]]--

	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/souls/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )

	local spawntablet = math.random(1, 2)
	if spawntablet == 1 then
		EntityLoad( "mods/souls/files/entities/revived/_tablets/grandmaster.xml", x, y)
	end
	
	AddFlagPersistent( "card_unlocked_mestari" )
	AddFlagPersistent( "miniboss_wizard" )
end