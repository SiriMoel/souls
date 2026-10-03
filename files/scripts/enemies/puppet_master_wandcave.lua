local prob_mult = 1
if GameHasFlagRun("souls_init") then
    prob_mult = tonumber(GlobalsGetValue("souls.enemy_puppet_master", "1"))
end
table.insert(g_small_enemies, {
	prob   		= 0.03 * prob_mult,
	min_count	= 1,
	max_count	= 1,
	entity 	= "data/entities/animals/souls_puppet_master.xml"
})