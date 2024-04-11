dofile_once("data/scripts/lib/utilities.lua")

function drop()
	local entity_id    = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "kick_count" )
	
	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	
	if ( comp ~= nil ) then
		local count = ComponentGetValue2( comp, "value_int" )
		count = count + 1
		ComponentSetValue2( comp, "value_int", count )
		
		SetRandomSeed( x + entity_id, y - GameGetFrameNum() )
		
		local outcome = Random( 1, 3 )
		
		--[[if ( count == 1 ) then
			outcome = 10
		elseif ( count > 3 ) then
			outcome = math.max( 1, outcome - ( count - 2 ) )
		end]]
		
		-- print( tostring( outcome ) )
		
		if ( outcome == 1 ) then
			EntityLoad( "data/entities/projectiles/deck/explosion.xml", x, y )
			EntityKill( entity_id )
			return
		else
			shoot_projectile( entity_id, "data/entities/items/pickup/random_card.xml", x, y, Random(-40,40), Random(-40,40) )
		end
	end
end

function kick()
	drop()
end