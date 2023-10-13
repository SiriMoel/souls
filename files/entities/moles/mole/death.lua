dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity )
    local z, m, c, v, b, n = GameGetDateAndTimeLocal()
    math.randomseed(z+m+c+v+b+n+x+y)

    GamePrint("Mole vanquished!")
    EntityLoad("data/entities/items/pickup/goldnugget_1000.xml", x, y)
end