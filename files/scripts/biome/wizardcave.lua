table.insert(g_small_enemies, {
    prob   		= 0.05,
	min_count	= 1,
	max_count	= 1,
	entity 	= "data/entities/animals/moldos_puppet_master.xml"
})
--[[table.insert(g_small_enemies, {
    prob   		= 0.04,
	min_count	= 1,
	max_count	= 1,
	entity 	= "data/entities/animals/kupoli_tank_mage.xml"
})]]

table.insert(g_big_enemies, {
    prob   		= 0.01,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/moldos_soul_angry.xml",
})
table.insert(g_big_enemies, {
	prob   		= 0.02,
	min_count	= 1,
	max_count	= 1,    
	entities 	= { "data/entities/animals/moldos_puppet_master.xml", "data/entities/animals/wizard_tele.xml", "data/entities/animals/kupoli_tank_mage.xml" },
})
--[[table.insert(g_big_enemies, {
    prob   		= 0.02,
	min_count	= 2,
	max_count	= 3,
	entity 	= "data/entities/animals/kupoli_tank_mage.xml"
})]]