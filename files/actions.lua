dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local a = {
	{
		id          = "REAPING_SHOT",
		name 		= "Reaping Shot",
		description = "Causes enemies to drop their souls on death",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4,5,6",
		spawn_probability                 = "0.7,1,1,1,0.7,0.7,0.7",
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
		description = "Causes enemies in a large field to drop their souls on death",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.3,0.1,0.2,0.5,0.4",
		price = 140,
		mana = 60,
		max_uses = 15,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "SOULS_TO_POWER",
		name 		= "Souls to Power",
		description = "Consumes a portion of your souls to increase a projectile's damage",
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
		description = "Fires 3 projectiles",
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
		description = "Fires a single powerful projectile",
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
		description = "Fires a single projectile",
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
		description = "Expels a soul in the form of a magical projectile",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_blast.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_blast/soul_blast.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,1,1,1,1",
		price = 200,
		mana = 50,
		max_uses = 20,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_blast/soul_blast.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},
	{
		id          = "SOUL_SPEED",
		name 		= "Soul Speed",
		description = "Increases the power and speed of your spells at the cost of a soul",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_speed.png",
		--related_extra_entities = { "mods/tales_of_kupoli/files/entities/misc/soul_speed.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "0.7,1,1,0.7,0.7,0.7",
		price = 120,
		mana = 15,
		action 		= function()
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
		description = "Enables your wand to cut the souls from your enemies",
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
		description = "Missile time",
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
		description = "Detonates a soul to produce an explosion",
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
		description = "Fires a very sticky projectile",
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
		description = "Rain down bombs and also poison",
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
	{
		id = "SNIPER_BEAM",
		name = "Sniper Laser Sight",
		description = "Sniper Laser Sight",
        sprite = "mods/tales_of_kupoli/files/spell_icons/sniper_beam.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level                       = "1,2,3",
		spawn_probability                 = "0.7,0.7,0.7",
		price = 0,
		mana = 0,
		custom_xml_file = "mods/tales_of_kupoli/files/entities/misc/sniper_sight.xml",
		action = function()
			draw_actions( 1, true )
		end,
	},
	{
		id          = "WORM_ENHANCER",
		name 		= "???",
		description = "Hello Jättimato",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/worm_enhancer.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/worm_enhancer/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "", 
		spawn_probability                 = "",
		price = 0,
		mana = 100,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/worm_enhancer/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
			shot_effects.recoil_knockback = 40.0
		end,
	},
	{
		id          = "SUMMON_RAINWORM",
		name 		= "Copi's Thing",
		description = "there but for the grace of God go I",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/summon_rainworm.png",
		related_projectiles	= {"data/entities/animals/boss_pit/boss_pit.xml"},
		never_unlimited		= true,
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 700,
		max_uses    = 1,
		--custom_xml_file = "mods/tales_of_kupoli/files/entities/animals/boss_rainworm/spell/card.xml",
		action 		= function()
			--add_projectile("mods/tales_of_kupoli/files/entities/animals/boss_rainworm/spell/spell.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tuntija_hoard/spell.xml")
			c.fire_rate_wait = c.fire_rate_wait + 100
			current_reload_time = current_reload_time + 60
		end,
	},
	{
		id          = "RANDOM_HOMING",
		name 		= "Random Homing",
		description = "Makes a projectile move towards your foes in a random manner",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/random_homing.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_pyramid",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.3,0.1,0.1,0.5",
		price = 130,
		mana = 45,
		action 		= function( recursion_level, iteration )
			SetRandomSeed( GameGetFrameNum() + #deck, GameGetFrameNum() + 133 )
			
			local homingspell = ""
			local pool = {
				"data/entities/misc/homing_rotate.xml,",
				"data/entities/misc/homing_accelerating.xml,",
				"data/entities/misc/homing_short.xml,",
				"data/entities/misc/homing.xml,",
				"data/entities/misc/homing_area.xml,",
			}

			homingspell = pool[math.random(1, #pool)]

			c.extra_entities = c.extra_entities .. homingspell .. "data/entities/particles/tinyspark_white.xml,"
		end,
	},
	{
		id          = "LIGHT_BULLET_TIER_2",
		name 		= "Large Spark Bolt",
		description = "A not so weak but enchanting sparkling projectile",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/large_sparkbolt.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/large_sparkbolt/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4,5",
		spawn_probability                 = "1,1,1,0.5",
		price = 180,
		mana = 15,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/large_sparkbolt/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees - 1.0
			c.damage_critical_chance = c.damage_critical_chance + 5
		end,
	},
	{
		id          = "WATER_ESSENCE_PROJ",
		name 		= "Water Essence Shot",
		description = "Converts nearby materials to lava upon landing",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/water_essence_proj.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/essencewand_water/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 250,
		mana = 20,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/essencewand_water/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
		end,
	},
	{
		id          = "BLOOD_TO_STEAM",
		name 		= "Blood to steam",
		description = "Makes any blood within a projectile's range turns into steam",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/blood_to_steam.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/misc/blood_to_steam.xml", "data/entities/particles/tinyspark_red.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4",
		spawn_probability                 = "0.3,0.3,0.3",
		price = 80,
		mana = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/blood_to_steam.xml,data/entities/particles/tinyspark_red.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 10
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SPELLERIOPHAGE",
		name 		= "Spelleriophage",
		description = "Makes enemies cast a copy of the spell on death",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/spelleriophage.png",
		--sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		--spawn_requires_flag = "card_unlocked_mestari",
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "2,3,4,5,10",
		spawn_probability                 = "0.7,0.7,0.8,0.9,0.2",
		price = 100,
		mana = 40,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/add_mortem_trigger/add.xml,"
			draw_actions( 1, true )
		end
	},
	{
		id          = "SOUL_IS_MANA",
		name 		= "Soul is Mana",
		description = "The next spell is casted with a soul instead of using mana",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_is_mana.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4,5,6,10",
		spawn_probability                 = "0.7,0.7,1,1,0.7,0.7,0.7,0.2",
		price = 140,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			
			if GetSoulsCount("all") > 0 then
				local data = {}

				if #deck > 0 then
					data = deck[1]
				else
					data = nil
				end

				if data ~= nil then
					if GetSoulsCount("all") <= 0 then
						GamePrint("You have no souls!")
						return
					end
					data.mana = 0
					RemoveSouls(1)
				end

				c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed_fx.xml,"
			elseif GetSoulsCount("all") <= 0 then
				GamePrint("You have no souls!")
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAP_MANY",
		name 		= "Reap Many",
		description = "All enemies on screen are marked to drop their soul",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reap_many.png",
		related_extra_entities	= {"mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "2,3,4,5,6,10",
		spawn_probability                 = "0.1,0.1,0.2,0.5,0.4,0.1",
		price = 250,
		max_uses = 5,
		mana = 130,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{
		id          = "GILDED_SOULS_TO_GOLD", -- this just doesnt work and i dont know why
		name 		= "Gilded Souls to Gold",
		description = "Turns your Gilded souls into gold",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/gilded_souls_to_gold.png",
		--related_extra_entities	= {"mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.7",
		price = 200,
		mana = 100,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			
			if GetSoulsCount("gilded") == nil then return end

			if GetSoulsCount("gilded") > 0 then

				local player = GetPlayer()

				if player == nil then return end

				local comp_wallet = EntityGetFirstComponentIncludingDisabled( player, "WalletComponent" )

				local money_to_give = 0

				if comp_wallet ~= nil and player ~= nil then
					local money = ComponentGetValue2( comp_wallet, "money" )

					money_to_give = 100 * GetSoulsCount("gilded") * math.ceil(money / 400)
					-- if you have 1000 gold, each soul will give you 250

					if money_to_give < 100 then
						money_to_give = 100
					end

					for i=1,GetSoulsCount("gilded") do
						RemoveSoul("gilded")
					end

					money = money + money_to_give

					ComponentSetValue2(comp_wallet, "money", money)
				end

			elseif GetSoulsCount("gilded") <= 0 then
				GamePrint("You have no gilded souls!")
			end
		end,
	},
	{
		id          = "SOUL_BATTERY",
		name 		= "Soul Battery",
		description = "Casts the whole wand with souls instead of mana",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_battery.png",
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.3,0.7,0.7,0.5",
		price = 160,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

			local amount = 0
			local souls_to_use = 0
			
			if GetSoulsCount("all") > 0 then
				local this = {}

				if #deck > 0 then
					this = deck[1]
				else
					this = nil
				end

				for i,data in ipairs(deck) do
					amount = amount + data.mana
				end

				souls_to_use = math.ceil(amount / 200)

				if GetSoulsCount("all") > souls_to_use then
					RemoveSouls(souls_to_use)
					for i,data in ipairs(deck) do
						data.mana = 0
						c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed_fx.xml,"
					end
				else
					GamePrint("You do not have enough souls!")
				end
			elseif GetSoulsCount("all") <= 0 then
				GamePrint("You do not have enough souls!")
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_GUARD",
		name 		= "Soul Guard",
		description = "Releases up to eight souls to guard you from harm",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_guard.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_guard/start.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,1,1,1,1",
		price = 130,
		mana = 60,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_guard/start.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "SUMMON_SUN",
		name 		= "Summon Sun",
		description = "I believe we did",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/summon_sun.png",
		related_projectiles	= {"data/entities/items/pickup/sun/newsun.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 1000,
		mana = 1000,
		max_uses = 1,
		is_dangerous_blast = true,
		never_unlimited = true,
		action 		= function()
			local suns = {
				"mods/tales_of_kupoli/files/entities/sun/newsun_green.xml",
				"mods/tales_of_kupoli/files/entities/sun/newsun_red.xml",
				"data/entities/items/pickup/sun/newsun_dark.xml",
				"data/entities/items/pickup/sun/newsun.xml",
			}
			local x, y = EntityGetTransform(GetUpdatedEntityID())
			if x ~= nil then
				SetRandomSeed(x, y+GameGetFrameNum())
			end
			add_projectile(suns[math.random(1,#suns)])
			--EntityLoad(suns[math.random(1,#suns)], x, y)
			c.fire_rate_wait = c.fire_rate_wait + 100
			c.screenshake = c.screenshake + 10
		end,
	},
	{
		id          = "TRIGGER_RETURN",
		name 		= "Triggerable Return",
		description = "Cast once to mark a point. Cast again to return to that point",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/triggerable_return.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/triggerable_return/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "5,6",
		spawn_probability                 = "0.6,0.6",
		price = 110,
		mana = 50,
		action 		= function()
			local state = 1
			local shooter = GetUpdatedEntityID()

			if #EntityGetWithTag("kupoli_trigger_return") > 0 then
				local targets = EntityGetWithTag("kupoli_trigger_return")
				for i=1,#targets do
					local x, y = EntityGetTransform(targets[i])
					EntityKill(targets[i])
					EntitySetTransform(shooter, x, y)
				end
				state = 1
			else
				add_projectile("mods/tales_of_kupoli/files/entities/projectiles/triggerable_return/projectile.xml")
				state = 2
			end

			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees - 2.0
		end,
	},
}

for i,v in ipairs(a) do
	v.id = "KUPOLI_" .. v.id
    table.insert(actions, v)
end