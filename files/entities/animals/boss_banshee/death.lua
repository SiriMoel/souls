dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)

    local targets2 = EntityGetWithTag("souls_banshee_minion")
    for i, v in ipairs(targets2) do
        EntityKill(v)
    end
    local targets = EntityGetWithTag("souls_banshee_soul")
    for i, v in ipairs(targets) do
        EntityKill(v)
    end

    EntityLoad("data/entities/items/pickup/heart.xml", x, y - 6)
    EntityLoad("data/entities/items/wand_unshuffle_04.xml", x, y - 5)

    AddFlagPersistent("souls_banshee_slain")

    SetRandomSeed(x, y)

    local spells_to_spawn = {}

    if not EntityHasTag(this, "souls_revived_boss") then
        local pool_1 = {"SOULS_REAPING_SHOT", "SOULS_RANDOM_REAP", "SOULS_SOULDOS", "SOULS_REAP_FROM_FIRE", "SOULS_NECRONOMICAL_REAP"}
        local pool_2 = {"SOULS_SOUL_BLAST", "SOULS_SOUL_ARROW", "SOULS_SOUL_BALL"}
        local rnd_1 = Random(1, #pool_1)
        local rnd_2 = Random(1, #pool_2)
        table.insert(spells_to_spawn, pool_1[rnd_1])
        table.insert(spells_to_spawn, pool_2[rnd_2])
        --CreateItemActionEntity(pool_1[rnd_1], x - 10, y - 5)
        --CreateItemActionEntity(pool_2[rnd_2], x + 10, y - 5)
    else
        local pool = {"SOULS_REAPING_SHOT", "SOULS_RANDOM_REAP", "SOULS_SOULDOS", "SOULS_REAP_FROM_FIRE", "SOULS_NECRONOMICAL_REAP", "SOULS_SOUL_BLAST", "SOULS_SOUL_ARROW", "SOULS_SOUL_BALL"}
        local rnd = Random(1, #pool)
        table.insert(spells_to_spawn, pool[rnd])
        --CreateItemActionEntity(pool[rnd], x, y - 5)
    end

    EntityLoad("mods/souls/files/entities/items/_soulcrystals/banshee.xml", x, y - 6)

    if BiomeMapGetName(x, y) == "$biome_rainforest" and not GameHasFlagRun("souls_banshee_rainforest") then
        GameAddFlagRun("souls_banshee_rainforest")
        table.insert(spells_to_spawn, "SOULS_SEA")
        --CreateItemActionEntity("SOULS_SEA", x, y - 5)
    end
    
    for i, v in ipairs(spells_to_spawn) do
        CreateItemActionEntity(v, x - 5 * (#spells_to_spawn - 1) + 10 * (i - 1), y - 5)
    end

    SoulsDeath(this, entity_thats_responsible)
end