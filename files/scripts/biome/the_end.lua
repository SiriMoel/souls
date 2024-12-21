dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

table.insert(g_small_enemies, {
    prob   		= 0.01,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/the_end/moldos_soul_angry.xml",
})

table.insert(g_small_enemies, {
    prob   		= 0.02,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/moldos_soul_rogue.xml",
})

table.insert(g_small_enemies, {
    prob   		= 0.02,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/moldos_soul_eye.xml",
})