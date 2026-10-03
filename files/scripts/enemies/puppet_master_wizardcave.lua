local prob_mult = 1
if GameHasFlagRun("souls_init") then
    prob_mult = tonumber(GlobalsGetValue("souls.enemy_puppet_master", "1"))
end
table.insert(g_small_enemies, {
	prob   		= 0.05 * prob_mult,
	min_count	= 1,
	max_count	= 1,
	entity 	= "data/entities/animals/souls_puppet_master.xml"
})
table.insert(g_big_enemies, {
	prob   		= 0.02 * prob_mult,
	min_count	= 1,
	max_count	= 1,    
	entities 	= { "data/entities/animals/souls_puppet_master.xml", "data/entities/animals/wizard_tele.xml", },
})