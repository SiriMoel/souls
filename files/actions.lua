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
		spawn_probability                 = "0.8,1,1,1,1",
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
}

for i,v in ipairs(actions_to_insert) do
	v.id = "MOLDOS_" .. v.id
	--[[if v.inject_after ~= nil and ModSettingGet("souls.inject_spells") then
		for i=1,#actions do
			if actions[i].id == v.inject_after then
				table.insert(actions, i+1, v)
			end
		end
	elseif ModSettingGet("souls.inject_spells") then
		table.insert(actions, v)
	else
		table.insert(actions, v)
	end]]
	table.insert(actions, v)
end