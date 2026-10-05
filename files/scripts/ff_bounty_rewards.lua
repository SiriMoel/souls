dofile_once("mods/souls/files/scripts/souls.lua")

local souls_rewards = {
    {
        id = "souls",
        chance = 1.5,
        spawn_func = function(x, y) 
            SetRandomSeed(x, y)
            local souls = {}
            for i = 1, 10 do
                local soul = soul_types[Random(1, #soul_types - 1)]
                souls[soul] = (souls[soul] or 0) + 1
            end
            local this = GetUpdatedEntityID()
            DontFearTheReaper(souls, this)
            SoulsPrint("Souls!")
        end,
    },
}

for i,v in ipairs(souls_rewards) do
    table.insert(bounty_rewards, v)
end