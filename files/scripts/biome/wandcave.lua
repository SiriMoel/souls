--[[if GlobalsGetValue("souls.enable_enemies", "true") == "true" then
	table.insert(g_small_enemies, {
	    prob   		= 0.03 * tonumber(GlobalsGetValue("souls.enemy_puppet_master", "1")),
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/animals/moldos_puppet_master.xml"
	})
end]]