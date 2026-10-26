dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)

    EntityLoad("data/entities/items/pickup/heart.xml", x, y - 6)
    EntityLoad("data/entities/items/wand_unshuffle_05.xml", x, y - 5)

    SetRandomSeed(x, y)

    local pool_1 = {"SOULS_REAPING_SHOT", "SOULS_RANDOM_REAP", "SOULS_SOULDOS", "SOULS_REAP_FROM_FIRE"}
    local pool_2 = {"SOULS_SOUL_BLAST", "SOULS_SOUL_ARROW", --[[SOULS_SOUL_BOLT"]], "SOULS_SOUL_BALL", --[["SOULS_SOUL_METEOR"]]}

    local rnd_1 = Random(1, #pool_1)
    local rnd_2 = Random(1, #pool_2)

    CreateItemActionEntity(pool_1[rnd_1], x - 10, y - 5)
    CreateItemActionEntity(pool_2[rnd_2], x + 10, y - 5)

    SoulsDeath(this, entity_thats_responsible)
end