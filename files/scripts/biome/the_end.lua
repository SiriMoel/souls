dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

RegisterSpawnFunction(0xff28DDE7, "spawn_soulshop")

if GlobalsGetValue("souls.enable_enemies", "true") == "true" then
    table.insert(g_small_enemies, {
        prob   		= 0.01 * tonumber(GlobalsGetValue("souls.enemy_soul_angry", "1")),
        min_count	= 1,
        max_count	= 1,
        entity 	= "data/entities/animals/the_end/moldos_soul_angry.xml",
    })
    table.insert(g_small_enemies, {
        prob   		= 0.02 * tonumber(GlobalsGetValue("souls.enemy_soul_rogue", "1")),
        min_count	= 1,
        max_count	= 1,
        entity 	= "data/entities/animals/moldos_soul_rogue.xml",
    })
    table.insert(g_small_enemies, {
        prob   		= 0.02 * tonumber(GlobalsGetValue("souls.enemy_soul_eye", "1")),
        min_count	= 1,
        max_count	= 1,
        entity 	= "data/entities/animals/moldos_soul_eye.xml",
    })
end

function spawn_soulshop(x, y)
    local item = GenerateSoulShopItem(x, y, 10)
end