--[[if GlobalsGetValue("souls.enable_enemies", "true") == "true" then
	table.insert(g_small_enemies, {
	    prob   		= 0.05 * tonumber(GlobalsGetValue("souls.enemy_puppet_master", "1")),
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/animals/moldos_puppet_master.xml"
	})
	table.insert(g_big_enemies, {
    	prob   		= 0.01 * tonumber(GlobalsGetValue("souls.enemy_soul_angry", "1")),
	    min_count	= 1,
    	max_count	= 1,
    	entity 	= "data/entities/animals/moldos_soul_angry.xml",
	})
	table.insert(g_big_enemies, {
		prob   		= 0.02 * tonumber(GlobalsGetValue("souls.enemy_puppet_master", "1")),
		min_count	= 1,
		max_count	= 1,    
		entities 	= { "data/entities/animals/moldos_puppet_master.xml", "data/entities/animals/wizard_tele.xml", },
	})
end]]