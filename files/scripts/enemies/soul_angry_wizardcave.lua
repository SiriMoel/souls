local prob_mult = 1
if GameHasFlagRun("souls_init") then
    prob_mult = tonumber(GlobalsGetValue("souls.enemy_soul_angry", "1"))
end
table.insert(g_big_enemies, {
    prob   		= 0.01 * prob_mult,
	min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/moldos_soul_angry.xml",
})