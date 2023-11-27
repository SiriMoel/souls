dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)

    local pool = { "MANA_REDUCE" }

    if ModIsEnabled("copis_things") then
        table.insert(pool, { "COPIS_THINGS_MANA_RANDOM", "COPIS_THINGS_MANA_EFFICENCY", "COPIS_THINGS_MANA_ENGINE", "COPIS_THINGS_MANA_DELTA" })
    end

    if math.random(1, 7) == 3 then
        CreateItemActionEntity( pool[math.random(1,#pool)], x , y )
    end
end