dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

function UpgradeTome(path, amount, is_better)
	if path == 0 then
		GamePrint("You must select an upgrade first.")
		return
	end
    local tome = EntityGetWithTag("kupoli_tome")[1]
    local comp_cost = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "upgrade_cost") or 0
    local cost = ComponentGetValue2(comp_cost, "value_int")
	local comp_path_1 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_1") or 0
    local path_1 = ComponentGetValue2(comp_path_1, "value_int")
    local comp_path_2 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_2") or 0
    local path_2 = ComponentGetValue2(comp_path_2, "value_int")
    local comp_path_3 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_3") or 0
    local path_3 = ComponentGetValue2(comp_path_3, "value_int")
	local comp_path_4 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_4") or 0
    local path_4 = ComponentGetValue2(comp_path_4, "value_int")
	local comp_path_5 = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "path_5") or 0
    local path_5 = ComponentGetValue2(comp_path_5, "value_int")
    local ac = EntityGetFirstComponentIncludingDisabled( tome, "AbilityComponent" ) or 0
    local cap = tonumber( ComponentObjectGetValue( ac, "gun_config", "deck_capacity" ) ) -- deck capacity 
    local rt = tonumber( ComponentObjectGetValue( ac, "gun_config", "reload_time" ) ) -- reload time
    local frw = tonumber( ComponentObjectGetValue( ac, "gunaction_config", "fire_rate_wait" ) ) -- fire rate wait
	local mcs = tonumber( ComponentGetValue2( ac, "mana_charge_speed" ) ) -- mana charge speed
	local mm = tonumber( ComponentGetValue2( ac, "mana_max" ) ) -- mana max
	if is_better then
		cost = math.floor((cost / 2) + 0.5)
	end
	if GetSoulsCount("all") >= cost then
		RemoveSouls(cost)
		if path == 1 then -- upgrade capacity
			GamePrint("Upgrading capacity!")
			for i=1,amount do
				cap = cap + 3
				if cap > 30 then
					cap = 30
					GamePrint("Max capacity reached!")
				end
				rt = rt * 1
				frw = frw * 1
			end
			path_1 = path_1 + amount
		end
		if path == 2 then -- upgrade recharge time
			GamePrint("Upgrading recharge time!")
			for i=1,amount do
				cap = cap - 2
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				rt = rt * 0.7
				frw = frw * 1.1
			end
			path_2 = path_2 + amount
		end
		if path == 3 then -- upgrade cast delay
			GamePrint("Upgrading cast delay!")
			for i=1,amount do
				cap = cap - 2
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				rt = rt * 1.1
				frw = frw * 0.7
			end
			path_3 = path_3 + amount
		end
		if path == 4 then -- mana max
			for i=1,amount do
				cap = cap - 2
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				mm = mm * 1.45
			end
			path_4 = path_4 + amount
		end
		if path == 5 then -- mana charge speed
			for i=1,amount do
				cap = cap - 2
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				mcs = mcs * 1.45
			end
			path_5 = path_5 + amount
		end
		cost = cost * 1.25
		cost = math.floor(cost + 0.5)
		GamePrint("Next upgrade will cost " .. cost .. " souls.")
		if cost > 30 then
			cost = 30
		end
		ComponentSetValue2(comp_path_1, "value_int", path_1)
		ComponentSetValue2(comp_path_2, "value_int", path_2)
		ComponentSetValue2(comp_path_3, "value_int", path_3)
		ComponentSetValue2(comp_path_4, "value_int", path_4)
		ComponentSetValue2(comp_path_5, "value_int", path_5)
		ComponentSetValue2(comp_cost , "value_int", cost)
		ComponentObjectSetValue( ac, "gun_config", "deck_capacity", tostring(cap) )
		ComponentObjectSetValue( ac, "gun_config", "reload_time", tostring(rt) )
		ComponentObjectSetValue( ac, "gunaction_config", "fire_rate_wait", tostring(frw) )
		ComponentSetValue2( ac, "mana_charge_speed", mcs )
		ComponentSetValue2( ac, "mana_max", mm )
	end
end

