table.insert(g_small_enemies, {
    prob   		= 0.1,
	min_count	= 1,
	max_count	= 1,
	entity 	= "data/entities/animals/kupoli_puppet_master.xml"
})

table.insert(g_big_enemies, {
    prob   		= 0.03,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/kupoli_soul_angry.xml",
})
table.insert(g_big_enemies, {
	prob   		= 0.1,
	min_count	= 1,
	max_count	= 1,    
	entities 	= { "data/entities/animals/kupoli_puppet_master.xml", "data/entities/animals/wizard_tele.xml" },
})
table.insert(g_big_enemies, {
	prob   		= 0.02,
	min_count	= 1,
	max_count	= 1,    
	entities 	= { "data/entities/animals/kupoli_puppet_master.xml", "data/entities/animals/wizard_tele.xml", "data/entities/animals/wizard_dark.xml", "data/entities/animals/wizard_poly.xml", "data/entities/animals/wizard_swapper.xml", "data/entities/animals/wizard_neutral.xml", "data/entities/animals/wizard_twitchy.xml", "data/entities/animals/wizard_returner.xml", "data/entities/animals/wizard_hearty.xml", "data/entities/animals/wizard_weaken.xml", "data/entities/animals/wizard_homing.xml" },
})