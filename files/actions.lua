dofile_once("mods/souls/files/scripts/souls.lua")

local new_actions = {
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
			c.fire_rate_wait = c.fire_rate_wait + 18
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
			dofile_once("mods/souls/files/scripts/souls.lua")
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
				if SpellUseSouls(caster, 3) then
					TomeAddProjectiles()
				else
					GamePrint("You do not have enough souls for this. (3)")
				end
			end
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
			dofile_once("mods/souls/files/scripts/souls.lua")
			local caster = GetUpdatedEntityID()
			if SpellUseSouls(caster, 1) then
				c.speed_multiplier = c.speed_multiplier * 2
				c.damage_projectile_add = c.damage_projectile_add + 0.24
				if c.speed_multiplier >= 20 then
					c.speed_multiplier = math.min(c.speed_multiplier, 20)
				elseif c.speed_multiplier < 0 then
					c.speed_multiplier = 0
				end
			else
				GamePrint("You do not have enough souls for this. (1)")
			end
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
			dofile_once("mods/souls/files/scripts/souls.lua")
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
					if GlobalsGetValue("souls.say_soul", "true") == "true" then
						GamePrint("You have acquired a " .. SoulNameCheck(which) .. " soul!")
					end
				end
				EditSoulCounts(souls_to_add, card)
				GamePrint("The wand was eaten and you have received " .. souls_earned .. " souls!")
				CreateItemActionEntity("SOULS_EAT_WAND_FOR_SOULS", x, y)
				EntityKill(wand)
			end
		end,
	},
	{
		id = "SCALING_DAMAGE",
		name = "$action_souls_scaling_damage",
		description = "$actiondesc_souls_scaling_damage",
		sprite = "mods/souls/files/ui_gfx/gun_actions/scaling_damage.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "3,4,5,6",
		spawn_probability = "0.2,0.5,0.6,0.5",
		price = 140,
		mana = 15,
		ai_never_uses = true,
		action = function()
			if reflecting then
				c.damage_projectile_add = c.damage_projectile_add + 0.2
				return
			end
			dofile_once("mods/souls/files/scripts/souls.lua")
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
		spawn_probability = "0.2,0.4,0.5",
		price = 100,
		mana = 10,
		ai_never_uses = true,
		action = function()
			if reflecting then 
				c.speed_multiplier = c.speed_multiplier * 1.1
				return 
			end
			dofile_once("mods/souls/files/scripts/souls.lua")
			local count = SoulCount("boss")
			c.speed_multiplier = c.speed_multiplier * (1 + (0.1 * count))
			if c.speed_multiplier >= 20 then
				c.speed_multiplier = math.min(c.speed_multiplier, 20)
			elseif c.speed_multiplier < 0 then
				c.speed_multiplier = 0
			end
			draw_actions(1, true)
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
			dofile_once("mods/souls/files/scripts/utils.lua")
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
				c.damage_critical_chance = c.damage_critical_chance + 60
				return 
			end
			dofile_once("mods/souls/files/scripts/souls.lua")
			local entity = GetUpdatedEntityID()
			if SpellUseSouls(entity, 1) then
				c.damage_critical_chance = c.damage_critical_chance + 60
			else
				GamePrint("You do not have enough souls for this. (1)")
			end
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
		spawn_level = "2,3,4,5,6",
		spawn_probability = "0.3,0.4,0.2,0.5,0.4",
		price = 140,
		mana = 40,
		max_uses = 15,
		action = function()
			add_projectile("mods/souls/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 48
		end,
	},
	--- I haven't updated what is below
	{
		id          = "SOUL_ARROW", -- blacklight arrow from graham's but drawn from memory (i didnt realise it was a spell)
		name 		= "$action_souls_soul_arrow",
		description = "$actiondesc_souls_soul_arrow",
		sprite 		= "mods/souls/files/spell_icons/soul_arrow.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_arrow/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_SOUL_BLAST",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.5,0.5,0.5,0.7,0.7",
		spawn_level_table = { 2, 3, 4, 5, 6, },
		spawn_probability_table = { 0.5, 0.5, 0.5, 0.7, 0.7 },
		price = 100,
		mana = 30,
		max_uses = 70,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/soul_arrow/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 5
		end,
	},
	{
		id          = "SOUL_BALL", -- tennis
		name 		= "$action_souls_soul_ball",
		description = "$actiondesc_souls_soul_ball",
		sprite 		= "mods/souls/files/spell_icons/soul_ball.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_ball/soul_ball.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_SOUL_ARROW",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.4,0.5,0.1",
		spawn_level_table = { 5, 6, },
		spawn_probability_table = { 0.4, 0.5, },
		price = 120,
		mana = 70,
		max_uses = 10,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/soul_ball/soul_ball.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "SOUL_METEOR", -- big circle
		name 		= "$action_souls_soul_meteor",
		description = "$actiondesc_souls_soul_meteor",
		sprite 		= "mods/souls/files/spell_icons/soul_meteor.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_meteor/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_SOUL_BALL",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.2,0.2",
		spawn_level_table = { 6, 10, },
		spawn_probability_table = { 0.2, 0.2, },
		price = 120,
		mana = 100,
		max_uses = 10,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/soul_meteor/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "SOUL_HEALER", -- this should not stay as it is
		name 		= "$action_souls_soul_healer",
		description = "$actiondesc_souls_soul_healer",
		sprite 		= "mods/souls/files/spell_icons/soul_healer.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_SOUL_METEOR",
		spawn_level                       = "1,2,3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.3,0.2",
		spawn_level_table = { 1, 2, 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2 },
		price = 250,
		mana = 30,
		custom_xml_file="mods/souls/files/entities/misc/card_soul_healer/card.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_HALO",
		name 		= "$action_souls_reaping_halo",
		description = "$actiondesc_souls_reaping_halo",
		sprite 		= "mods/souls/files/spell_icons/reaping_halo.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/reaping_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "FIREWORK",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.1,0.2,0.5",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.1, 0.2, 0.5, },
		price = 300,
		mana = 150,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/reaping_halo/projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
		end,
	},
	--[[{
		id          = "WEAKENING_HALO", -- "replace" with new spell
		name 		= "$action_souls_weakening_halo",
		description = "$actiondesc_souls_weakening_halo",
		sprite 		= "mods/souls/files/spell_icons/weakening_halo.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/weakening_halo/projectile.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_REAPING_HALO",
		spawn_level                       = "10",
		spawn_probability                 = "0.1",
		spawn_level_table = { 10, },
		spawn_probability_table = { 0.1, },
		price = 500,
		mana = 200,
		ai_never_uses = true,
		action 		= function()
			c.damage_projectile_add = c.damage_projectile_add - 3.0
			c.fire_rate_wait = c.fire_rate_wait + 40

			if reflecting then return end

			local entity = GetUpdatedEntityID()

			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			if DoesWandUseSpecificSoul(wand) then
				if GetSoulsCount(GetWandSoulType(wand)) >= 1 then
					RemoveSoul(GetWandSoulType(wand))
					add_projectile("mods/souls/files/entities/projectiles/weakening_halo/projectile.xml")
				else
					GamePrint("You do not have enough souls for this.")
				end
			else
				if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 1 then
					RemoveRandomSouls(1)
					add_projectile("mods/souls/files/entities/projectiles/weakening_halo/projectile.xml")
				else
					GamePrint("You do not have enough souls for this.")
				end
			end

			draw_actions( 1, true )
		end,
	},]]
	{
		id          = "SOUL_BOLT",
		name 		= "$action_souls_soul_bolt",
		description = "$actiondesc_souls_soul_bolt",
		sprite 		= "mods/souls/files/spell_icons/soul_bolt.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_bolt/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_SOUL_METEOR",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.9,0.9,0.9,0.7,0.7",
		spawn_level_table = { 2, 3, 4, 5, 6 },
		spawn_probability_table = { 0.9, 0.9, 0.9, 0.7, 0.7 },
		price = 100,
		mana = 25,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/soul_bolt/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 5
		end,
	},
	{
		id          = "REAP_TELE",
		name 		= "$action_souls_reap_tele",
		description = "$actiondesc_souls_reap_tele",
		sprite 		= "mods/souls/files/spell_icons/reap_tele.png",
		related_projectiles = {"mods/souls/files/entities/projectiles/reap_tele/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "TELEPORT_PROJECTILE_CLOSER",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.1,0.3,0.5,0.3",
		spawn_level_table = { 4, 5, 6, },
		spawn_probability_table = { 0.1, 0.3, 0.5, },
		price = 150,
		mana = 50,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/reap_tele/proj.xml")
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
							local field = EntityLoad("mods/souls/files/entities/projectiles/reap_tele/field_4.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs >= 40 then
							-- big reap field
							local field = EntityLoad("mods/souls/files/entities/projectiles/reap_tele/field_3.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs >= 20 then
							-- medium reap field
							local field = EntityLoad("mods/souls/files/entities/projectiles/reap_tele/field_2.xml", x, y)
							EntityAddChild(caster, field)
						elseif Revs > 0 then
							-- small reap field
							local field = EntityLoad("mods/souls/files/entities/projectiles/reap_tele/field_1.xml", x, y)
							EntityAddChild(caster, field)
						end
					end
				end
				LastShootingStart = shooting_start
			end
		end,
	},
	{
		id          = "TOME_SLICE", -- demoknight
		name 		= "$action_souls_tome_slice",
		description = "$actiondesc_souls_tome_slice",
		sprite 		= "mods/souls/files/spell_icons/tome_slice.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_slice/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_TOME_SHOT",
		spawn_level                       = "3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.4,0.4,0.4",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 200,
		mana = 50,
		ai_never_uses = true,
		custom_xml_file="mods/souls/files/entities/misc/card_tome_slice/card.xml",
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local tome = EntityGetWithTag("soul_tome")[1] or 1
			c.fire_rate_wait = c.fire_rate_wait + 10
			if wand == tome then
				if DoesWandUseSpecificSoul(wand) then
					if GetSoulsCount(GetWandSoulType(wand)) >= 1 then
						RemoveSoul(GetWandSoulType(wand))
						add_projectile("mods/souls/files/entities/projectiles/tome_slice/proj.xml")
					else
						GamePrint("You do not have enough souls for this.")
					end
				else
					if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 1 then
						RemoveRandomSouls(1)
						add_projectile("mods/souls/files/entities/projectiles/tome_slice/proj.xml")
					else
						GamePrint("You do not have enough souls for this.")
					end
				end
			else
				GamePrint("The spell must be casted on the tome.")
			end
		end,
	},
	{
		id          = "TOME_LAUNCHER", -- im beggin
		name 		= "$action_souls_tome_launcher",
		description = "$actiondesc_souls_tome_launcher",
		sprite 		= "mods/souls/files/spell_icons/tome_launcher.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_launcher/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_TOME_SLICE",
		spawn_level                       = "3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.4,0.4,0.4",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 200,
		mana = 50,
		ai_never_uses = true,
		custom_xml_file="mods/souls/files/entities/misc/card_tome_launcher/card.xml",
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity)
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local tome = EntityGetWithTag("soul_tome")[1] or 1
			c.fire_rate_wait = c.fire_rate_wait + 10
			if wand == tome then
				local comp_sl = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "launcher_souls_loaded") or 0
				local sl = tonumber(ComponentGetValue(comp_sl, "value_int"))
				for i=1,sl do
					add_projectile("mods/souls/files/entities/projectiles/tome_launcher/proj.xml")
				end
				sl = 0
				ComponentSetValue2(comp_sl, "value_int", sl)
			else
				GamePrint("The spell must be casted on the tome.")
			end
		end,
	},
	{
		id          = "SOUL_BOOST",
		name 		= "$action_souls_soul_boost",
		description = "$actiondesc_souls_soul_boost",
		sprite 		= "mods/souls/files/spell_icons/soul_boost.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "0.7,0.9,0.9,0.9,0.9,0.9",
		spawn_level_table = { 1, 2, 3, 4, 5, 6, },
		spawn_probability_table = { 0.7, 0.9, 0.9, 0.9, 0.9, 0.9, },
		price = 100,
		mana = 25,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			local soul = GetRandomSoulForWand(wand)
			if soul == nil or soul == 0 or soul == "0" then
			else
				if tobool(GlobalsGetValue("souls.say_consumed_soul", "true")) then
					GamePrint( "A " .. SoulNameCheck(soul) .. " soul has been consumed." )
				end
				RemoveSoul(soul)
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"

				if soul == "bat" then
					c.speed_multiplier = c.speed_multiplier * 1.2
					c.damage_projectile_add = c.damage_projectile_add + 0.05
				end
				if soul == "fly" then
					c.speed_multiplier = c.speed_multiplier * 1.2
					c.damage_projectile_add = c.damage_projectile_add + 0.05
				end
				if soul == "friendly" then
					c.damage_projectile_add = c.damage_projectile_add + 0.15
				end
				if soul == "souls_void" then
					c.damage_critical_chance = c.damage_critical_chance + 20
					c.damage_critical_multiplier = c.damage_critical_multiplier + 0.5
				end
				if soul == "mage" then
					c.damage_projectile_add = c.damage_projectile_add + 0.3
				end
				if soul == "orcs" then
					c.explosion_radius = c.explosion_radius * 1.7
				end
				if soul == "slimes" then
					c.damage_projectile_add = c.damage_projectile_add + 0.2
				end
				if soul == "spider" then
					c.speed_multiplier = c.speed_multiplier * 1.2
					c.explosion_radius = c.explosion_radius * 1.3
				end
				if soul == "zombie" then
					c.explosion_radius = c.explosion_radius * 1.7
				end
				if soul == "worm" then
					c.explosion_radius = c.explosion_radius * 0.7
					c.damage_critical_chance = c.damage_critical_chance + 5
					c.extra_entities = c.extra_entities .. "data/entities/misc/matter_eater.xml,"
				end
				if soul == "fungus" then
					c.explosion_radius = c.explosion_radius * 1.5
					c.damage_critical_chance = c.damage_critical_chance + 3
				end
				if soul == "ghost" then
					c.damage_projectile_add = c.damage_projectile_add + 0.3
				end
				if soul == "boss" then
					c.damage_critical_chance = c.damage_critical_chance + 20
					c.damage_critical_multiplier = c.damage_critical_multiplier + 0.5
				end
				if soul == "mage_corrupted" then
					c.damage_projectile_add = c.damage_projectile_add + 0.3
				end
				if soul == "ghost_whisp" then
					c.speed_multiplier = c.speed_multiplier * 1.2
					c.damage_projectile_add = c.damage_projectile_add + 0.05
				end
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_FIRE",
		name 		= "$action_souls_soul_fire",
		description = "$actiondesc_souls_soul_fire",
		sprite 		= "mods/souls/files/spell_icons/soul_fire.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_SOUL_HEALER",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.3,0.2",
		spawn_level_table = { 4, 5, 6, },
		spawn_probability_table = { 0.4, 0.4, 0.4, },
		price = 100,
		mana = 5,
		ai_never_uses = true,
		custom_xml_file="mods/souls/files/entities/misc/card_soul_fire/card.xml",
		action 		= function()
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAP_FROM_FIRE",
		name 		= "$action_souls_reap_from_fire",
		description = "$actiondesc_souls_reap_from_fire",
		sprite 		= "mods/souls/files/spell_icons/reap_from_fire.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/reap_from_fire/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_REAPING_SHOT",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.4,0.5,0.5,0.7",
		spawn_level_table = { 4, 5, 6, },
		spawn_probability_table = { 0.4, 0.4, 0.4, },
		price = 100,
		mana = 5,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/reap_from_fire/reaping_shot.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_BATTERY",
		name 		= "$action_souls_soul_battery",
		description = "$actiondesc_souls_soul_battery",
		custom_xml_file = "mods/souls/files/entities/misc/card_soul_battery/card.xml",
		sprite 		= "mods/souls/files/spell_icons/soul_battery.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.7, 0.5 },
		price = 150,
		mana = -100,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local wand = 0
			local inv_comp = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if inv_comp then
				wand = ComponentGetValue2(inv_comp, "mActiveItem")
			end
			if DoesWandUseSpecificSoul(wand) then
				if GetSoulsCount(GetWandSoulType(wand)) >= 1 then
					RemoveSoul(GetWandSoulType(wand))
					c.fire_rate_wait = c.fire_rate_wait - 20
					current_reload_time = current_reload_time - 20
				else
					GamePrint("You do not have enough souls for this.")
				end
			else
				if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 1 then
					RemoveRandomSouls(1)
					c.fire_rate_wait = c.fire_rate_wait - 20
					current_reload_time = current_reload_time - 20
				else
					GamePrint("You do not have enough souls for this.")
				end
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "EXPEL_SOUL",
		name 		= "$action_souls_expel_soul",
		description = "$actiondesc_souls_expel_soul",
		sprite 		= "mods/souls/files/spell_icons/expel_soul.png",
		--custom_xml_file = "mods/souls/files/entities/misc/card_expel_soul/card.xml",
		related_projectiles	= {"mods/souls/files/entities/projectiles/expel_soul/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "PIPE_BOMB_DEATH_TRIGGER",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,0.9,0.9,0.9,0.9",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.5, 0.5, 0.5, },
		price = 120,
		mana = 40,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/expel_soul/proj.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
		end,
	},
	{
		id          = "SCALING_MANA",
		name 		= "$action_souls_scaling_mana",
		description = "$actiondesc_souls_scaling_mana",
		sprite 		= "mods/souls/files/spell_icons/scaling_mana.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "5,6",
		spawn_probability                 = "0.5,0.5",
		spawn_level_table = { 5, 6, },
		spawn_probability_table = { 0.5, 0.5, },
		price = 100,
		mana = 0,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local count = GetSoulsCount("boss")
			if ( #deck > 0 ) then
				data = deck[1]
			end
			data.mana = -2 * count
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SCALING_RECHARGE",
		name 		= "$action_souls_scaling_recharge",
		description = "$actiondesc_souls_scaling_recharge",
		sprite 		= "mods/souls/files/spell_icons/scaling_recharge.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "5,6",
		spawn_probability                 = "0.5,0.5",
		spawn_level_table = { 5, 6, },
		spawn_probability_table = { 0.5, 0.5, },
		price = 100,
		mana = 30,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local count = GetSoulsCount("boss")
			c.fire_rate_wait = c.fire_rate_wait - (5 * count)
			current_reload_time = current_reload_time - (5 * count)
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_SPELL_WORM",
		name 		= "$action_souls_soul_spell_worm",
		description = "$actiondesc_souls_soul_spell_worm",
		sprite 		= "mods/souls/files/spell_icons/wormhole.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/soul_spell_worm/soul_spell_worm.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "6",
		spawn_probability                 = "0",
		spawn_level_table = { 6, 10, },
		spawn_probability_table = { 0.5, 0.5 },
		price = 200,
		mana = 100,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			if GetSoulsCount("worm") > 0 then
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_spell_worm/soul_spell_worm.xml,"
				RemoveSoul("worm")
			else
				GamePrint("You do not have enough souls for this.")
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_SPELL_MAGE",
		name 		= "$action_souls_soul_spell_mage",
		description = "$actiondesc_souls_soul_spell_mage",
		sprite 		= "mods/souls/files/spell_icons/mage_gun.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/soul_spell_mage/soul_spell_mage.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "6",
		spawn_probability                 = "0",
		spawn_level_table = { 6, 10, },
		spawn_probability_table = { 0.5, 0.5 },
		price = 200,
		mana = 150,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			if GetSoulsCount("mage") > 0 then
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_spell_mage/soul_spell_mage.xml,"
				c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_bloody.xml,"
				RemoveSoul("mage")
			else
				GamePrint("You do not have enough souls for this.")
			end
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_SPELL_SLIMES",
		name 		= "$action_souls_soul_spell_slimes",
		description = "$actiondesc_souls_soul_spell_slimes",
		sprite 		= "mods/souls/files/spell_icons/slime_safeguard.png",
		related_extra_entities = { "" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "6",
		spawn_probability                 = "0",
		spawn_level_table = { 6, 10, },
		spawn_probability_table = { 0.5, 0.5 },
		price = 200,
		mana = 50,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			if GetSoulsCount("slimes") > 0 then
				c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_healhurt.xml,"
				RemoveSoul("slimes")
			else
				GamePrint("You do not have enough souls for this.")
			end
			draw_actions( 1, true )
		end,
	},
	--[[{
		id          = "DIVIDE_BY_SOULS",
		name 		= "$action_souls_divide_by_souls",
		description = "$actiondesc_souls_divide_by_souls",
		sprite 		= "mods/souls/files/spell_icons/divide_by_souls.png",
		spawn_requires_flag = "card_unlocked_musicbox",
		related_extra_entities = { "" },
		type 		= ACTION_TYPE_OTHER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "6",
		spawn_probability                 = "0",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.1, 0.1, 0.6 },
		price = 200,
		mana = 45,
		ai_never_uses = true,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			if (GetSoulsCount("all") - GetSoulsCount("boss")) > 0 then
				local count = math.ceil(GetSoulsCount("all"))
				if count > 15 then
					count = 15
				end
				for i=1,count do
					RemoveSoul(GetRandomSoul(false))
				end
				local data = {}
				local iter = iteration or 1
				local iter_max = iteration or 1
				
				if ( #deck > 0 ) then
					data = deck[iter] or nil
				else
					data = nil
				end

				if ( iter >= 4 ) then
					count = 1
				end
				local rec = check_recursion( data, recursion_level )
				if ( data ~= nil ) and ( rec > -1 ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
					local firerate = c.fire_rate_wait
					local reload = current_reload_time
					for i=1,count do
						if ( i == 1 ) then
								dont_draw_actions = true
						end	
						local imax = data.action( rec, iter + 1 )
						dont_draw_actions = false
						if (imax ~= nil) then
							iter_max = imax
						end
					end
					if ( data.uses_remaining ~= nil ) and ( data.uses_remaining > 0 ) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged( data.inventoryitem_id, data.uses_remaining )
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end
					if (iter == 1) then
						c.fire_rate_wait = firerate
						current_reload_time = reload
						for i=1,iter_max do
							if (#deck > 0) then
								local d = deck[1]
								table.insert( discarded, d )
								table.remove( deck, 1 )
							end
						end
					end
				end
				c.pattern_degrees = 5
				return iter_max
			else
				GamePrint("You do not have enough souls for this.")
			end
		end,
	},]]
	--[[{
		id          = "VOID_LASH",
		name 		= "$action_souls_void_lash",
		description = "$actiondesc_souls_void_lash",
		sprite 		= "mods/souls/files/spell_icons/void_lash.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "10",
		spawn_probability                 = "0.1",
		spawn_level_table = { 10, },
		spawn_probability_table = { 0.1, },
		price = 100,
		mana = 30,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local count = GetSoulsConsumed() -- will need to uncomment this in souls.lua
			c.damage_projectile_add = c.damage_projectile_add + (math.min(0.015 * count, 2))
			draw_actions( 1, true )
		end,
	},]]
}

for i,action in ipairs(new_actions) do
	action.id = "SOULS_" .. action.id
	--[[if action.spawn_level_table ~= nil and action.spawn_probability_table ~= nil then
		local levels = ""
		local probabilities = ""
		levels = ""
		probabilities = ""
		local multiplier = 1--tonumber(GlobalsGetValue("souls.spell_spawn_chance_multiplier", "1"))
		for i,level in ipairs(action.spawn_level_table) do
			levels = levels .. tostring(level) .. ","
		end
		action.spawn_level = levels
		for i,chance in ipairs(action.spawn_probability_table) do
			chance = chance * multiplier
			probabilities = probabilities .. tostring(chance) .. ","
		end
		action.spawn_probability = probabilities
	end]]
	table.insert(actions, action)
end