dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local x, y = EntityGetTransform( GetUpdatedEntityID() )

	SetRandomSeed(x, y)    
    math.randomseed(x, y+GameGetFrameNum())

	local doalterant = math.random(1, 4)
    if ModSettingGet( "souls.testing" ) then
        doalterant = 3
    end
    if doalterant == 3 then
        SpawnAlterant("FIRECRACKER", x, y)
    end
end