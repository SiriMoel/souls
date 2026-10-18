dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("data/scripts/perks/perk.lua")

haunting_rewards = {
    {
        id = "spell",
        min_level = 0,
        chance = 2.0,
        spawn_func = function(level, x, y)
            local action_level = 4 + math.floor(level/2)
            if action_level > 6 then
                action_level = 10
            end
            local action = GetRandomAction(x, y, action_level, 0)
            CreateItemActionEntity(action, x, y - 4)
        end,
    },
    {
        id = "tome_spell",
        min_level = 3,
        chance = 0.9,
        spawn_func = function(level, x, y)
            local opts = {"SOULS_TOME_SLICE", "SOULS_TOME_LAUNCHER", "SOULS_TOME_LASER"}
            if level >= 6 then
                table.insert(opts, "SOULS_TOME_SPELLBOOK_2")
            end
            local action = opts[Random(1, #opts)]
            CreateItemActionEntity(action, x, y - 4)
        end,
    },
    {
        id = "boss_soul",
        min_level = 1,
        chance = 1.5,
        spawn_func = function(level, x, y)
            local entity = GetUpdatedEntityID()
            DontFearTheReaper({["boss"]=math.ceil(level/2)}, entity)
        end,
    },
    {
        id = "reaper_perk",
        min_level = 1,
        chance = 0.5,
        spawn_func = function(level, x, y)
            perk_spawn(x, y - 2, "SOULS_REAP_BETTER")
        end,
    },
    {
        id = "reaper_perk_2",
        min_level = 3,
        chance = 0.5,
        spawn_func = function(level, x, y)
            perk_spawn(x, y - 2, "SOULS_REAP_BETTER")
        end,
    },
    {
        id = "void_spell",
        min_level = 7,
        chance = 0.1,
        spawn_func = function(level, x, y)
            local entity = GetUpdatedEntityID()
            if HasFlagPersistent("souls_phylactery_activated") then
                CreateItemActionEntity("SOULS_VOID_ATTACK", x, y - 4)
                DontFearTheReaper({["souls_void"]=level-4}, entity)
            else
                DontFearTheReaper({["souls_void"]=level}, entity)
            end
        end,
    },
    {
        id = "soulward",
        min_level = 1,
        chance = 0.3,
        spawn_func = function(level, x, y)
            EntityLoad("mods/souls/files/entities/items/soulward/soulward.xml", x, y - 1)
        end,
    },
    {
        id = "heart",
        min_level = 1,
        chance = 1.4,
        spawn_func = function(level, x, y)
            for i = 1, level do
                EntityLoad("data/entities/items/pickup/heart.xml", x, y - 4)
            end
        end,
    },
    {
        id = "soulrefresh",
        min_level = 1,
        chance = 0.9,
        spawn_func = function(level, x, y)
            EntityLoad("mods/souls/files/entities/items/soulrefresh/thing.xml", x, y)
        end,
    },
    {
        id = "heart_fullhp",
        min_level = 2,
        chance = 1.2,
        spawn_func = function(level, x, y)
            EntityLoad("data/entities/items/pickup/heart_fullhp.xml", x, y - 4)
        end,
    },
    {
        id = "souls",
        min_level = 1,
        chance = 1.3,
        spawn_func = function(level, x, y) 
            local souls = {}
            local amt = 5 + level * 5
            for i = 1, amt do
                SetRandomSeed(x + level, y + i)
                local last_type = #soul_types - 2
                if level >= 4 then
                    last_type = #soul_types - 1
                end
                local soul = soul_types[Random(1, last_type)]
                souls[soul] = (souls[soul] or 0) + 1
            end
            local this = GetUpdatedEntityID()
            DontFearTheReaper(souls, this)
        end,
    },
}

function HauntingReward(level, x, y)
    SetRandomSeed(x, y)
    local chance_total = 0.0
    local possible_rewards = {}
    for i,v in ipairs(haunting_rewards) do
        if level >= v.min_level then
            v.chance_min = chance_total
            v.chance_max = chance_total + v.chance
            chance_total = v.chance_max
            table.insert(possible_rewards, v)
        end
    end
    local num = Random(0, math.floor(chance_total)) + 0.1 * Random(0, (chance_total - math.floor(chance_total)) * 10)
    for i,v in ipairs(possible_rewards) do
        if num >= v.chance_min and num < v.chance_max then
            v.spawn_func(level, x, y)
            return v.id
        end
    end
end