dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/molebiomes.lua")

if g_small_enemies == nil then return end

table.insert(g_small_enemies, {
    prob = 0.1,
    min_count = 1,
    max_count = 1,
    entity = "mods/moles_n_more/files/entities/moles/spawner.xml",
})