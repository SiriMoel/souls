dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")
dofile_once("mods/tales_of_kupoli/files/alterants.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)

    local target = ""

    local pool = { "MANA_REDUCE", }

    local alterantspool = {
        "HOMING_RAG",
        "RANDOM_RAG",
        "TELE_RAG",
    }

    if ModIsEnabled("copis_things") then
        local copispells = {
            "COPIS_THINGS_MANA_RANDOM",
            "COPIS_THINGS_MANA_EFFICENCY",
            "COPIS_THINGS_MANA_ENGINE",
            "COPIS_THINGS_MANA_DELTA",
        }
        for i,v in ipairs(copispells) do
            table.insert(pool, v)
        end
    end

    target = pool[math.random(1, #pool)]

    if math.random(1, 5) == 3 then
        CreateItemActionEntity( target, x , y )
    end

    local doalterant = math.random(1, 6)
    if ModSettingGet( "tales_of_kupoli.testing" ) then
        doalterant = 3
    end
    if doalterant == 3 then
        SpawnAlterant(alterantspool[math.random(1,#alterantspool)], x, y)
    end
end