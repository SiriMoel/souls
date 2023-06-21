dofile_once("mods/moles_things/files/scripts/utils.lua")
dofile_once("mods/moles_things/files/scripts/molebiomes.lua")

if g_small_enemies == nil then return end

table.insert(g_small_enemies, {
    prob = 0.15,
    min_count = 1,
    max_count = 1,
    entity = "mods/moles_things/files/entities/moles/spawner.xml",
})