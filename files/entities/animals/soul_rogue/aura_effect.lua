dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 220

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

local done = {}

for i,v in ipairs( targets ) do
	if ( v ~= entity_id and not EntityHasTag( v, "mimic_potion" ) ) then
		local c = EntityGetAllChildren( v )
		local root_id = EntityGetRootEntity( v )
		local valid = true
		
		if ( done[root_id] == nil ) then
			if ( c ~= nil ) then
				for a,b in ipairs( c ) do
					local comps = EntityGetComponent( b, "GameEffectComponent", "soul_rogue" )
					
					if ( comps ~= nil ) then
						valid = false
						break
					end
				end
			end
			
			if valid then
				local eid = EntityLoad( "mods/souls/files/entities/misc/effect_soul_rogue/effect.xml", x, y )
				EntityAddChild( v, eid )
				
				done[v] = 1
			end
		end
	end
end