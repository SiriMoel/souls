dofile_once("mods/souls/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	EntityLoad( "data/entities/items/pickup/heart.xml",  x , y )

    SetRandomSeed(x, y)
    math.randomseed(x, y+GameGetFrameNum())

    local chestnum = math.random(1,5)

    if chestnum == 2 then
        EntityLoad( "data/entities/items/pickup/chest_random_super.xml",  x - 32, y )
    elseif chestnum == 3 then
        return
    else
        EntityLoad( "data/entities/items/pickup/chest_random.xml",  x - 32, y )
    end
end