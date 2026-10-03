local prob_mult = 1
if GameHasFlagRun("souls_init") then
    prob_mult = tonumber(GlobalsGetValue("souls.enemy_soul_rogue", "1"))
end
table.insert(g_small_enemies, {
    prob   		= 0.02 * prob_mult,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/souls_soul_rogue.xml",
})