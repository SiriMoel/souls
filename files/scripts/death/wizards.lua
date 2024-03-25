dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")
dofile_once("mods/tales_of_kupoli/files/alterants.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)
    math.randomseed(x, y+GameGetFrameNum())

    local numbger = 15

    local target = ""

    local pool = { "MANA_REDUCE", }

    if ModIsEnabled("grahamsperks") then
        local grahamspells = {
            "GRAHAM_MANAHEART",
            "GRAHAM_MANAHEARTBREAK",
            "GRAHAM_PASSIVES",
        }
        for i,v in ipairs(grahamspells) do
            table.insert(pool, v)
        end
        numbger = numbger - 2
    end

    if ModIsEnabled("copis_things") then
        local copispells = {
            "COPITH_MANA_RANDOM",
            "COPITH_MANA_EFFICENCY",
            "COPITH_MANA_ENGINE",
            "COPITH_MANA_DELTA",
        }
        for i,v in ipairs(copispells) do
            table.insert(pool, v)
        end
        numbger = numbger - 2
    end

    target = pool[math.random(1, #pool)]

    if math.random(1, numbger) == 3 then
        CreateItemActionEntity( target, x , y )
    end
end