dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local a = {
	{
		id          = "REAPING_SHOT",
		name 		= "Reaping Shot",
		description = "Causes enemies to drop their souls on death.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4,5,6",
		spawn_probability                 = "0.7,0.7,1,1,0.7,0.7,0.7",
		price = 120,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 5
			--ce.mana_multiplier = ce.mana_multiplier * 1.1 -- wonderful testing
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_FIELD",
		name 		= "Circle of Reaping",
		description = "Causes enemies in a large field to drop their souls on death.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.3,0.1,0.2,0.5,0.4",
		price = 200,
		mana = 70,
		max_uses = 5,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "SOULS_TO_POWER",
		name 		= "Souls to Power",
		description = "Consumes a portion of your souls to increase a projectile's damage.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/souls_to_power.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/souls_to_power/souls_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6,10",
		spawn_probability                 = "1,0.9,0.9,0.9,0.8,0.8",
		price = 120,
		mana = 50,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/souls_to_power/souls_to_power.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	--[[{
		id          = "SOLAR_GLUTTONY", 
		name 		= "Solar Gluttony",
		description = "Eat the Sun.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/solar_gluttony.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/solar_gluttony/solar_gluttony.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 275,
		max_uses = 30,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/solar_gluttony/solar_gluttony.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},]]--
	{
		id          = "REAPING_HALO",
		name 		= "Reaping Halo",
		description = "No Ikkuna. This is not a portal.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_halo.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/reaping_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.3,0.5,0.5",
		price = 200,
		mana = 150,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reaping_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
		end,
	},
	{
		id = "HIISI_SHOTGUN",
		name = "Hiisi Shotgun Shell",
		description = "Fires 3 projectiles.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_shotgun.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml", 3},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70, -- does this even need to be set?
		mana = 30, -- make this the same as buckshot + 25%
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			c.spread_degrees = c.spread_degrees + 13.0
		end,
	},
	{
		id = "HIISI_SNIPER",
		name = "Hiisi Sniper Shot",
		description = "Fires a single powerful projectile.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_sniper.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisisniper/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 70,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisisniper/projectile.xml")
		end,
	},
	{
		id = "HIISI_PISTOL",
		name = "Hiisi Pistol Shot",
		description = "Fires a single projectile.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_pistol.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisipistol/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 50,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisipistol/projectile.xml")
		end,
	},
	--[[{
		id = "DIAHEART_LENSE", -- riven mod
		name = "Diamond Lense",
		sprite = "mods/tales_of_kupoli/files/spell_icons/rivenmod.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "",
		spawn_probability = "",
		price = 0,
		mana = 50,
		custom_xml_file = "mods/tales_of_kupoli/files/entities/misc/dhl.xml",
		action = function()

			local target = "LIGHT_BULLET"
			

			if (#deck > 0) then
				if deck[1].id == target then
					-- add stats
					c.fire_rate_wait = 100
					c.speed_multiplier = c.speed_multiplier * 10
					GamePrint("hi")
				end
			end
			GamePrint("riven action function ran")

			draw_actions( 1, true )
		end,
	},]]--
	{
		id          = "SOUL_BLAST",
		name 		= "Soul Blast",
		description = "Expels a soul in the form of a magic missile. Adapts to whichever soul was consumed!",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_blast.png",
		related_projectiles	= {"mods/moles_souls/files/entities/projectiles/soul_blast.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,1,1,1,1",
		price = 200,
		mana = 60,
		max_uses = 10,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_blast/soul_blast.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
		end,
	},
	{
		id          = "SOUL_SPEED",
		name 		= "Soul Speed",
		description = "Increases the power and speed of your spells at the cost of a soul.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_speed.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/misc/soul_speed.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "0.7,1,1,0.7,0.7,0.7",
		price = 120,
		mana = 15,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed.xml,"
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			
			if GetSoulsCount("all") > 0 then
				c.speed_multiplier = c.speed_multiplier * 3
				c.damage_projectile_add = c.damage_projectile_add + 0.5

				c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed_fx.xml,"

				--[[
				local entity_id = GetUpdatedEntityID()
				local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/particles/souls_to_power.xml", x, y)
				EntityAddChild( entity_id, effect_id )
				]]--

				RemoveSouls(1)
			elseif GetSoulsCount("all") <= 0 then
				GamePrint("You have no souls!")
			end
			draw_actions( 1, true )
		end,
	},
	{
		id			= "REAPER_BLADE",
		name		= "Reaper Blade",
		description = "Enables your wand to cut the souls from your enemies.",
		sprite     	= "mods/tales_of_kupoli/files/spell_icons/reaper_blade.png",
		type        = ACTION_TYPE_PASSIVE,
		spawn_level      	= "2,3,4,5",
		spawn_probability	= "0.3,0.3,0.3,0.3",
		price				= 80,
		mana				= 0,
		custom_xml_file = "mods/tales_of_kupoli/files/entities/misc/reaper_blade.xml",
		action = function()
		end,
	},
	{
		id = "ROCKET_ROLL",
		name = "Rocket Roll",
		description = "Missile time.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/rocket_roll.png",
		related_projectiles	= { "mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml", 5},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 100,
		mana = 150,
		max_uses = 10,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml")
		end,
	},
	{
		id          = "SOUL_EXPLOSION",
		name 		= "Soul Detonation",
		description = "Detonates a soul to produce an explosion.",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_detonation.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_detonation/soul_detonation.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5",
		spawn_probability                 = "0.5,0.5,0.5,0.5",
		price = 120,
		mana = 10,
		max_uses = 30,
		custom_xml_file = "mods/tales_of_kupoli/files/entities/misc/soul_detonation.xml",
		is_dangerous_blast = true,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_detonation/soul_detonation.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
			c.screenshake = c.screenshake + 0.5
		end,
	},
	{
		id = "HIISI_GLUE_SHOT",
		name = "Hiisi Glue Shot",
		description = "Fires a very sticky projectile.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_glue_shot.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisigluegun/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 50,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisigluegun/projectile.xml")
		end,
	},
	{
		id = "HIISI_POISON_SHOT",
		name = "Hiisi Poison Shot",
		description = "Rain down bombs and also poison.",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_poison_shot.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisipoisongun/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 60,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisipoisongun/projectile.xml")
		end,
	},
	{ -- ALTERANT
		id          = "ALTERANT_POISONER_KIT", 
		name 		= "Alterant: Poisoner Kit",
		description = "",
		sprite 		= "mods/tales_of_kupoli/files/entities/alterants/alterant_ui_spell.png", --"mods/tales_of_kupoli/files/entities/alterants/poisonerkit/alterant_ui.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 0,
		action 		= function()
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_poison.xml,"
			c.trail_material = c.trail_material .. "poison,"
			c.trail_material_amount = c.trail_material_amount + 12
			draw_actions( 1, true )
		end,
	},
	{ -- ALTERANT
		id          = "ALTERANT_HOMING_RAG",
		name 		= "Alterant: Rag of Homing",
		description = "",
		sprite 		= "mods/tales_of_kupoli/files/entities/alterants/alterant_ui_spell.png", --"mods/tales_of_kupoli/files/entities/alterants/homingrag/alterant_ui.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 0,
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/homing_accelerating.xml,"
			draw_actions( 1, true )
		end,
	},
}

for i,v in ipairs(a) do
	v.id = "KUPOLI_" .. v.id
    table.insert(actions, v)
end