dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()

local angle = 0
local rotation = 0
local owner_id = 0
local length = 16

local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( variablestorages ~= nil ) then
	local anglestorage
	
	for j,storage_id in ipairs(variablestorages) do
		local var_name = ComponentGetValue( storage_id, "name" )
		if ( var_name == "angle" ) then
			angle = ComponentGetValue2( storage_id, "value_float" )
			anglestorage = storage_id
		elseif ( var_name == "rot" ) then
			rotation = ComponentGetValue2( storage_id, "value_int" )
		elseif ( var_name == "owner" ) then
			owner_id = ComponentGetValue2( storage_id, "value_int" )
		end
	end
	
	angle = angle + rotation * 0.02
	
	ComponentSetValue2( anglestorage, "value_float", angle )
end

angle = angle + rotation

if ( owner_id ~= NULL_ENTITY ) then
	local x, y = EntityGetTransform( owner_id )
	
	if ( x ~= nil ) and ( y ~= nil ) then
		local px = x + math.cos( angle ) * length
		local py = y - math.sin( angle ) * length
		
		EntitySetTransform( entity_id, px, py )
	else
		EntityKill( entity_id )
	end
end

local xx, yy = EntityGetTransform(entity_id)

local mark_radius = 70

local targets = EntityGetInRadiusWithTag( xx, yy, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        if ( EntityHasTag( target_id, "reap_marked" ) == false ) then

            EntityAddComponent( target_id, "LuaComponent",
            {
                script_death = "mods/souls/files/scripts/reap.lua",
                execute_every_n_frame = "-1",
            } )

            local effect_id = EntityLoad("mods/souls/files/entities/particles/marked_particles.xml", x, y)
            EntityAddChild( target_id, effect_id )

            EntityAddTag( target_id, "reap_marked")
        end
    end
end