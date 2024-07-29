dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)    
    math.randomseed(x, y+GameGetFrameNum())

    if math.random(1, 20) == 10 then
        CreateItemActionEntity( "KUPOLI_DIAHEART_LENSE", x , y )
    end

	EntityLoad("mods/souls/files/entities/revived/_tablets/alchemist.xml", x, y)
end