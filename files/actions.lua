dofile_once("mods/moles_things/files/scripts/utils.lua")

local a = {
	{
		id          = "REAPING_SHOT",
		name 		= "Reaping Shot",
		description = "Causes enemies to drop their souls on death. \nMana Cost x 1.1",
		sprite 		= "mods/moles_things/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/moles_things/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5",
		spawn_probability                 = "1,1,1,1,1",
		price = 120,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/moles_things/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 5
			ce.mana_multiplier = ce.mana_multiplier * 1.1 -- wonderful testing
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_FIELD", 
		name 		= "Circle of Reaping",
		description = "Causes enemies in a large field to drop their souls on death.",
		sprite 		= "mods/moles_things/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/moles_things/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5",
		spawn_probability                 = "1,1,1,1",
		price = 200,
		mana = 70,
		max_uses = 5,
		action 		= function()
			add_projectile("mods/moles_things/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "SOULS_TO_POWER", 
		name 		= "Souls to Power",
		description = "Consumes a portion of your souls to increase a projectile's damage.",
		sprite 		= "mods/moles_things/files/spell_icons/souls_to_power.png",
		related_extra_entities = { "mods/moles_things/files/entities/projectiles/souls_to_power/souls_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5",
		spawn_probability                 = "1,1,1,1,1",
		price = 120,
		mana = 50,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/moles_things/files/entities/projectiles/souls_to_power/souls_to_power.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOLAR_GLUTTONY", 
		name 		= "Solar Gluttony",
		description = "Eat the Sun.",
		sprite 		= "mods/moles_things/files/spell_icons/solar_gluttony.png",
		related_projectiles	= {"mods/moles_things/files/entities/projectiles/solar_gluttony/solar_gluttony.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 275,
		max_uses = 30,
		action 		= function()
			add_projectile("mods/moles_things/files/entities/projectiles/solar_gluttony/solar_gluttony.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "REAPING_HALO", -- may need to be rebalanced
		name 		= "Reaping Halo",
		description = "Fires a halo of energy that homes and causes enemies to drop their souls.",
		sprite 		= "mods/moles_things/files/spell_icons/soul_halo.png",
		related_projectiles	= {"mods/moles_things/files/entities/projectiles/reaping_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4,5", 
		spawn_probability                 = "1,1,1,1", 
		price = 160,
		mana = 120,
		action 		= function()
			add_projectile("mods/moles_things/files/entities/projectiles/reaping_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id = "HIIS_SHOTGUN", -- MOULD N
		name = "Hiisi Shotgun Shell",
		description = "Fires 3 projectiles.",
        sprite = "mods/moles_things/files/spell_icons/hiisi_shotgun.png",
		related_projectiles	= {"mods/moles_things/files/entities/items/hiisishotgun/projectile.xml", 3},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70, -- does this even need to be set?
		mana = 50, -- make this the same as buckshot + 25%
		action = function()
			add_projectile("mods/moles_things/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/moles_things/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/moles_things/files/entities/items/hiisishotgun/projectile.xml")
			c.spread_degrees = c.spread_degrees + 13.0
		end,
	},
}

for i,v in ipairs(a) do
	v.id = "MOLETHING_" .. v.id
    table.insert(actions, v)
end

--print(#a .. " actions successfully added!")