actions_to_insert = {
	{
		id          = "REAPING_SHOT", -- the basis of the whole mod or something
		name 		= "$action_kupoli_reaping_shot",
		description = "$actiondesc_kupoli_reaping_shot",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "0,1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1,1",
		price = 100,
		mana = 10,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 5
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_FIELD",
		name 		= "$action_kupoli_reaping_field",
		description = "$actiondesc_kupoli_reaping_field",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		inject_after = "SHIELD_FIELD",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.3,0.1,0.2,0.5,0.4",
		price = 140,
		mana = 30,
		max_uses = 15,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "SOULS_TO_POWER",
		name 		= "$action_kupoli_souls_to_power",
		description = "$actiondesc_kupoli_souls_to_power",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/souls_to_power.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/souls_to_power/souls_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SPELLS_TO_POWER",
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
		inject_after = "",
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
		name 		= "$action_kupoli_reaping_halo",
		description = "$actiondesc_kupoli_reaping_halo",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reaping_halo.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/reaping_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "FIREWORK",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.1,0.2,0.5",
		price = 200,
		mana = 150,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reaping_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
		end,
	},
	{
		id = "HIISI_SHOTGUN",
		name = "$action_kupoli_hiisi_shotgun",
		description = "$actiondesc_kupoli_hiisi_shotgun",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_shotgun.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml", 3},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "BOMB_CART",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 30,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisishotgun/projectile.xml")
			c.spread_degrees = c.spread_degrees + 13.0
		end,
	},
	{
		id = "HIISI_SNIPER",
		name = "$action_kupoli_hiisi_sniper",
		description = "$actiondesc_kupoli_hiisi_sniper",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_sniper.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisisniper/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_HIISI_SHOTGUN",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 30,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisisniper/projectile.xml")
		end,
	},
	{
		id = "HIISI_PISTOL",
		name = "$action_kupoli_hiisi_pistol",
		description = "$actiondesc_kupoli_hiisi_pistol",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_pistol.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisipistol/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_HIISI_SNIPER",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 20,
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
		name 		= "$action_kupoli_soul_blast",
		description = "$actiondesc_kupoli_soul_blast",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_blast.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_blast/soul_blast.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "PIPE_BOMB_DEATH_TRIGGER",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,1,1,1,1",
		price = 120,
		mana = 40,
		max_uses = 20,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_blast/soul_blast.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},
	{
		id          = "SOUL_SPEED",
		name 		= "$action_kupoli_soul_speed",
		description = "$actiondesc_kupoli_soul_speed",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_speed.png",
		--related_extra_entities = { "mods/tales_of_kupoli/files/entities/misc/soul_speed.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "BLOODLUST",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "0.5,0.5,1,1,1,0.7",
		price = 120,
		mana = 10,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			
			if not reflecting then
				if GetSoulsCount("all") > 0 then
					c.speed_multiplier = c.speed_multiplier * 3
					c.damage_projectile_add = c.damage_projectile_add + 0.5
					c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed_fx.xml,"
					RemoveSouls(1)
				elseif GetSoulsCount("all") <= 0 then
					GamePrint("You have no souls!")
				end
			end
			draw_actions( 1, true )
		end,
	},
	{
		id			= "REAPER_BLADE",
		name		= "$action_kupoli_reaper_blade",
		description = "$actiondesc_kupoli_reaper_blade",
		sprite     	= "mods/tales_of_kupoli/files/spell_icons/reaper_blade.png",
		type        = ACTION_TYPE_PASSIVE,
		inject_after = "TORCH_ELECTRIC",
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
		name = "$action_kupoli_rocket_roll",
		description = "$actiondesc_kupoli_rocket_roll",
        sprite = "mods/tales_of_kupoli/files/spell_icons/rocket_roll.png",
		related_projectiles	= { "mods/tales_of_kupoli/files/entities/items/mechakolmiwand/rocket_roll.xml", 5},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "MISSILE",
		spawn_level = "",
		spawn_probability = "",
		price = 100,
		mana = 100,
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
		name 		= "$action_kupoli_soul_explosion",
		description = "$actiondesc_kupoli_soul_explosion",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_detonation.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_detonation/soul_detonation.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		inject_after = "ALCOHOL_BLAST",
		spawn_level                       = "2,3,4,5",
		spawn_probability                 = "0.5,0.5,0.5,0.5",
		price = 120,
		mana = 70,
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
		name = "$action_kupoli_hiisi_glue_shot",
		description = "$actiondesc_kupoli_hiisi_glue_shot",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_glue_shot.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisigluegun/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_HIISI_PISTOL",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 30,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisigluegun/projectile.xml")
		end,
	},
	{
		id = "HIISI_POISON_SHOT",
		name = "$action_kupoli_hiisi_poison_shot",
		description = "$actiondesc_kupoli_hiisi_poison_shot",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_poison_shot.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisipoisongun/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_HIISI_GLUE_SHOT",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 30,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisipoisongun/projectile.xml")
		end,
	},
	{
		id = "SNIPER_BEAM",
		name = "$action_kupoli_sniper_beam",
		description = "$actiondesc_kupoli_sniper_beam",
        sprite = "mods/tales_of_kupoli/files/spell_icons/sniper_beam.png",
		type = ACTION_TYPE_PASSIVE,
		inject_after = "KUPOLI_REAPER_BLADE",
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
		name 		= "$action_kupoli_worm_enhancer",
		description = "$actiondesc_kupoli_worm_enhancer",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/worm_enhancer.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/worm_enhancer/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "WORM_RAIN",
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
		name 		= "$action_kupoli_summon_rainworm",
		description = "$actiondesc_kupoli_summon_rainworm",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/summon_rainworm.png",
		related_projectiles	= {"data/entities/animals/boss_pit/boss_pit.xml"},
		never_unlimited		= true,
		type 		= ACTION_TYPE_OTHER,
		inject_after = "KUPOLI_WORM_ENHANCER",
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
		name 		= "$action_kupoli_random_homing",
		description = "$actiondesc_kupoli_random_homing",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/random_homing.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_pyramid",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "HOMING_AREA",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.3,0.1,0.1,0.5",
		price = 130,
		mana = 50,
		action 		= function( recursion_level, iteration )
			SetRandomSeed( GameGetFrameNum() + #deck, GameGetFrameNum() + 133 )	
			local homingspell = ""
			local pool = {
				"data/entities/misc/homing_rotate.xml,",
				"data/entities/misc/homing_accelerating.xml,",
				"data/entities/misc/homing_short.xml,",
				"data/entities/misc/homing.xml,",
			}
			homingspell = pool[math.random(1, #pool)]
			c.extra_entities = c.extra_entities .. homingspell .. "data/entities/particles/tinyspark_white.xml,"
		end,
	},
	{
		id          = "LIGHT_BULLET_TIER_2",
		name 		= "$action_kupoli_big_sparkbolt",
		description = "$actiondesc_kupoli_big_sparkbolt",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/large_sparkbolt.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/large_sparkbolt/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "LIGHT_BULLET_TRIGGER",
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
		name 		= "$action_kupoli_wateressence",
		description = "$actiondesc_kupoli_wateressence",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/water_essence_proj.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/essencewand_water/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KANTELE_G",
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
		name 		= "$action_kupoli_blood_to_steam",
		description = "$actiondesc_kupoli_blood_to_steam",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/blood_to_steam.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/misc/blood_to_steam.xml", "data/entities/particles/tinyspark_red.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "TOXIC_TO_ACID",
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
		name 		= "$action_kupoli_spelleriophage",
		description = "$actiondesc_kupoli_spelleriophage",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/spelleriophage.png",
		--sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		--spawn_requires_flag = "card_unlocked_mestari",
		type 		= ACTION_TYPE_OTHER,
		inject_after = "ADD_DEATH_TRIGGER",
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
		name 		= "$action_kupoli_soul_is_mana",
		description = "$actiondesc_kupoli_soul_is_mana",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_is_mana.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "0,1,2,3,4,5,6,10",
		spawn_probability                 = "0.7,0.7,1,1,0.7,0.7,0.7,0.2",
		price = 140,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
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
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAP_MANY",
		name 		= "$action_kupoli_reap_many",
		description = "$actiondesc_kupoli_reap_many",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/reap_many.png",
		related_extra_entities	= {"mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml"},
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "X_RAY",
		spawn_level                       = "2,3,4,5,6,10",
		spawn_probability                 = "0.1,0.1,0.2,0.5,0.4,0.1",
		price = 250,
		max_uses = 5,
		mana = 100,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{
		id          = "GILDED_SOULS_TO_GOLD",
		name 		= "$action_kupoli_gilded_souls_to_gold",
		description = "$actiondesc_kupoli_gilded_souls_to_gold",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/gilded_souls_to_gold.png",
		--related_extra_entities	= {"mods/tales_of_kupoli/files/entities/projectiles/reap_many/reap_many.xml"},
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_REAP_MANY",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.7",
		price = 200,
		mana = 100,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
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
			end
		end,
	},
	{
		id          = "SOUL_BATTERY",
		name 		= "$action_kupoli_soul_battery",
		description = "$actiondesc_kupoli_soul_battery",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_battery.png",
		type 		= ACTION_TYPE_OTHER,
		inject_after = "SUMMON_PORTAL",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.5,0.5",
		price = 160,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			local amount = 0
			local souls_to_use = 0
			if not reflecting then
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
					souls_to_use = math.ceil(amount / 100)
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
			end		
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_GUARD",
		name 		= "$action_kupoli_soul_guard",
		description = "$actiondesc_kupoli_soul_guard",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_guard.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_guard/start.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "BIG_MAGIC_SHIELD",
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
		name 		= "$action_kupoli_summon_sun",
		description = "$actiondesc_kupoli_summon_sun",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/summon_sun.png",
		related_projectiles	= {"data/entities/items/pickup/sun/newsun.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		inject_after = "ALL_SPELLS",
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
		name 		= "$action_kupoli_trigger_return",
		description = "$actiondesc_kupoli_trigger_return",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/triggerable_return.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/triggerable_return/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "TELEPORT_PROJECTILE_STATIC",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.7",
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
	--[[{
		id          = "MOLDOS_INFERNO",
		name 		= "Moldos Inferno",
		description = "It is all fire",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_speed.png", -- did you know? icon
		related_extra_entities	= {"mods/tales_of_kupoli/files/entities/misc/moldos_inferno.xml"},
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.7",
		price = 180,
		mana = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/moldos_inferno.xml,"
		end,
	},]]
	{
		id          = "RANDOM_REAP",
		name 		= "$action_kupoli_random_reap",
		description = "$actiondesc_kupoli_random_reap",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/random_reap.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/random_reap/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_REAPING_SHOT",
		spawn_level                       = "3,4,5,6",
		spawn_probability                 = "0.4,0.5,0.5,0.6",
		price = 130,
		mana = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/random_reap/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 7
			draw_actions( 1, true )
		end,
	},

	{
		id          = "ALL_REAP_GILDED",
		name 		= "$action_kupoli_all_reap_gilded",
		description = "$actiondesc_kupoli_all_reap_gilded",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_gilded.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/all_reap_gilded/reaping_shot.xml" },
		spawn_requires_flag = "card_unlocked_alchemy",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "UNSTABLE_GUNPOWDER",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.05,1",
		never_unlimited = true,
		max_uses = 5,
		price = 200,
		mana = 100,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/all_reap_gilded/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 40
			draw_actions( 1, true )
		end,
	},
	{
		id          = "ALL_REAP_MAGE",
		name 		= "$action_kupoli_all_reap_mage",
		description = "$actiondesc_kupoli_all_reap_mage",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_mage.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/all_reap_mage/reaping_shot.xml" },
		spawn_requires_flag = "card_unlocked_alchemy",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_ALL_REAP_GILDED",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.05,1",
		price = 200,
		mana = 40,
		never_unlimited = true,
		max_uses = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/all_reap_mage/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "ALL_REAP_FLY",
		name 		= "$action_kupoli_all_reap_fly",
		description = "$actiondesc_kupoli_all_reap_fly",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_fly.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/all_reap_fly/reaping_shot.xml" },
		spawn_requires_flag = "card_unlocked_alchemy",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_ALL_REAP_MAGE",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.05,1",
		price = 200,
		mana = 40,
		never_unlimited = true,
		max_uses = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/all_reap_fly/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "ALL_REAP_SPIDER",
		name 		= "$action_kupoli_all_reap_spider",
		description = "$actiondesc_kupoli_all_reap_spider",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_spider.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/all_reap_spider/reaping_shot.xml" },
		spawn_requires_flag = "card_unlocked_alchemy",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_ALL_REAP_FLY",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.05,1",
		price = 200,
		mana = 40,
		never_unlimited = true,
		max_uses = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/all_reap_spider/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOULDOS",
		name 		= "$action_kupoli_souldos",
		description = "$actiondesc_kupoli_souldos",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/souldos.png",
		related_extra_entities = { "mods/tales_of_kupoli/files/entities/projectiles/souldos/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_RANDOM_REAP",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.05,1",
		price = 160,
		mana = 37,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/souldos/reaping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 15
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_BALL",
		name 		= "$action_kupoli_soul_ball",
		description = "$actiondesc_kupoli_soul_ball",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_ball.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_ball/soul_ball.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_SOUL_BLAST",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.4,0.5,0.1",
		price = 120,
		mana = 70,
		max_uses = 10,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_ball/soul_ball.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "EAT_WAND_FOR_SOULS",
		name 		= "$action_kupoli_eat_wand_for_souls",
		description = "$actiondesc_kupoli_eat_wand_for_souls",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/eat_wand_for_souls.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_GILDED_SOULS_TO_GOLD",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.6,0.7,0.5",
		price = 300,
		mana = 100,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			local card = GetUpdatedEntityID()
			local x, y = EntityGetTransform(GetPlayer())
			local wand = 0
			local souls_earned = 1
			local inv_comp = EntityGetFirstComponentIncludingDisabled(card, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local possible_types = {
				"bat",
				"fly",
				"mage",
				"orcs",
				"slimes",
				"spider",
				"worm",
				"ghost",
			}
			if wand ~= 0 then
				local acs = EntityGetComponentIncludingDisabled( wand, "AbilityComponent" )
				if acs == nil then return end
				for i,ac in ipairs(acs) do
					local rt = tonumber( ComponentObjectGetValue( ac, "gun_config", "reload_time" ) ) -- reload time
					local frw = tonumber( ComponentObjectGetValue( ac, "gunaction_config", "fire_rate_wait" ) ) -- fire rate wait
					local mcs = tonumber( ComponentGetValue2( ac, "mana_charge_speed" ) ) -- mana charge speed
					local mm = tonumber( ComponentGetValue2( ac, "mana_max" ) ) -- mana max
					local cp = tonumber( ComponentObjectGetValue( ac, "gun_config", "deck_capacity" ) ) -- capacity
					rt = rt / 50
					frw = frw / 50
					mcs = mcs / 300
					mm = mm / 300
					cp = cp / 2
					souls_earned = rt + frw + mcs + mm + cp
					souls_earned = math.ceil(souls_earned)
				end
				local children = EntityGetAllChildren(wand) or {}
				for i,v in ipairs(children) do
					if EntityHasTag(v, "card_action") then
						local comp_itemaction = EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0
            			local action_id = ComponentGetValue(comp_itemaction, "action_id") or ""
            			if action_id ~= "KUPOLI_EAT_WAND_FOR_SOULS" then
							souls_earned = souls_earned + 1
						end
					end
				end
				if souls_earned > 20 then
					souls_earned = 20 + ((souls_earned - 20) * 0.5)
				end
				souls_earned = math.floor(souls_earned)
				for i=1,souls_earned do
					local which = possible_types[math.random(1,#possible_types)]
					AddSoul(which)
					if ModSettingGet("tales_of_kupoli.say_soul") == true then
						GamePrint("You have acquired a " .. SoulNameCheck(which) .. " soul!")
					end
				end
				GamePrint("The wand was eaten and you have received " .. souls_earned .. " souls!")
				CreateItemActionEntity( "KUPOLI_EAT_WAND_FOR_SOULS", x, y )
				EntityKill(wand)
			end
		end,
	},
	{
		id          = "SOUL_NECROMANCY",
		name 		= "$action_kupoli_soul_necromancy",
		description = "$actiondesc_kupoli_soul_necromancy",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_necromancy.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "NECROMANCY",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.8",
		price = 100,
		mana = 70,
		max_uses = 7,
		never_unlimited = true,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				local souls_count = GetSoulsCount("all")
				local number_to_spawn = 0
				local x, y = EntityGetTransform(GetUpdatedEntityID())
				number_to_spawn = math.ceil(souls_count * 0.3)
				if number_to_spawn == 0 then
					GamePrint("You do not have enough souls!")
				else
					for i=1,number_to_spawn do
						local eid = EntityLoad("mods/tales_of_kupoli/files/entities/animals/soul_minion/soul_minion.xml", x+math.random(-5,5), y+math.random(-5,0))
						RemoveSouls(1)
						-- stolen egg hatching code <3
						local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
						if charm_component ~= nil and charm_component ~= 0 then
							---@diagnostic disable-next-line: param-type-mismatch
							ComponentSetValue( charm_component, "frames", -1 )
						end
					end
					if number_to_spawn == 1 then
						GamePrint(tostring(number_to_spawn) .. " soul consumed to spawn 1 minion!")
					else
						GamePrint(tostring(number_to_spawn) .. " souls consumed to spawn " .. tostring(number_to_spawn) .. " minions!")
					end
				end
			end
		end,
	},
	{
		id          = "SOUL_MINIONS_TO_HEALING",
		name 		= "$action_kupoli_soul_minions_to_healing",
		description = "$actiondesc_kupoli_soul_minions_to_healing",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_minions_to_healing.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_SOUL_NECROMANCY",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.1,0.3,0.5",
		price = 130,
		mana = 100,
		max_uses = 2,
		never_unlimited = true,
		action 		= function()
			local x, y = EntityGetTransform(GetUpdatedEntityID())
			local targets = EntityGetInRadiusWithTag(x, y, 150, "kupoli_soul_minion")
			for i=1,#targets do
				local tx, ty = EntityGetTransform(targets[i])
				EntityLoad("data/entities/projectiles/deck/regeneration_aura.xml", tx, ty)
				EntityKill(targets[i])
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{
		id          = "SOUL_MINIONS_TO_NUKES", -- pov murica
		name 		= "$action_kupoli_soul_minions_to_nukes",
		description = "$actiondesc_kupoli_soul_minions_to_nukes",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_minions_to_nukes.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_SOUL_MINIONS_TO_HEALING",
		spawn_level                       = "5,6",
		spawn_probability                 = "0.3,0.1",
		price = 150,
		mana = 300,
		max_uses = 2,
		never_unlimited = true,
		action 		= function()
			local x, y = EntityGetTransform(GetUpdatedEntityID())
			local targets = EntityGetInRadiusWithTag(x, y, 150, "kupoli_soul_minion")
			for i=1,#targets do
				local px, py = EntityGetTransform( targets[i] )
				local vel_x, vel_y = 0,0
				shoot_projectile( targets[i], "data/entities/projectiles/deck/nuke.xml", px, py, vel_x, vel_y )
				EntityKill( targets[i] )
			end
			c.fire_rate_wait = c.fire_rate_wait + 130
		end,
	},
	{
		id          = "ALL_WORMS", -- funy
		name 		= "$action_kupoli_all_worms",
		description = "$actiondesc_kupoli_all_worms",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/all_worms.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		spawn_requires_flag = "card_unlocked_alchemy",
		never_unlimited		= true,
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "ALL_ACID",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.1,1",
		price = 400,
		mana = 400,
		ai_never_uses = true,
		max_uses    = 2,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/all_worms/all_worms.xml")
			c.fire_rate_wait = c.fire_rate_wait + 100
			current_reload_time = current_reload_time + 100
		end,
	},
	{
		id          = "GREY_HOLE", -- im so creative
		name 		= "$action_kupoli_grey_hole",
		description = "$actiondesc_kupoli_grey_hole",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/grey_hole.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/grey_hole/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "WHITE_HOLE_GIGA",
		spawn_level                       = "2,4,5,6",
		spawn_probability                 = "0.7,0.7,0.7,0.8",
		price = 200,
		mana = 180,
		max_uses    = 3,
		never_unlimited = true,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/grey_hole/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
			c.screenshake = c.screenshake + 20
		end,
	},
	{
		id          = "CRYSTALLISE_SOULS", -- make sun easier
		name 		= "$action_kupoli_crystallise_souls",
		description = "$actiondesc_kupoli_crystallise_souls",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/crystallise_souls.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_EAT_WAND_FOR_SOULS",
		spawn_level                       = "4,5,6",
		spawn_probability                 = "0.7,0.7,0.8",
		price = 100,
		mana = 100,
		max_uses = 5,
		never_unlimited = true,
		action 		= function()

			if not reflecting then
				dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
				local souls_count = GetSoulsCount("all")
				local x, y = EntityGetTransform(GetUpdatedEntityID())
				if souls_count >= 50 then
					SetRandomSeed(x, y+GameGetFrameNum())
					local options = { "waterstone.xml", "thunderstone.xml", "stonestone.xml", "brimstone.xml", "poopstone.xml" }
					local result = "data/entities/items/pickup/" .. options[Random(1, #options)]
					EntityLoad(result, x, y)
					RemoveSouls(50)
				else
					GamePrint("You do not have enough souls for this.")
				end
			end
		end,
	},
	{
		id          = "BACKWARDS_PLASMA", -- i saw a need
		name 		= "$action_kupoli_backwardsbeam",
		description = "$actiondesc_kupoli_backwardsbeam",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/backwardslaser.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/laser_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/orb_laseremitter.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "LASER_EMITTER_FOUR",
		spawn_level                       = "1,2,3,4",
		spawn_probability                 = "0.2,1,1,0.4",
		price = 160,
		mana = 30,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/orb_laseremitter_weak_opposite.xml")
			if shot_effects.recoil_knockback > 0 then
				shot_effects.recoil_knockback = 0
			end
			shot_effects.recoil_knockback = shot_effects.recoil_knockback - 20.0
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_disintegrated.xml,"
		end,
	},
	{
		id          = "HEALING_ARROW", -- it could be a tf2 reference
		name 		= "$action_kupoli_healingarrow",
		description = "$actiondesc_kupoli_healingarrow",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/healing_arrow.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/healing_arrow/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "ARROW",
		spawn_level                       = "2,3,4,5",
		spawn_probability                 = "0.3,0.6,0.8,0.8",
		price = 70,
		mana = 20,
		max_uses = 20,
		never_unlimited = true,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/healing_arrow/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.spread_degrees = c.spread_degrees - 10
			shot_effects.recoil_knockback = 15.0
		end,
	},
	{
		id          = "SOUL_DASH", -- the final mole's souls spell (that was planned for the original mod)
		name 		= "$action_kupoli_soul_dash",
		description = "$actiondesc_kupoli_soul_dash",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_dash.png",
		related_projectiles = {"mods/tales_of_kupoli/files/entities/projectiles/soul_dash/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "DARKFLAME",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.1,0.3,0.5,0.3",
		price = 150,
		mana = 50,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_dash/proj.xml")
			if reflecting then
				return
			end
			-- may or may not be a copi thing
			local caster = GetUpdatedEntityID()
			local x, y = EntityGetTransform(caster)
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire")
				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
						if Revs >= 60 then
							-- biggest reap field
							local field = EntityLoad("mods/tales_of_kupoli/files/entities/projectiles/soul_dash/field_4.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs >= 40 then
							-- big reap field
							local field = EntityLoad("mods/tales_of_kupoli/files/entities/projectiles/soul_dash/field_3.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs >= 20 then
							-- medium reap field
							local field = EntityLoad("mods/tales_of_kupoli/files/entities/projectiles/soul_dash/field_2.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs > 0 then
							-- small reap field
							local field = EntityLoad("mods/tales_of_kupoli/files/entities/projectiles/soul_dash/field_1.xml", x, y)
							EntityAddChild(caster, field)
						end
					end
				end
				LastShootingStart = shooting_start
			end
		end,
	},
	--[[{
		id          = "IF_REVS",
		name 		= "$action_kupoli_if_revs",
		description = "$actiondesc_kupoli_if_revs",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/if_revs.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_maths",
		inject_after = "IF_HP",
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "10",
		spawn_probability                 = "1",
		price = 100,
		mana = 0,
		action 		= function( recursion_level, iteration )
			if reflecting then
				return
			end
			local endpoint = -1
			local elsepoint = -1
			local doskip = true
			local caster = GetUpdatedEntityID()
			local x, y = EntityGetTransform(caster)
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire")
				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						GamePrint(tostring(Revs))
						if Revs >= 2 then
							doskip = false
						else
							doskip = false
						end
						Revs = Revs + 1
					end
				end
				LastShootingStart = shooting_start
			end
			if ( #deck > 0 ) then
				for i,v in ipairs( deck ) do
					if ( v ~= nil ) then
						if ( string.sub( v.id, 1, 3 ) == "IF_" ) and ( v.id ~= "IF_END" ) and ( v.id ~= "IF_ELSE" ) then
							endpoint = -1
							break
						end
						if ( string.sub( v.id, 1, 10 ) == "KUPOLI_IF_" ) and ( v.id ~= "IF_END" ) and ( v.id ~= "IF_ELSE" ) then
							endpoint = -1
							break
						end
						if ( v.id == "IF_ELSE" ) then
							endpoint = i
							elsepoint = i
						end	
						if ( v.id == "IF_END" ) then
							endpoint = i
							break
						end
					end
				end	
				local envelope_min = 1
				local envelope_max = 1
				if doskip then
					if ( elsepoint > 0 ) then
						envelope_max = elsepoint
					elseif ( endpoint > 0 ) then
						envelope_max = endpoint
					end
					for i=envelope_min,envelope_max do
						local v = deck[envelope_min]
						if ( v ~= nil ) then
							table.insert( discarded, v )
							table.remove( deck, envelope_min )
						end
					end
				else
					if ( elsepoint > 0 ) then
						envelope_min = elsepoint
						if ( endpoint > 0 ) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end
						for i=envelope_min,envelope_max do
							local v = deck[envelope_min]
							if ( v ~= nil ) then
								table.insert( discarded, v )
								table.remove( deck, envelope_min )
							end
						end
					end
				end
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "IF_FEW_REVS",
		name 		= "$action_kupoli_if_few_revs",
		description = "$actiondesc_kupoli_if_few_revs",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/if_few_revs.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_maths",
		inject_after = "KUPOLI_IF_REVS",
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "10",
		spawn_probability                 = "1",
		price = 100,
		mana = 0,
		action 		= function( recursion_level, iteration )
			if reflecting then
				return
			end
			local endpoint = -1
			local elsepoint = -1
			local doskip = true
			local caster = GetUpdatedEntityID()
			local x, y = EntityGetTransform(caster)
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire")
				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
						if Revs <= 1 then
							doskip = false
						else
							doskip = true
						end
					end
				end
				LastShootingStart = shooting_start
			end

			if ( #deck > 0 ) then
				for i,v in ipairs( deck ) do
					if ( v ~= nil ) then
						if ( string.sub( v.id, 1, 3 ) == "IF_" ) and ( v.id ~= "IF_END" ) and ( v.id ~= "IF_ELSE" ) then
							endpoint = -1
							break
						end
						if ( string.sub( v.id, 1, 10 ) == "KUPOLI_IF_" ) and ( v.id ~= "IF_END" ) and ( v.id ~= "IF_ELSE" ) then
							endpoint = -1
							break
						end
						if ( v.id == "IF_ELSE" ) then
							endpoint = i
							elsepoint = i
						end
						if ( v.id == "IF_END" ) then
							endpoint = i
							break
						end
					end
				end	
				local envelope_min = 1
				local envelope_max = 1
				if doskip then
					if ( elsepoint > 0 ) then
						envelope_max = elsepoint
					elseif ( endpoint > 0 ) then
						envelope_max = endpoint
					end
					for i=envelope_min,envelope_max do
						local v = deck[envelope_min]
						if ( v ~= nil ) then
							table.insert( discarded, v )
							table.remove( deck, envelope_min )
						end
					end
				else
					if ( elsepoint > 0 ) then
						envelope_min = elsepoint
						if ( endpoint > 0 ) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end		
						for i=envelope_min,envelope_max do
							local v = deck[envelope_min]
							if ( v ~= nil ) then
								table.insert( discarded, v )
								table.remove( deck, envelope_min )
							end
						end
					end
				end
			end
			draw_actions( 1, true )
		end,
	},]]
	{
		id          = "OPEN_GATE",
		name 		= "$action_kupoli_open_gate",
		description = "$actiondesc_kupoli_open_gate",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/open_gate.png",
		type 		= ACTION_TYPE_OTHER,
		inject_after = "ALL_SPELLS",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 1000,
		mana = 1000,
		action 		= function()
			if reflecting then return end
			dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)

			local wand = 0
			local souls_earned = 1
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			local targets = EntityGetInRadiusWithTag(x, y, 110, "kupoli_soul_exchanger")

			if GameHasFlagRun("ikkuna_souldoor") and #targets > 0 then
				local ex, ey = EntityGetTransform(targets[1])
				EntityLoad("data/entities/animals/kupoli_valkoinen.xml", ex, ey)
				EntityKill(currentcard(wand))
			else
				GamePrint("Something is not quite right...")
			end

			c.fire_rate_wait = c.fire_rate_wait + 240
			current_reload_time = current_reload_time + 240
		end,
	},
	{
		id          = "SOUL_RECHARGE",
		name 		= "$action_kupoli_soul_recharge",
		description = "$actiondesc_kupoli_soul_recharge",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_is_recharge.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "RECHARGE",
		spawn_level                       = "3,4,5,6,10",
		spawn_probability                 = "0.5,0.7,0.7,0.7,0.2",
		price = 140,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				if GetSoulsCount("all") > 0 then
					c.fire_rate_wait    = c.fire_rate_wait - 20
					current_reload_time = current_reload_time - 35
					RemoveSouls(1)
				elseif GetSoulsCount("all") <= 0 then
					GamePrint("You have no souls!")
				end
			end
			draw_actions( 1, true )
		end,
	},
	--[[{
		id          = "SHOVEL",
		name 		= "$action_kupoli_shovel",
		description = "$actiondesc_kupoli_shovel",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/shovel.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/shovel/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 0,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/shovel/proj.xml")
		end,
	},]]--
	{
		id          = "TOME_BATTERY",
		name 		= "$action_kupoli_tome_battery",
		description = "$actiondesc_kupoli_tome_battery",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_shot.png",
		type 		= ACTION_TYPE_OTHER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 0,
		action 		= function()
			--[[local souls_to_use = 0
			if not reflecting then
				dofile("mods/tales_of_kupoli/files/scripts/souls.lua")
				if GetSoulsCount("all") > 0 then
					for i,data in ipairs(deck) do
						if data.moldos_mana ~= nil then
							data.mana = data.moldos_mana
						end
					end
					for i,data in ipairs(deck) do
						souls_to_use = souls_to_use + math.ceil(data.mana / 100)
					end
					souls_to_use = math.ceil(souls_to_use / 2)
					if GetSoulsCount("all") >= souls_to_use then
						RemoveSouls(souls_to_use)
						for i,data in ipairs(deck) do
							data.moldos_mana = data.mana
							data.mana = 0
						end
						draw_action()
					else
						GamePrint("You do not have enough souls!")
					end
				elseif GetSoulsCount("all") <= 0 then
					GamePrint("You do not have enough souls!")
				end
			end]]
		end,
	},
	{
		id          = "TOME_SHOT",
		name 		= "$action_kupoli_tome_shot",
		description = "$actiondesc_kupoli_tome_shot",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_TOME_BATTERY",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 0,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_tome_shot.xml",
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

			if reflecting then return end

			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)

			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			local tome = EntityGetWithTag("kupoli_tome")[1] or 1
			local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
			local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

			c.fire_rate_wait = c.fire_rate_wait + 10

			if GetSoulsCount("all") >= 3 then
				if wand == tome then
					if ca == 1 then -- tome shot
						c.spread_degrees = c.spread_degrees + 13.0
						c.screenshake = c.screenshake + 2
						c.damage_critical_chance = c.damage_critical_chance + 2
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_shot/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_shot/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_shot/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_shot/proj.xml")
					end
					if ca == 2 then -- tome seek
						c.spread_degrees = c.spread_degrees + 15.0
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml")
					end
					if ca == 3 then -- tome bomb
						c.fire_rate_wait = c.fire_rate_wait + 10
						add_projectile("mods/tales_of_kupoli/files/entities/projectiles/tome_bomb/proj.xml")
					end
					RemoveSouls(3)
				end
			else
				GamePrint("You do not have enough souls for this.")
			end
		end,
	},
	--[[{
		id          = "TOME_CHARGE",
		name 		= "$action_kupoli_tome_charge",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_charge/0.png",
		description = "$actiondesc_kupoli_tome_charge",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_TOME_SHOT",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 0,
		mana = 0,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_tome_charge.xml",
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

			if reflecting then return end

			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)

			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			local tome = EntityGetWithTag("kupoli_tome")[1] or 1
			local comp_cc = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_charge") or 0
			local cc = ComponentGetValue2(comp_ca, "value_int")

			if wand == tome then
				if cc < 5 then
					cc = cc + 1
				elseif cc >= 5 then
					cc = 0
					c.damage_projectile_add = c.damage_projectile_add + 0.5
					c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
					GamePrint("Power!")
				end
				ComponentSetValue2(comp_cc, "value_int", cc)
			end
			draw_actions(1, true)
		end,
	},]]--
	{
		id          = "UPGRADE_TOME",
		name 		= "$action_kupoli_upgrade_tome",
		description = "$actiondesc_kupoli_upgrade_tome",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_upgrade.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_TOME_CHARGE",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 0,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_upgrade_tome.xml",
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				local entity = GetUpdatedEntityID()
				local x, y = EntityGetTransform(entity)
	
				local tome = EntityGetWithTag("kupoli_tome")[1]
	
				local comp_cu = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_upgrade") or 0
				local cu = tonumber(ComponentGetValue(comp_cu, "value_string"))
	
				local wand = 0
				local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
				if inv_comp then
					wand = ComponentGetValue2(inv_comp, "mActiveItem")
				end
	
				if wand == tome then
					c.fire_rate_wait = c.fire_rate_wait + 20
					current_reload_time = current_reload_time + 20
					UpgradeTome(cu, 1, false)
				else
					GamePrint("The spell must be casted on the tome.")
				end
			end
		end,
	},
	{
		id          = "UPGRADE_TOME_BETTER",
		name 		= "$action_kupoli_upgrade_tome_better",
		description = "$actiondesc_kupoli_upgrade_tome_better",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_upgrade_better.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_UPGRADE_TOME",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 0,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_upgrade_tome_better.xml",
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				local entity = GetUpdatedEntityID()
				local x, y = EntityGetTransform(entity)
	
				local tome = EntityGetWithTag("kupoli_tome")[1]
	
				local comp_cu = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_upgrade") or 0
				local cu = tonumber(ComponentGetValue(comp_cu, "value_string"))
	
				local wand = 0
				local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
				if inv_comp then
					wand = ComponentGetValue2(inv_comp, "mActiveItem")
				end
	
				if wand == tome then
					c.fire_rate_wait = c.fire_rate_wait + 20
					current_reload_time = current_reload_time + 20
					UpgradeTome(cu, 1, true)
				else
					GamePrint("The spell must be casted on the tome.")
				end
			end
		end,
	},
	--[[{ -- the wise words of prime bandet (pronounced primus bonday)
		function(flipbool)noita
			moldos be like.rungame
	},]]--
	{
		id          = "SOUL_HEALER",
		name 		= "$action_kupoli_soul_healer",
		description = "$actiondesc_kupoli_soul_healer",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_healer.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "KUPOLI_SOUL_MINIONS_TO_NUKES",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 30,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_soul_healer.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10
		end,
	},
	{
		id          = "SOUL_METEOR",
		name 		= "$action_kupoli_soul_meteor",
		description = "$actiondesc_kupoli_soul_meteor",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_meteor.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_meteor/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_SOUL_BALL",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.2,0.2",
		price = 120,
		mana = 100,
		max_uses = 10,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_meteor/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "SOUL_ARROW",
		name 		= "$action_kupoli_soul_arrow",
		description = "$actiondesc_kupoli_soul_arrow",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/soul_arrow.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/soul_arrow/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_SOUL_METEOR",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.4,0.4,0.4,0.7,0.7",
		price = 100,
		mana = 20,
		max_uses = 70,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/soul_arrow/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 5
		end,
	},
	{
		id = "HIISI_MINE",
		name = "$action_kupoli_hiisi_mine",
		description = "$actiondesc_kupoli_hiisi_mine",
        sprite = "mods/tales_of_kupoli/files/spell_icons/hiisi_mine.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/hiisiminethrower/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "HIISI_POISON_SHOT",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 40,
		max_uses = 5,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/hiisiminethrower/proj.xml")
		end,
	},
	{
		id = "ROBOT_FLAME",
		name = "$action_kupoli_robot_flamer",
		description = "$actiondesc_kupoli_robot_flamer",
        sprite = "mods/tales_of_kupoli/files/spell_icons/robot_flamer.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/robot_flamethrower/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "FLAMETHROWER",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 15,
		max_uses = 50,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/robot_flamethrower/proj.xml")
		end,
	},
	{
		id = "ROBOT_ICE",
		name = "$action_kupoli_robot_icer",
		description = "$actiondesc_kupoli_robot_icer",
        sprite = "mods/tales_of_kupoli/files/spell_icons/robot_icer.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/items/robot_icethrower/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "ICEBALL",
		spawn_level = "",
		spawn_probability = "",
		price = 70,
		mana = 15,
		max_uses = 50,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/items/robot_icethrower/proj.xml")
		end,
	},
	--[[
	{
		id          = "TOME_REAP",
		name 		= "$action_kupoli_tome_reap",
		description = "$actiondesc_kupoli_tome_reap",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_reap.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_TOME_LOOTER",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 200,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				local entity = GetUpdatedEntityID()
				local x, y = EntityGetTransform(entity)
				local tome = EntityGetWithTag("kupoli_tome")[1]
				local wand = 0
				local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
				if inv_comp then
					wand = ComponentGetValue2(inv_comp, "mActiveItem")
				end
				if wand == tome then
					c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/tome_reap.xml,"
				else
					GamePrint("The spell must be casted on the tome.")
				end
			end
		end,
	},]]
	{
		id          = "WEAKENING_HALO", -- nezha gaming
		name 		= "$action_kupoli_weakening_halo",
		description = "$actiondesc_kupoli_weakening_halo",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/nezha_chakram.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/weakening_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_REAPING_HALO",
		spawn_level                       = "10",
		spawn_probability                 = "0.1",
		price = 500,
		mana = 100,
		action 		= function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/weakening_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "MAGICAL_RAT_KING",
		name 		= "$action_kupoli_ratking",
		description = "$actiondesc_kupoli_ratking",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/ratking.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/ratking/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.4,0.4,0.3",
		price = 270,
		mana = 100,
		max_uses = 3,
		never_unlimited = true,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/ratking/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
			c.spread_degrees = c.spread_degrees + 6.4
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
			c.damage_projectile_add = c.damage_projectile_add + 0.2
		end,
	},
	{
		id = "DETONATOR",
		name = "$action_kupoli_detonator",
		description = "$actiondesc_kupoli_detonator",
        sprite = "mods/tales_of_kupoli/files/spell_icons/detonator.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/detonator/proj.xml"},
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_detonator.xml",
		type = ACTION_TYPE_PROJECTILE,
		inject_after = "KUPOLI_HIISI_MINE",
		spawn_level                       = "3,4,5,6",
		spawn_probability                 = "0.4,0.4,0.7,0.7",
		price = 90,
		mana = 40,
		max_uses = 30,
		action = function()
			add_projectile("mods/tales_of_kupoli/files/entities/projectiles/detonator/proj.xml")
		end,
	},
	--[[{
		id          = "TOME_BUFF",
		name 		= "$action_kupoli_tome_buff",
		description = "$actiondesc_kupoli_tome_buff",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_buff.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/tales_of_kupoli/files/entities/projectiles/tome_seek/proj.xml"},
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPLI_UPGRADE_TOME_BETTER",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 100,
		mana = 1000,
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_tome_buff.xml",
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 40

			if reflecting then return end

			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)

			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			local tome = EntityGetWithTag("kupoli_tome")[1] or 1
			local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
			local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

			if wand == tome then
				if ca == 1 then
					local buff = "mods/tales_of_kupoli/files/entities/misc/effect_tome_buff_1.xml"
					--LoadGameEffectEntityTo(entity, buff)
					GetGameEffectLoadTo(entity, "BERSERK", true)
					GamePrint("Buffed with BERSERK")
				end
				if ca == 2 then
					local buff = "mods/tales_of_kupoli/files/entities/misc/effect_tome_buff_1.xml"
					--LoadGameEffectEntityTo(entity, buff)
					GetGameEffectLoadTo(entity, "MOVEMENT_FASTER_2X", true)
					GamePrint("Buffed with AGILITY")
				end
				if ca == 3 then
					local buff = "mods/tales_of_kupoli/files/entities/misc/effect_tome_buff_1.xml"
					--LoadGameEffectEntityTo(entity, buff)
					GetGameEffectLoadTo(entity, "MANA_REGENERATION", true)
					GamePrint("Buffed with MANA REGENERATION")
				end
			end
		end,
	},]]--
	--[[{
		id          = "TOME_LOOTER",
		name 		= "$action_kupoli_tome_looter",
		description = "$actiondesc_kupoli_tome_looter",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_looter.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_UPGRADE_TOME_BETTER",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 150,
		mana = 0,
		action 		= function()
			dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
			if not reflecting then
				local entity = GetUpdatedEntityID()
				local x, y = EntityGetTransform(entity)
				local tome = EntityGetWithTag("kupoli_tome")[1]
				local wand = 0
				local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
				if inv_comp then
					wand = ComponentGetValue2(inv_comp, "mActiveItem")
				end
				if wand == tome then
					-- wip
					c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
					c.fire_rate_wait = c.fire_rate_wait + 5
				else
					GamePrint("The spell must be casted on the tome.")
				end
				draw_actions( 1, true )
			end
		end,
	},
	{
		id          = "TOME_SPELL",
		name 		= "$action_kupoli_tome_spell",
		description = "$actiondesc_kupoli_tome_spell",
		sprite 		= "mods/tales_of_kupoli/files/spell_icons/tome_spell.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "KUPOLI_TOME_LOOTER",
		spawn_level                       = "",
		spawn_probability                 = "",
		price = 130,
		mana = 0,
		max_uses = 5,
		never_unlimited = true,
		action 		= function()
			local x, y = EntityGetTransform(GetUpdatedEntityID())
			if GetSoulsCount("all") >= 30 then
				-- create spell
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
		end
	},]]
	{
		id = "SOUL_STRIKE",
		name = "$action_kupoli_soul_strike",
		description = "$actiondesc_kupoli_soul_strike",
        sprite = "mods/tales_of_kupoli/files/spell_icons/soul_strike.png",
		custom_xml_file="mods/tales_of_kupoli/files/entities/misc/card_soul_strike.xml",
		type = ACTION_TYPE_MODIFIER,
		inject_after = "KUPOLI_SOULS_TO_POWER",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.3,0.4,0.4,0.2",
		price = 100,
		mana = 70,
		action = function()
			if reflecting then return end
			dofile("mods/tales_of_kupoli/files/scripts/utils.lua")
			local card = GetUpdatedEntityID()
			local x, y = EntityGetTransform(GetPlayer())
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(card, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			card = currentcard(wand)
			local comp_soulstrike = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "soul_strike_amount") or 0
			local soul_strike_amount = ComponentGetValue2(comp_soulstrike, "value_int")
			for i=1,soul_strike_amount do
				c.speed_multiplier = c.speed_multiplier * 1.05
				c.damage_projectile_add = c.damage_projectile_add + 0.15
				c.extra_entities = c.extra_entities .. "mods/tales_of_kupoli/files/entities/misc/soul_speed_fx.xml,"
			end
			ComponentSetValue2(comp_soulstrike, "value_int", 0)
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions(1, true)
		end,
	},
}

for i,v in ipairs(actions_to_insert) do
	v.id = "KUPOLI_" .. v.id

	if v.inject_after ~= nil and ModSettingGet("tales_of_kupoli.inject_spells") then
		for i=1,#actions do
			if actions[i].id == v.inject_after then
				table.insert(actions, i+1, v)
			end
		end
	else
		table.insert(actions, v)
	end
end