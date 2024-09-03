dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function UpgradeTome(wand, path, amount, is_better)
	if path == 0 then
		GamePrint("You must select an upgrade first.")
		return
	end
    local tome = EntityGetWithTag("soul_tome")[1]
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
	function DoTomeUpgrade()
		if path == 1 then -- upgrade capacity
			GamePrint("Upgrading capacity!")
			for i=1,amount do
				cap = cap + 3
				if cap > 30 then
					cap = 30
					GamePrint("Max capacity reached!")
				end
				--rt = rt * 1
				--frw = frw * 1
			end
			path_1 = path_1 + amount
		end
		if path == 2 then -- upgrade recharge time
			GamePrint("Upgrading recharge time!")
			for i=1,amount do
				--cap = cap - 2
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				rt = rt * 0.7
				--frw = frw * 1.1
			end
			path_2 = path_2 + amount
		end
		if path == 3 then -- upgrade cast delay
			GamePrint("Upgrading cast delay!")
			for i=1,amount do
				--cap = cap - 1
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				--rt = rt * 1.1
				frw = frw * 0.7
			end
			path_3 = path_3 + amount
		end
		if path == 4 then -- upgrade mana max
			for i=1,amount do
				--cap = cap - 1
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				mm = mm * 1.3
			end
			path_4 = path_4 + amount
		end
		if path == 5 then -- upgrade mana charge speed
			for i=1,amount do
				--cap = cap - 1
				if cap < 5 then
					cap = 5
					GamePrint("Minimum capacity reached.")
				end
				mcs = mcs * 1.3
			end
			path_5 = path_5 + amount
		end
		cost = cost * 1.25
		cost = math.floor(cost + 0.5)
		if cost > 50 then
			cost = 50
		end
		GamePrint("Next upgrade will cost " .. cost .. " souls.")
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
	if wand == tome then
		if DoesWandUseSpecificSoul(wand) then
			if GetSoulsCount(GetWandSoulType(wand)) >= cost then
				for i=1,cost do
					RemoveSoul(GetWandSoulType(wand))
				end
				DoTomeUpgrade()
			else
				GamePrint("You do not have enough souls for this.")
			end
		else
			if GetSoulsCount("all") >= cost then
				RemoveRandomSouls(cost)
				DoTomeUpgrade()
			else
				GamePrint("You do not have enough souls for this.")
			end
		end
	end
end

