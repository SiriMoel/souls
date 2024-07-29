dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

local init_old = init

math.randomseed(x, y + tonumber(StatsGetValue("world_seed")))

function init(x, y, w, h)
    init_old(x, y, w, h)
    print("testing - desert init")

    local lootorb = "mods/souls/files/entities/arch_orb/lootorb.xml"

    if y > 10 and y < 200 then

        local orb_x = x
        local orb_y = y

        for i=1,6 do
            EntityLoad(lootorb, orb_x, orb_y)
            orb_x = math.random(orb_x - 256, orb_x + 256)
            orb_y = math.random(orb_y - 256, orb_y + 256)
        end
    end
end