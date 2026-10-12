dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("data/scripts/perks/perk.lua")

haunting_rewards = {
    {
        id = "spell",
        min_level = 0,
        chance = 1.0,
        spawn_func = function(level, x, y)
            local action_level = 4 + math.floor(level/2)
            if action_level > 6 then
                action_level = 10
            end
            local action = GetRandomAction(x, y, action_level, 0)
            CreateItemActionEntity(action, x, y - 6)
        end,
    },
    {
        id = "tome_spell",
        min_level = 1,
        chance = 0.7,
        spawn_func = function(level, x, y)
            local opts = {"SOULS_TOME_SLICE", "SOULS_TOME_LAUNCHER", "SOULS_TOME_LASER"}
            local action = opts[Random(1, #opts)]
            CreateItemActionEntity(action, x, y - 6)
        end,
    },
    {
        id = "boss_soul",
        min_level = 1,
        chance = 0.8,
        spawn_func = function(level, x, y)
            local entity = GetUpdatedEntityID()
            DontFearTheReaper({["boss"]=math.ceil(level/2)}, entity)
        end,
    },
    {
        id = "reaper_perk",
        min_level = 1,
        chance = 0.4,
        spawn_func = function(level, x, y)
            perk_spawn(x, y - 6, "SOULS_REAP_BETTER")
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