actions_to_insert = {
	{
		id          = "REAPING_SHOT", -- the basis of the whole mod
		name 		= "$action_moldos_reaping_shot",
		description = "$actiondesc_moldos_reaping_shot",
		sprite 		= "mods/souls/files/spell_icons/reaping_shot.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/reaping_shot/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MANA_REDUCE",
		spawn_level                       = "0,1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1,1",
		spawn_level_table = { 0, 1, 2, 3, 4, 5, 6, },
		spawn_probability_table = { 1, 1, 1, 1, 1, 1, 1, },
		price = 100,
		mana = 10,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/reaping_shot/reaping_shot.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "WAND_CONSUMES_X_SOULS", -- new souls thing!!!
		name 		= "$action_moldos_wand_consumes_x_souls",
		description = "$actiondesc_moldos_wand_consumes_x_souls",
		sprite 		= "mods/souls/files/spell_icons/wand_consumes_x_souls.png",
		custom_xml_file="mods/souls/files/entities/misc/card_wand_consumes_x_souls/card.xml",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_REAPING_SHOT",
		spawn_level                       = "0,1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1,1",
		spawn_level_table = { 0, 1, 2, 3, 4, 5, 6, },
		spawn_probability_table = { 1, 1, 1, 1, 1, 1, 1, },
		price = 100,
		mana = 0,
		action 		= function()
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_BLAST",
		name 		= "$action_moldos_soul_blast",
		description = "$actiondesc_moldos_soul_blast",
		sprite 		= "mods/souls/files/spell_icons/soul_blast.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_blast/soul_blast.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "PIPE_BOMB_DEATH_TRIGGER",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.8,0.9,0.9,0.9,0.9",
		spawn_level_table = { 2, 3, 4, 5, 6, },
		spawn_probability_table = { 0.8, 0.9, 0.9, 0.9, 0.9, },
		price = 120,
		mana = 70,
		max_uses = 20,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/soul_blast/soul_blast.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},
	{
		id          = "TOME_SHOT", -- infinite bombs
		name 		= "$action_moldos_tome_shot",
		description = "$actiondesc_moldos_tome_shot",
		sprite 		= "mods/souls/files/spell_icons/tome_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_seek/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 50,
		custom_xml_file="mods/souls/files/entities/misc/card_tome_shot/card.xml",
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
			local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
			local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

			c.fire_rate_wait = c.fire_rate_wait + 10

			function TomeAddProjectiles()
				if ca == 1 then -- tome shot
					c.spread_degrees = c.spread_degrees + 13.0
					c.screenshake = c.screenshake + 2
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
					c.fire_rate_wait = c.fire_rate_wait + 10
					add_projectile("mods/souls/files/entities/projectiles/tome_bomb/proj.xml")
				end
			end

			if wand == tome then
				if DoesWandUseSpecificSoul(wand) then
					if GetSoulsCount(GetWandSoulType(wand)) >= 3 then
						for i=1,3 do
							RemoveSoul(GetWandSoulType(wand))
						end
						TomeAddProjectiles()
					else
						GamePrint("You do not have enough souls for this.")
					end
				else
					if GetSoulsCount("all") >= 3 then
						RemoveRandomSouls(3)
						TomeAddProjectiles()
					else
						GamePrint("You do not have enough souls for this.")
					end
				end
			end
		end,
	},
	{
		id          = "UPGRADE_TOME", -- tome gaming
		name 		= "$action_moldos_upgrade_tome",
		description = "$actiondesc_moldos_upgrade_tome",
		sprite 		= "mods/souls/files/spell_icons/tome_upgrade.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "MOLDOS_TOME_SHOT",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 0,
		custom_xml_file="mods/souls/files/entities/misc/card_upgrade_tome/card.xml",
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if not reflecting then
				local entity = GetUpdatedEntityID()
				local x, y = EntityGetTransform(entity)
	
				local tome = EntityGetWithTag("soul_tome")[1]
	
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
					UpgradeTome(wand, cu, 1, false)
				else
					GamePrint("The spell must be casted on the tome.")
				end
			end
		end,
	},
	{
		id          = "SOUL_SPEED",
		name 		= "$action_moldos_soul_speed",
		description = "$actiondesc_moldos_soul_speed",
		sprite 		= "mods/souls/files/spell_icons/soul_speed.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "BLOODLUST",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1",
		spawn_level_table = { 1, 2, 3, 4, 5, 6 },
		spawn_probability_table = { 1, 1, 1, 1, 1, 1 },
		price = 100,
		mana = 10,
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
					c.speed_multiplier = c.speed_multiplier * 2
					c.damage_projectile_add = c.damage_projectile_add + 0.3
					--c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"
				else
					GamePrint("You do not have enough souls for this.")
				end
			else
				if GetSoulsCount("all") >= 1 then
					RemoveRandomSouls(1)
					c.speed_multiplier = c.speed_multiplier * 2
					c.damage_projectile_add = c.damage_projectile_add + 0.2
					--c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"
				else
					GamePrint("You do not have enough souls for this.")
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOULS_TO_POWER",
		name 		= "$action_moldos_souls_to_power",
		description = "$actiondesc_moldos_souls_to_power",
		sprite 		= "mods/souls/files/spell_icons/souls_to_power.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/souls_to_power/souls_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SPELLS_TO_POWER",
		spawn_level                       = "2,3,4,5,6,10",
		spawn_probability                 = "0.7,0.7,0.9,0.9,0.8,0.5",
		spawn_level_table = { 2, 3, 4, 5, 6, 10 },
		spawn_probability_table = { 0.7, 0.7, 0.9, 0.9, 0.8, 0.5 },
		price = 120,
		mana = 50,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/souls_to_power/souls_to_power.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id = "SOUL_STRIKE", -- souls to power if it was cool
		name = "$action_moldos_soul_strike",
		description = "$actiondesc_moldos_soul_strike",
        sprite = "mods/souls/files/spell_icons/soul_strike.png",
		custom_xml_file="mods/souls/files/entities/misc/card_soul_strike/card.xml",
		type = ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOULS_TO_POWER",
		spawn_level                       = "2,3,4,5,6,10",
		spawn_probability                 = "0.3,0.8,0.8,0.8,0.7,0.2",
		spawn_level_table = { 2, 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.8, 0.8, 0.8, 0.7, 0.2 },
		price = 100,
		mana = 50,
		action = function()
			if reflecting then return end
			dofile("mods/souls/files/scripts/utils.lua")
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
				c.damage_projectile_add = c.damage_projectile_add + 0.1
				c.extra_entities = c.extra_entities .. "mods/souls/files/entities/misc/soul_speed_fx.xml,"
			end
			ComponentSetValue2(comp_soulstrike, "value_int", 0)
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions(1, true)
		end,
	},
	{
		id          = "EAT_WAND_FOR_SOULS", -- humgy
		name 		= "$action_moldos_eat_wand_for_souls",
		description = "$actiondesc_moldos_eat_wand_for_souls",
		sprite 		= "mods/souls/files/spell_icons/eat_wand_for_souls.png",
		type 		= ACTION_TYPE_UTILITY,
		inject_after = "MOLDOS_SOUL_STRIKE",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.6,0.7,0.5",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.6, 0.7, 0.5 },
		price = 300,
		mana = 100,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
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
            			if action_id ~= "MOLDOS_EAT_WAND_FOR_SOULS" then
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
					AddSouls(which, 1)
					if ModSettingGet("souls.say_soul") == true then
						GamePrint("You have acquired a " .. SoulNameCheck(which) .. " soul!")
					end
				end
				GamePrint("The wand was eaten and you have received " .. souls_earned .. " souls!")
				CreateItemActionEntity( "MOLDOS_EAT_WAND_FOR_SOULS", x, y )
				EntityKill(wand)
			end
		end,
	},
	{
		id          = "SOUL_ARROW", -- blacklight arrow from graham's but drawn from memory (i didnt realise it was a spell)
		name 		= "$action_moldos_soul_arrow",
		description = "$actiondesc_moldos_soul_arrow",
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
		name 		= "$action_moldos_soul_ball",
		description = "$actiondesc_moldos_soul_ball",
		sprite 		= "mods/souls/files/spell_icons/soul_ball.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/soul_ball/soul_ball.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_SOUL_ARROW",
		spawn_level                       = "5,6,10",
		spawn_probability                 = "0.4,0.5,0.1",
		spawn_level_table = { 5, 6, 10, },
		spawn_probability_table = { 0.4, 0.5, 0.1, },
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
		name 		= "$action_moldos_soul_meteor",
		description = "$actiondesc_moldos_soul_meteor",
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
		id          = "SOUL_HEALER", -- my favourite spell in the mod, no idea why
		name 		= "$action_moldos_soul_healer",
		description = "$actiondesc_moldos_soul_healer",
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
		name 		= "$action_moldos_reaping_halo",
		description = "$actiondesc_moldos_reaping_halo",
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
	{
		id          = "WEAKENING_HALO", -- nezha gaming
		name 		= "$action_moldos_weakening_halo",
		description = "$actiondesc_moldos_weakening_halo",
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
				if GetSoulsCount("all") >= 1 then
					RemoveRandomSouls(1)
					add_projectile("mods/souls/files/entities/projectiles/weakening_halo/projectile.xml")
				else
					GamePrint("You do not have enough souls for this.")
				end
			end

			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_CLOAK",
		name 		= "$action_moldos_soul_cloak",
		description = "$actiondesc_moldos_soul_cloak",
		sprite 		= "mods/souls/files/spell_icons/soul_rage.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_SOUL_HEALER",
		spawn_level                       = "1,2,3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.3,0.2",
		spawn_level_table = { 1, 2, 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2 },
		price = 250,
		mana = 30,
		custom_xml_file="mods/souls/files/entities/misc/card_soul_cloak/card.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_RAGE",
		name 		= "$action_moldos_soul_rage",
		description = "$actiondesc_moldos_soul_rage",
		sprite 		= "mods/souls/files/spell_icons/soul_cloak.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_SOUL_CLOAK",
		spawn_level                       = "1,2,3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.3,0.2",
		spawn_level_table = { 1, 2, 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.2 },
		price = 250,
		mana = 30,
		custom_xml_file="mods/souls/files/entities/misc/card_soul_rage/card.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 10
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_BOLT",
		name 		= "$action_moldos_soul_bolt",
		description = "$actiondesc_moldos_soul_bolt",
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
		id          = "SOULDOS", -- moldos
		name 		= "$action_moldos_souldos",
		description = "$actiondesc_moldos_souldos",
		sprite 		= "mods/souls/files/spell_icons/souldos.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/souldos/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_REAPING_SHOT",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.4,0.5,0.5,0.7",
		spawn_level_table = { 4, 5, 6, 10, },
		spawn_probability_table = { 0.4, 0.5, 0.5, 0.7, },
		price = 100,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/souldos/reaping_shot.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "RANDOM_REAP",
		name 		= "$action_moldos_random_reap",
		description = "$actiondesc_moldos_random_reap",
		sprite 		= "mods/souls/files/spell_icons/random_reap.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/random_reap/reaping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_REAPING_SHOT",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.4,0.5,0.5,0.7",
		spawn_level_table = { 4, 5, 6, 10, },
		spawn_probability_table = { 0.4, 0.5, 0.5, 0.7, },
		price = 100,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/random_reap/reaping_shot.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "REAPING_FIELD",
		name 		= "$action_moldos_reaping_field",
		description = "$actiondesc_moldos_reaping_field",
		sprite 		= "mods/souls/files/spell_icons/reaping_field.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/reaping_field/reaping_field.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		inject_after = "SHIELD_FIELD",
		spawn_level                       = "2,3,4,5,6",
		spawn_probability                 = "0.3,0.4,0.2,0.5,0.4",
		spawn_level_table = { 2, 3, 4, 5, 6, },
		spawn_probability_table = { 0.3, 0.4, 0.2, 0.5, 0.4, },
		price = 140,
		mana = 40,
		max_uses = 15,
		action 		= function()
			add_projectile("mods/souls/files/entities/projectiles/reaping_field/reaping_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
		end,
	},
	{
		id          = "REAP_TELE",
		name 		= "$action_moldos_reap_tele",
		description = "$actiondesc_moldos_reap_tele",
		sprite 		= "mods/souls/files/spell_icons/reap_tele.png",
		related_projectiles = {"mods/souls/files/entities/projectiles/reap_tele/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "TELEPORT_PROJECTILE_CLOSER",
		spawn_level                       = "4,5,6,10",
		spawn_probability                 = "0.1,0.3,0.5,0.3",
		spawn_level_table = { 4, 5, 6, 10, },
		spawn_probability_table = { 0.1, 0.3, 0.5, 0.3, },
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
		name 		= "$action_moldos_tome_slice",
		description = "$actiondesc_moldos_tome_slice",
		sprite 		= "mods/souls/files/spell_icons/tome_slice.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_slice/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_TOME_SHOT",
		spawn_level                       = "3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.4,0.4,0.4",
		spawn_level_table = { 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.3, 0.4, 0.4, 0.4 },
		price = 200,
		mana = 50,
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
					if GetSoulsCount("all") >= 1 then
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
		name 		= "$action_moldos_tome_launcher",
		description = "$actiondesc_moldos_tome_launcher",
		sprite 		= "mods/souls/files/spell_icons/tome_launcher.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_launcher/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		inject_after = "MOLDOS_TOME_SLICE",
		spawn_level                       = "3,4,5,6,10",
		spawn_probability                 = "0.3,0.3,0.4,0.4,0.4",
		spawn_level_table = { 3, 4, 5, 6, 10, },
		spawn_probability_table = { 0.3, 0.3, 0.4, 0.4, 0.4 },
		price = 200,
		mana = 50,
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
		name 		= "$action_moldos_soul_boost",
		description = "$actiondesc_moldos_soul_boost",
		sprite 		= "mods/souls/files/spell_icons/soul_boost.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "0.7,0.9,0.9,0.9,0.9,0.9",
		spawn_level_table = { 1, 2, 3, 4, 5, 6, },
		spawn_probability_table = { 0.7, 0.9, 0.9, 0.9, 0.9, 0.9, },
		price = 100,
		mana = 25,
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
				if ModSettingGet( "souls.say_consumed_soul" ) then
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
				if soul == "gilded" then
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
		id          = "SCALING_DAMAGE",
		name 		= "$action_moldos_scaling_damage",
		description = "$actiondesc_moldos_scaling_damage",
		sprite 		= "mods/souls/files/spell_icons/scaling_damage.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "5,6",
		spawn_probability                 = "0.5,0.5",
		spawn_level_table = { 5, 6, },
		spawn_probability_table = { 0.5, 0.5, },
		price = 100,
		mana = 30,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local count = GetSoulsCount("boss")
			c.damage_projectile_add = c.damage_projectile_add + (0.03 * count)
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SCALING_SPEED",
		name 		= "$action_moldos_scaling_speed",
		description = "$actiondesc_moldos_scaling_speed",
		sprite 		= "mods/souls/files/spell_icons/scaling_speed.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SCALING_DAMAGE",
		spawn_level                       = "5,6",
		spawn_probability                 = "0.5,0.5",
		spawn_level_table = { 5, 6, },
		spawn_probability_table = { 0.5, 0.5, },
		price = 100,
		mana = 30,
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
			local count = GetSoulsCount("boss")
			c.speed_multiplier = c.speed_multiplier * (1 + (0.3 * count))
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_TINKER",
		name 		= "$action_moldos_soul_tinker",
		description = "$actiondesc_moldos_soul_tinker",
		sprite 		= "mods/souls/files/spell_icons/soul_tinker.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "MOLDOS_SOUL_HEALER",
		spawn_level                       = "6,10",
		spawn_probability                 = "0.3,0.2",
		spawn_level_table = { 6, 10, },
		spawn_probability_table = { 0.3, 0.2, },
		price = 300,
		mana = 40,
		custom_xml_file="mods/souls/files/entities/misc/card_soul_tinker/card.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SOUL_CRIT",
		name 		= "$action_moldos_soul_crit",
		description = "$actiondesc_moldos_soul_crit",
		sprite 		= "mods/souls/files/spell_icons/soul_crit.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "MOLDOS_SOUL_SPEED",
		spawn_level                       = "1,2,3,4,5,6",
		spawn_probability                 = "1,1,1,1,1,1",
		spawn_level_table = { 1, 2, 3, 4, 5, 6 },
		spawn_probability_table = { 0.5, 0.7, 0.7, 0.7, 0.7, 0.7 },
		price = 100,
		mana = 15,
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
					c.damage_critical_chance = c.damage_critical_chance + 100
					--c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"
				else
					GamePrint("You do not have enough souls for this.")
				end
			else
				if GetSoulsCount("all") >= 1 then
					RemoveRandomSouls(1)
					c.damage_critical_chance = c.damage_critical_chance + 100
					--c.extra_entities = c.extra_entities .. "mods/souls/files/entities/projectiles/soul_speed/soul_speed_fx.xml,"
				else
					GamePrint("You do not have enough souls for this.")
				end
			end

			draw_actions( 1, true )
		end,
	},
}

for i,action in ipairs(actions_to_insert) do
	action.id = "MOLDOS_" .. action.id
	local levels = ""
	local probabilities = ""
	levels = ""
	probabilities = ""
	local multiplier = tonumber(ModSettingGet("souls.spell_spawn_chance_multiplier"))
	for i,level in ipairs(action.spawn_level_table) do
		levels = levels .. tostring(level) .. ","
	end
	action.spawn_level = levels
	for i,chance in ipairs(action.spawn_probability_table) do
		chance = chance * multiplier
		probabilities = probabilities .. tostring(chance) .. ","
	end
	action.spawn_probability = probabilities
	table.insert(actions, action)
end