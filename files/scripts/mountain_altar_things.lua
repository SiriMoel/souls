dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

SetRandomSeed( x, y )

local tablets = EntityGetWithTag("redsun_revive")

if ( #tablets > 0 ) then
	
	local tx = 0
	local ty = 0
	for i,tablet_id in ipairs(tablets) do
		local in_world = false
		local components = EntityGetComponent( tablet_id, "PhysicsBodyComponent" )
		
		if( components ~= nil ) then
			in_world = true
		end
		
		tx, ty = EntityGetTransform( tablet_id )
		SetRandomSeed( tx+236, ty-4125 )
		
		if in_world then
			local distance = math.abs(x - tx) + math.abs(y - ty)
		
			if ( distance < 56 ) then
                if ModSettingGet("tales_of_kupoli.redsun_altar") then
                    local boss_comp = EntityGetFirstComponentIncludingDisabled(tablet_id, "VariableStorageComponent", "boss") or 0
                    local boss = ComponentGetValue2(boss_comp, "value_string")
                    EntityLoad(boss, tx, ty)
                    EntityConvertToMaterial( tablet_id, "spark_red")
                    EntityKill( tablet_id )
                end
			end
		end
	end
end