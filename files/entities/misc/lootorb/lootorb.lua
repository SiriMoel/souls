dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local orb = GetUpdatedEntityID()
local x, y = EntityGetTransform(orb)

local options = {
    --[[total_prob = 0,
    {
        prob = 0,
        min_count = 0,
        max_count = 0,
        entity = "",
    },]]--
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_disc.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_fireball.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_laser.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_lava.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_metal.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_null.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/runestones/runestone_slow.xml",
    },
    {
        prob = 0.6,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/evil_eye.xml",
    },
    {
        prob = 0.4,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/gourd.xml",
    },
    {
        prob = 0.05,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/wandstone.xml",
    },
    {
        prob = 0.4,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/moon.xml",
    },
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/beamstone.xml",
    },
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/brimstone.xml",
    },
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/stonestone.xml",
    },
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/thunderstone.xml",
    },
    {
        prob = 0.5,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/waterstone.xml",
    },
    {
        prob = 0.3,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/poopstone.xml",
    },
    {
        prob = 0.8,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/physics_gold_orb.xml",
    },
    {
        prob = 0.65,
        min_count = 0,
        max_count = 0,
        entity = "mods/tales_of_kupoli/files/entities/items/amethyst_orb/item.xml",
    },
    {
        prob = 0.8,
        min_count = 0,
        max_count = 0,
        entity = "data/entities/items/pickup/physics_die.xml",
    },
}

--spawn(options, x, y)

math.randomseed(x, y + tonumber(StatsGetValue("world_seed")))

EntityLoad(options[math.random(1,#options)].entity, x, y)

EntityKill(orb)