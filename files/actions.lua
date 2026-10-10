dofile_once("mods/souls/files/scripts/souls.lua")

local new_actions = {
	--[[{
		id = "HAX", -- DONT FORGET TO COMMENT THIS!!!
		name = "cheating!",
		description = "cheating!",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reaping_shot.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level  = "",
		spawn_probability = "",
		price = 100,
		mana = 0,
		ai_never_uses = true,
		action = function()
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			--EditSoulCounts({["orcs"] = 1}, caster)
			AcquireManySouls(caster)
			--SoulsPrintImportant("hello", "hello", "divine")
			--EntitySetComponentsWithTagEnabled(caster, "souls_execute_on_reap", true)
		end,
	},]]
	{
		id = "REAPING_SHOT",
		name = "$action_souls_reaping_shot",
		description = "$actiondesc_souls_reaping_shot",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reaping_shot.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/reaping_shot/reaping_shot.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level  = "0,1,2,3,4,5,6",
		spawn_probability = "1,1,1,1,1,1,1",
		price = 100,
		mana = 10,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "RANDOM_REAP",
		name = "$action_souls_random_reap",
		description = "$actiondesc_souls_random_reap",
		sprite = "mods/souls/files/ui_gfx/gun_actions/random_reap.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/random_reap/reaping_shot.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.4,0.4,0.5,0.5",
		price = 100,
		mana = 15,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/random_reap/reaping_shot.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "SOULDOS",
		name = "$action_souls_souldos",
		description = "$actiondesc_souls_souldos",
		sprite = "mods/souls/files/ui_gfx/gun_actions/souldos.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/souldos/reaping_shot.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.4,0.5,0.5,0.7",
		price = 100,
		mana = 20,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/souldos/reaping_shot.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "REAP_FROM_FIRE",
		name = "$action_souls_reap_from_fire",
		description = "$actiondesc_souls_reap_from_fire",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reap_from_fire.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/reap_from_fire/reaping_shot.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.3,0.4,0.4,0.3",
		price = 100,
		mana = 5,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/reap_from_fire/reaping_shot.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "WAND_CONSUMES_X_SOULS",
		name = "$action_souls_wand_consumes_x_souls",
		description = "$actiondesc_souls_wand_consumes_x_souls",
		sprite = "mods/souls/files/ui_gfx/gun_actions/wand_consumes_x_souls.png",
		custom_xml_file="mods/souls/files/entities/misc/card_wand_consumes_x_souls/card.xml",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "1,2,3,4,5",
		spawn_probability = "1,1,1,1,1",
		price = 100,
		mana = 0,
		ai_never_uses = true,
		action = function()
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_BLAST",
		name = "$action_souls_soul_blast",
		description = "$actiondesc_souls_soul_blast",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_blast.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_blast/soul_blast.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.8,0.9,0.9,0.9,0.9",
		price = 160,
		mana = 60,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_blast/soul_blast.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{
		id = "SOUL_ARROW", 
		name = "$action_souls_soul_arrow",
		description = "$actiondesc_souls_soul_arrow",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_arrow.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_arrow/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.6,0.7,0.8,0.7,0.6",
		price = 130,
		mana = 30,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_arrow/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 12
		end,
	},
	{
		id = "SOUL_BOLT",
		name = "$action_souls_soul_bolt",
		description = "$actiondesc_souls_soul_bolt",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_bolt.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_bolt/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.7,0.8,0.8,0.7",
		price = 100,
		mana = 35,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_bolt/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 12
		end,
	},
	{
		id = "SOUL_BALL",
		name = "$action_souls_soul_ball",
		description = "$actiondesc_souls_soul_ball",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_ball.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_ball/soul_ball.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "4,5,6",
		spawn_probability = "0.3,0.4,0.5",
		price = 140,
		mana = 70,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_ball/soul_ball.xml")
			c.fire_rate_wait = c.fire_rate_wait + 42
		end,
	},
	{
		id = "SOUL_METEOR",
		name = "$action_souls_soul_meteor",
		description = "$actiondesc_souls_soul_meteor",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_meteor.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_meteor/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "5,6,10",
		spawn_probability = "0.2,0.3,0.1",
		price = 150,
		mana = 100,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_meteor/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
		end,
	},
	{
		id = "UPGRADE_TOME",
		name = "$action_souls_upgrade_tome",
		description = "$actiondesc_souls_upgrade_tome",
		sprite = "mods/souls/files/ui_gfx/gun_actions/tome_upgrade.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "",
		spawn_probability = "",
		price = 100,
		mana = 0,
		ai_never_uses = true,
		custom_xml_file="mods/souls/files/entities/items/tome2/card_upgrade.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 60
		end,
	},
	{
		id = "TOME_SHOT",
		name = "$action_souls_tome_shot",
		description = "$actiondesc_souls_tome_shot",
		sprite = "mods/souls/files/ui_gfx/gun_actions/tome_shot.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_seek/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "10",
		spawn_probability = "0",
		price = 100,
		mana = 50,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_tome_shot/card.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local tome = EntityGetWithTag("soul_tome")[1]
			local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
			local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))
			local function TomeAddProjectiles()
				if ca == 1 then -- tome shot
					c.spread_degrees = c.spread_degrees + 13.0
					c.damage_critical_chance = c.damage_critical_chance + 2
					add_projectile("mods/souls/files/entities/projectiles/tome_shot/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_shot/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_shot/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_shot/proj.xml")
				end
				if ca == 2 then -- tome seek
					c.spread_degrees = c.spread_degrees + 15.0
					c.damage_projectile_add = c.damage_projectile_add - 1.0
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
					add_projectile("mods/souls/files/entities/projectiles/tome_seek/proj.xml")
				end
				if ca == 3 then -- tome bomb
					c.fire_rate_wait = c.fire_rate_wait + 15
					add_projectile("mods/souls/files/entities/projectiles/tome_bomb/proj.xml")
				end
			end
			if wand == tome then
				if SpellUseSouls(entity, 3) then
					TomeAddProjectiles()
				else
					souls_not_enough = true
	    			souls_not_enough_count = souls_not_enough_count + 3
				end
			end
		end,
	},
	{
		id = "TOME_SLICE",
		name = "$action_souls_tome_slice",
		description = "$actiondesc_souls_tome_slice",
		sprite = "mods/souls/files/ui_gfx/gun_actions/tome_slice.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_slice/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.3,0.4,0.4,0.3",
		price = 170,
		mana = 40,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_tome_slice/card.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 6
			if reflecting then 
				add_projectile("mods/souls/files/entities/projectiles/tome_slice/proj.xml")
				return 
			end
			local caster = GetUpdatedEntityID()
			local comp_inv = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
			if comp_inv ~= nil then
				local wand = ComponentGetValue2(comp_inv, "mActiveItem")
				if EntityHasTag(wand, "soul_tome") then
					local success, soul = SpellUseSouls(caster, 1)
					if success then
						add_projectile("mods/souls/files/entities/projectiles/tome_slice/proj.xml")

					else
						souls_not_enough = true
    					souls_not_enough_count = souls_not_enough_count + 1
					end
				else
					GamePrint("Tome Slice can only be casted by the tome.")
				end
			end
		end,
	},
	{
		id = "TOME_LAUNCHER",
		name = "$action_souls_tome_launcher",
		description = "$actiondesc_souls_tome_launcher",
		sprite = "mods/souls/files/ui_gfx/gun_actions/tome_launcher.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_launcher/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.3,0.4,0.4,0.3",
		price = 170,
		mana = 40,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_tome_launcher/card.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			if reflecting then 
				current_reload_time = current_reload_time + 3
				add_projectile("mods/souls/files/entities/projectiles/tome_launcher/proj.xml")
				return 
			end
			local caster = GetUpdatedEntityID()
			local comp_inv = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
			if comp_inv ~= nil then
				local wand = ComponentGetValue2(comp_inv, "mActiveItem")
				if EntityHasTag(wand, "soul_tome") then
					local comp = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "launcher_souls_loaded")
					if comp ~= nil then
						local count = ComponentGetValue2(comp, "value_int")
						if count > 0 then
							for i = 1, count do
								add_projectile("mods/souls/files/entities/projectiles/tome_launcher/proj.xml")
							end
							current_reload_time = current_reload_time + 3 * count
							ComponentSetValue2(comp, "value_int", 0)
						else
							GamePrint("No souls loaded.")
							current_reload_time = current_reload_time + 3
						end
					end
				else
					GamePrint("Tome Launcher can only be casted by the tome.")
				end
			end
		end,
	},
	{
		id = "TOME_LASER",
		name = "$action_souls_tome_laser",
		description = "$actiondesc_souls_tome_laser",
		sprite = "mods/souls/files/ui_gfx/gun_actions/tome_laser.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_laser/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "5,6,10",
		spawn_probability = "0.3,0.3,0.2",
		price = 190,
		mana = 10,
		ai_never_uses = true,
		action = function()
			if reflecting then 
				add_projectile("mods/souls/files/entities/projectiles/tome_laser/projectile.xml")
				return 
			end
			local caster = GetUpdatedEntityID()
			local comp_inv = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
			if comp_inv ~= nil then
				local wand = ComponentGetValue2(comp_inv, "mActiveItem")
				if EntityHasTag(wand, "soul_tome") then
					local e = EntityGetAllChildren(caster, "souls_tome_laser_effect") or {}
					if #e > 0 then
						c.fire_rate_wait = c.fire_rate_wait - 12
						current_reload_time = current_reload_time - 6
						add_projectile("mods/souls/files/entities/projectiles/tome_laser/projectile.xml")
					else
						local success, soul = SpellUseSouls(caster, 3)
						if success then
							LoadGameEffectEntityTo(caster, "mods/souls/files/entities/misc/effect_tome_laser.xml")
							c.fire_rate_wait = c.fire_rate_wait - 12
							current_reload_time = current_reload_time - 6
							add_projectile("mods/souls/files/entities/projectiles/tome_laser/projectile.xml")
						else
							souls_not_enough = true
    						souls_not_enough_count = souls_not_enough_count + 3
						end
					end
				else
					GamePrint("Tome Laser can only be casted by the tome.")
				end
			end
		end,
	},
	{
		id = "SOUL_SPEED",
		name = "$action_souls_soul_speed",
		description = "$actiondesc_souls_soul_speed",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_speed.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "1,2,3,4,5,6",
		spawn_probability = "0.8,1,1,1,1,0.5",
		price = 100,
		mana = 10,
		ai_never_uses = true,
		action = function()
			if reflecting then 
				c.speed_multiplier = c.speed_multiplier * 2
				c.damage_projectile_add = c.damage_projectile_add + 0.24
				return 
			end
			local caster = GetUpdatedEntityID()
			if SpellUseSouls(caster, 1) then
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"
				c.speed_multiplier = c.speed_multiplier * 2
				c.damage_projectile_add = c.damage_projectile_add + 0.24
				if c.speed_multiplier >= 20 then
					c.speed_multiplier = math.min(c.speed_multiplier, 20)
				elseif c.speed_multiplier < 0 then
					c.speed_multiplier = 0
				end
			else
				souls_not_enough = true
    			souls_not_enough_count = souls_not_enough_count + 1
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_BOOST",
		name = "$action_souls_soul_boost",
		description = "$actiondesc_souls_soul_boost",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_boost.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.5,0.7,0.8,0.8,0.7",
		price = 100,
		mana = 30,
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_boost/entity.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "REAPING_FIELD",
		name = "$action_souls_reaping_field",
		description = "$actiondesc_souls_reaping_field",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reaping_field.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level = "1,2,3,4,5,6",
		spawn_probability = "0.3,0.4,0.5,0.6,0.6,0.5",
		price = 160,
		mana = 40,
		max_uses = 15,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 48
		end,
	},
	{
		id = "REAP_TELE",
		name = "$action_souls_reap_tele",
		description = "$actiondesc_souls_reap_tele",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reap_tele.png",
		related_projectiles = {"mods/souls/files/entities/projectiles/reap_tele/proj.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.3,0.4,0.5,0.3",
		price = 140,
		mana = 30,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/reap_tele/proj.xml")
			if reflecting then return end
			-- may or may not be a copi thing
			local caster = GetUpdatedEntityID()
			local x, y = EntityGetTransform(caster)
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				SoulsRevs = SoulsRevs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire")
				if not shooting_now then
					SoulsRevs = 0
				else
					if LastShootingStart ~= shooting_start then
						SoulsRevs = 0
					else
						SoulsRevs = SoulsRevs + 1
						local fields = {
							"mods/souls/files/entities/projectiles/reap_tele/field_1.xml",
							"mods/souls/files/entities/projectiles/reap_tele/field_2.xml",
							"mods/souls/files/entities/projectiles/reap_tele/field_3.xml",
							"mods/souls/files/entities/projectiles/reap_tele/field_4.xml"
						}
						local field = fields[math.min(math.ceil(SoulsRevs/20), 4)]
						local field_entity = EntityLoad(field, x, y)
						EntityAddChild(caster, field_entity)
					end
				end
				LastShootingStart = shooting_start
			end
		end,
	},
	{
		id = "SOUL_FOCUS",
		name = "$action_souls_soul_focus",
		description = "$actiondesc_souls_soul_focus",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_focus.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_focus/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "3,4,5,6,10",
		spawn_probability = "0.3,0.4,0.5,0.4,0.1",
		price = 140,
		mana = 60,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/soul_focus/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 32
		end,
	},
	{
		id = "REAPING_HALO",
		name = "$action_souls_reaping_halo",
		description = "$actiondesc_souls_reaping_halo",
		sprite = "mods/souls/files/ui_gfx/gun_actions/reaping_halo.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/reaping_halo/projectile.xml"},
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "5,6,10",
		spawn_probability = "0.1,0.2,0.4",
		price = 250,
		mana = 120,
		ai_never_uses = true,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/reaping_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 78
		end,
	},
	{
		id = "SOULS_TO_POWER",
		name = "$action_souls_souls_to_power",
		description = "$actiondesc_souls_souls_to_power",
		sprite = "mods/souls/files/ui_gfx/gun_actions/souls_to_power.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5,6,10",
		spawn_probability = "0.6,0.7,0.8,0.8,0.4",
		price = 120,
		mana = 50,
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 24
			if reflecting then 
				c.damage_projectile_add = c.damage_projectile_add + 0.24
				return 
			end
			local total = SoulCount("total")
			local count = math.min(math.ceil(total * 0.04), 100)
			if SpellUseSouls(GetUpdatedEntityID(), count) then
				c.damage_projectile_add = c.damage_projectile_add + 0.24 * count
				shot_effects.recoil_knockback = shot_effects.recoil_knockback + 1.0 * count
				for i=1,math.min(count, 10) do
					c.extra_entities = c.extra_entities .. "mods/souls/files/entities/particles/souls_to_power.xml,"
				end
			else
				souls_not_enough = true
    			souls_not_enough_count = souls_not_enough_count + count
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_STRIKE",
		name = "$action_souls_soul_strike",
		description = "$actiondesc_souls_soul_strike",
        sprite = "mods/souls/files/ui_gfx/gun_actions/soul_strike.png",
		custom_xml_file="mods/souls/files/entities/misc/card_soul_strike/card.xml",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6,10",
		spawn_probability = "0.3,0.7,0.8,0.8,0.7,0.2",
		price = 120,
		mana = 30,
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			if reflecting then 
				c.speed_multiplier = c.speed_multiplier * 1.05
				c.damage_projectile_add = c.damage_projectile_add + 0.2
				return 
			end
			local caster = GetUpdatedEntityID()
			local x, y = EntityGetTransform(GetPlayer())
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local card = CurrentCard(wand)
			local comp_soulstrike = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "soul_strike_amount") or 0
			local soul_strike_amount = ComponentGetValue2(comp_soulstrike, "value_int") or 0
			c.speed_multiplier = c.speed_multiplier * (1 + 0.05 * soul_strike_amount)
			c.damage_projectile_add = c.damage_projectile_add + 0.2 * soul_strike_amount
			if c.speed_multiplier >= 20 then
				c.speed_multiplier = math.min(c.speed_multiplier, 20)
			elseif c.speed_multiplier < 0 then
				c.speed_multiplier = 0
			end
			ComponentSetValue2(comp_soulstrike, "value_int", 0)
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_CRIT",
		name = "$action_souls_soul_crit",
		description = "$actiondesc_souls_soul_crit",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_crit.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "1,2,3,4,5,6",
		spawn_probability = "1,1,1,1,1,0.7",
		price = 100,
		mana = 8,
		ai_never_uses = true,
		action = function()
			if reflecting then 
				c.damage_critical_chance = c.damage_critical_chance + 100
				return 
			end
			local entity = GetUpdatedEntityID()
			if SpellUseSouls(entity, 1) then
				c.damage_critical_chance = c.damage_critical_chance + 100
			else
				souls_not_enough = true
    			souls_not_enough_count = souls_not_enough_count + 1
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SCALING_DAMAGE",
		name = "$action_souls_scaling_damage",
		description = "$actiondesc_souls_scaling_damage",
		sprite = "mods/souls/files/ui_gfx/gun_actions/scaling_damage.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.3,0.5,0.6,0.5",
		price = 140,
		mana = 15,
		ai_never_uses = true,
		action = function()
			if reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.2
				return
			end
			local count = SoulCount("boss")
			c.damage_projectile_add = c.damage_projectile_add + 0.2 * count
			draw_actions(1, true)
		end,
	},
	{
		id = "SCALING_SPEED",
		name = "$action_souls_scaling_speed",
		description = "$actiondesc_souls_scaling_speed",
		sprite = "mods/souls/files/ui_gfx/gun_actions/scaling_speed.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5",
		spawn_probability = "0.3,0.4,0.5",
		price = 100,
		mana = 10,
		ai_never_uses = true,
		action = function()
			if reflecting then 
				c.speed_multiplier = c.speed_multiplier * 1.1
				return 
			end
			local count = SoulCount("boss")
			c.speed_multiplier = c.speed_multiplier * (1 + (0.15 * count))
			if c.speed_multiplier >= 20 then
				c.speed_multiplier = math.min(c.speed_multiplier, 20)
			elseif c.speed_multiplier < 0 then
				c.speed_multiplier = 0
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOULAR_POWER",
		name = "$action_souls_soular_power",
		description = "$actiondesc_souls_soular_power",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soular_power.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.4,0.5,0.5,0.2",
		price = 120,
		mana = 0,
		ai_never_uses = true,
		action = function()
			local count = 1
			if not reflecting then
				count = SoulCount("boss")
			end
			mana = mana + 20 * count
			c.fire_rate_wait = c.fire_rate_wait - 12 * count
			current_reload_time = current_reload_time - 6 * count
			draw_actions(1, true)
		end,
	},
	{
		id = "EAT_WAND_FOR_SOULS",
		name = "$action_souls_eat_wand_for_souls",
		description = "$actiondesc_souls_eat_wand_for_souls",
		sprite = "mods/souls/files/ui_gfx/gun_actions/eat_wand_for_souls.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "5,6,10",
		spawn_probability = "0.6,0.7,0.5",
		price = 300,
		mana = 0,
		ai_never_uses = true,
		action = function()
			if reflecting then return end
			local card = GetUpdatedEntityID() -- why did i call this 'card' ?
			local x, y = EntityGetTransform(card)
			local wand = 0
			local souls_earned = 1
			local inv_comp = EntityGetFirstComponentIncludingDisabled(card, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local possible_types = {
				"bat",
				"fly",
				"friendly",
				"mage",
				"orcs",
				"slimes",
				"spider",
				"zombie",
				"worm",
				"fungus",
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
					rt = rt / 10
					frw = frw / 10
					mcs = mcs / 50
					mm = mm / 50
					cp = cp / 1
					souls_earned = rt + frw + mcs + mm + cp
					souls_earned = math.ceil(souls_earned)
				end
				local children = EntityGetAllChildren(wand) or {}
				for i,v in ipairs(children) do
					if EntityHasTag(v, "card_action") then
						local comp_itemaction = EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0
            			local action_id = ComponentGetValue(comp_itemaction, "action_id") or ""
            			if action_id ~= "SOULS_EAT_WAND_FOR_SOULS" then
							souls_earned = souls_earned + 1
						end
					end
				end
				if souls_earned > 30 then
					souls_earned = 30 + ((souls_earned - 30) * 0.7)
				end
				souls_earned = math.ceil(souls_earned)
				local souls_to_add = {}
				for i=1,souls_earned do
					local which = possible_types[math.random(1,#possible_types)]
					souls_to_add[tostring(which)] = (souls_to_add[tostring(which)] or 0) + 1
					SoulsPrint("You have acquired a " .. SoulNameCheck(which) .. " soul!", "say_soul")
				end
				EditSoulCounts(souls_to_add, card)
				GamePrint("The wand was eaten and you have received " .. souls_earned .. " souls!")
				CreateItemActionEntity("SOULS_EAT_WAND_FOR_SOULS", x, y)
				EntityKill(wand)
			end
		end,
	},
	{
		id = "SOUL_HEALER", 
		name = "$action_souls_soul_healer",
		description = "$actiondesc_souls_soul_healer",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_healer.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "1,2,3,4,5,6,10",
		spawn_probability = "0.1,0.1,0.1,0.1,0.2,0.2,0.2",
		price = 250,
		mana = 30,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_healer/card.xml",
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 18
			current_reload_time = current_reload_time + 18
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_FIRE",
		name = "$action_souls_soul_fire",
		description = "$actiondesc_souls_soul_fire",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_fire.png",
		type = ACTION_TYPE_PASSIVE,
		spawn_level = "5,6",
		spawn_probability = "0.3,0.2",
		price = 100,
		mana = 5,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_fire/card.xml",
		action = function()
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_BATTERY",
		name = "$action_souls_soul_battery",
		description = "$actiondesc_souls_soul_battery",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soul_battery.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "5,6,10",
		spawn_probability = "0.1,0.2,0.4",
		price = 220,
		mana = 0,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_battery/card.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait - 6
			current_reload_time = current_reload_time + 3
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			if SpellUseSouls(caster, 1) then
				local amt = 200
				local comp_inv = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
				if comp_inv ~= nil then
					local wand = ComponentGetValue2(comp_inv, "mActiveItem")
					local comp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
					if comp ~= nil then
						local mana_max = ComponentGetValue2(comp, "mana_max")
						amt = mana_max
					end
				end
				mana = mana + amt
			else
				souls_not_enough = true
    			souls_not_enough_count = souls_not_enough_count + 1
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOULSPLIT",
		name = "$action_souls_soulsplit",
		description = "$actiondesc_souls_soulsplit",
		sprite = "mods/souls/files/ui_gfx/gun_actions/soulsplit.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "6,10",
		spawn_probability = "0.1,0.3",
		price = 200,
		mana = 130,
		ai_never_uses = true,
		action = function(recursion_level, iteration)
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 30
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			if SpellUseSouls(caster, 1) then
				local discarded_size = #discarded
				if discarded_size > 0 then
					for i, v in ipairs(discarded) do
						local rec = check_recursion(v, recursion_level)
						if (v.id ~= "SOULS_SOULSPLIT") and (i <= discarded_size) and (rec > -1) then
							v.action(rec)
						end
					end
				end
				local hand_size = #hand
				if hand_size > 0 then
					for i, v in ipairs(hand) do
						local rec = check_recursion(v, recursion_level)
						if (v.id ~= "SOULS_SOULSPLIT") and (i <= hand_size) and (rec > -1) then
							v.action(rec)
						end
					end
				end
				local deck_size = #deck
				if deck_size > 0 then
					for i, v in ipairs(deck) do
						local rec = check_recursion(v, recursion_level)
						if (v.id ~= "SOULS_SOULSPLIT") and (i <= deck_size) and (rec > -1) then
							v.action(rec)
						end
					end
				end
			else
				souls_not_enough = true
    			souls_not_enough_count = souls_not_enough_count + 1
			end
		end,
	},
	{
		id = "SOUL_SPELL_WORM",
		name = "$action_souls_soul_spell_worm",
		description = "$actiondesc_souls_soul_spell_worm",
		sprite = "mods/souls/files/ui_gfx/gun_actions/wormhole.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/soul_spell_worm/soul_spell_worm.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.1",
		price = 180,
		mana = 90,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_spell_worm.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 48
			current_reload_time = current_reload_time + 24
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			if SpellUseSpecificSouls(caster, {["worm"] = 1}) then
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_spell_worm/soul_spell_worm.xml,"
			else
				SoulsPrint("You do not have enough Worm souls for this. (1)", "say_not_enough")
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_SPELL_MAGE",
		name = "$action_souls_soul_spell_mage",
		description = "$actiondesc_souls_soul_spell_mage",
		sprite = "mods/souls/files/ui_gfx/gun_actions/mage_gun.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/soul_spell_mage/soul_spell_mage.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.1",
		price = 150,
		mana = 40,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_spell_mage.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			if reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 1
				c.damage_fire_add = c.damage_fire_add + 1
				c.damage_critical_chance = c.damage_critical_chance + 100
				return 
			end
			local caster = GetUpdatedEntityID()
			if SpellUseSpecificSouls(caster, {["mage"] = 2}) then
				c.damage_projectile_add = c.damage_projectile_add + 1
				c.damage_fire_add = c.damage_fire_add + 1
				c.damage_critical_chance = c.damage_critical_chance + 100
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_spell_mage/soul_spell_mage.xml,"
			else
				SoulsPrint("You do not have enough Mage souls for this. (3)", "say_not_enough")
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "SOUL_SPELL_SLIMES",
		name = "$action_souls_soul_spell_slimes",
		description = "$actiondesc_souls_soul_spell_slimes",
		sprite = "mods/souls/files/ui_gfx/gun_actions/slime_safeguard.png",
		related_extra_entities = {"mods/souls/files/entities/projectiles/soul_spell_slimes/soul_spell_slimes.xml"},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "4,5,6,10",
		spawn_probability = "0.2,0.3,0.3,0.1",
		price = 190,
		mana = 70,
		ai_never_uses = true,
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_spell_slimes.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			if reflecting then
				c.friendly_fire	= true
				c.speed_multiplier = c.speed_multiplier * 0.2
				c.lifetime_add = c.lifetime_add + 60
				if c.speed_multiplier < 0 then
					c.speed_multiplier = 0
				end
				return 
			end
			local caster = GetUpdatedEntityID()
			if SpellUseSpecificSouls(caster, {["slimes"] = 10}) then
				c.friendly_fire	= true
				c.speed_multiplier = c.speed_multiplier * 0.2
				c.lifetime_add = c.lifetime_add + 60
				if c.speed_multiplier < 0 then
					c.speed_multiplier = 0
				end
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_spell_slimes/soul_spell_slimes.xml,"
			else
				SoulsPrint("You do not have enough Slime souls for this. (10)", "say_not_enough")
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "VOID_ATTACK",
		name = "$action_souls_void_attack",
		description = "$actiondesc_souls_void_attack",
		sprite = "mods/souls/files/ui_gfx/gun_actions/void_attack.png",
		related_projectiles = {"mods/souls/files/entities/projectiles/void_attack/proj.xml"},
		spawn_requires_flag = "souls_phylactery_activated",
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "6,10",
		spawn_probability = "0.1,0.1",
		price = 300,
		mana = 200,
		ai_never_uses = true,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 60
			add_projectile("mods/souls/files/entities/projectiles/void_attack/proj.xml")
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "SOULS_" .. action.id
	table.insert(actions, action)
end