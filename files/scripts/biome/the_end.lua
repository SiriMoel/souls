dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

RegisterSpawnFunction(0xff28DDE7, "spawn_soulshop")

function spawn_soulshop(x, y)
    local item = GenerateSoulShopItem(x, y, 10)
end