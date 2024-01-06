dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local keys = EntityGetInRadiusWithTag( x, y, 24, "alchemist_key" )

if ( #keys > 0 ) then
	
	local already_done = HasFlagPersistent( "kupoli_soul_chest_open" )

		if ( already_done == false ) then
			GamePrintImportant( "$log_alchemist_chest_open", "$logdesc_alchemist_chest_open" )
			EntitySetComponentsWithTagEnabled( entity_id, "chest_enable", true )
			EntitySetComponentsWithTagEnabled( entity_id, "chest_disable", false )
			CreateItemActionEntity( "KUPOLI_ALL_REAP_MAGE", x - 48, y )
			CreateItemActionEntity( "KUPOLI_ALL_REAP_GILDED", x - 24, y )
			CreateItemActionEntity( "KUPOLI_SOULDOS", x, y )
			CreateItemActionEntity( "KUPOLI_ALL_REAP_FLY", x + 24, y )
			CreateItemActionEntity( "KUPOLI_ALL_REAP_SPIDER", x + 48, y )
			AddFlagPersistent( "kupoli_soul_chest_open" )
		else
			GamePrintImportant( "$log_alchemist_chest_opened", "$logdesc_alchemist_chest_opened" )
			local opts = { "KUPOLI_ALL_REAP_MAGE", "KUPOLI_ALL_REAP_GILDED", "KUPOLI_SOULDOS", "KUPOLI_ALL_REAP_FLY", "KUPOLI_ALL_REAP_SPIDER" }
			SetRandomSeed( x, y * GameGetFrameNum() )
			
			for i=1,3 do
				local rnd = Random( 1, #opts )
				local opt = opts[rnd]
				
				CreateItemActionEntity( opt, x - 16 + (i-1) * 16, y )
			end
		end
		
		EntityLoad( "data/entities/particles/particle_explosion/main_swirly_green.xml", x, y )
		EntityLoad( "data/entities/projectiles/circle_water.xml", x, y )
		GamePlaySound( "data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y )
		
		EntityKill( key_id )
		EntityKill( entity_id )
end		