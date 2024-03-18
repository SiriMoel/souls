dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    SetRandomSeed(x, y)    
    math.randomseed(x, y+GameGetFrameNum())

    local target = ""

    local pool = {
        "BOUNCE_LARPA",
        "ORBIT_LARPA",
        "LARPA_CHAOS",
        "LARPA_DOWNWARDS",
        "LARPA_UPWARDS",
        "LARPA_CHAOS_2",
        "LARPA_DEATH",
    }

    if ModIsEnabled("copis_things") then
        local copispells = {
            "COPITH_HITFX_LARPA",
            "COPITH_LARPA_BUT_GOOD",
            "COPITH_LARPA_FORWARDS",
            "COPITH_THINGS_RECURSIVE_LARPA",
            "COPITH_THINGS_LARPA_FIELD",
        }
        for i,v in ipairs(copispells) do
            table.insert(pool, v)
        end
    end

    target = pool[math.random(1, #pool)]

    if math.random(1, 4) == 3 then
        CreateItemActionEntity( target, x, y )
    end
end