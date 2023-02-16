local a = {
	{
		id          = "REAPING_SHOT",
		name 		= "Reaping Shot",
		description = "Causes enemies to drop their souls on death.",
		sprite 		= "mods/moles_n_more/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/moles_n_more/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5",
		spawn_probability                 = "1,1,1,1,1",
		price = 120,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/moles_n_more/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 5
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_FIELD",
		name 		= "Circle of Reaping",
		description = "Causes enemies in a large field to drop their souls on death.",
		sprite 		= "mods/moles_n_more/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/moles_n_more/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5", 
		spawn_probability                 = "1,1,1,1", 
		price = 200,
		mana = 70,
		max_uses = 5,
		action 		= function()
			add_projectile("mods/moles_n_more/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "SOULS_TO_POWER",
		name 		= "Souls to Power",
		description = "Consumes a portion of your souls to increase a projectile's damage.",
		sprite 		= "mods/moles_n_more/files/spell_icons/souls_to_power.png",
		related_extra_entities = { "mods/moles_n_more/files/entities/projectiles/souls_to_power/souls_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5",
		spawn_probability                 = "1,1,1,1,1", 
		price = 120,
		mana = 50,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/moles_n_more/files/entities/projectiles/souls_to_power/souls_to_power.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
}

for i,v in ipairs(a) do
	v.id = "MNM_" .. v.id
    table.insert(actions, v)
	print(#a .. " actions successfully added!")
end