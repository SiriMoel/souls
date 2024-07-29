dofile_once("mods/souls/files/scripts/utils.lua")
local total_perks_picked = 0;
local has_movement_perk = false;
local function apply_movement_changes(entity, reset)
	if entity ~= GetPlayer() then return end

	local values = {
		jump_velocity_y = -95,
		jump_velocity_x = 56,
		fly_speed_max_up = 95,
		fly_speed_max_down = 85,
		run_velocity = 154,
		fly_velocity_x = 52,
		velocity_min_x = -57,
		velocity_max_x = 57,
		velocity_min_y = -200,
		velocity_max_y = 350
	}

	if reset then
		local comp = EntityGetFirstComponentIncludingDisabled(entity, "CharacterPlatformingComponent") or 0;
		if comp == nil then return end
		for key, value in pairs(values) do
			if key ~= nil then
				ComponentSetValue2(comp, key, value)
			end
		end
		return
	end

	print(total_perks_picked/10)
	if not has_movement_perk then
		has_movement_perk = true
		local comp = EntityGetFirstComponentIncludingDisabled(entity, "CharacterPlatformingComponent") or 0;
		if comp == nil then return end
		for key, val in pairs(values) do
			if key ~= nil then
				ComponentSetValue2(comp,key, val+(val*(total_perks_picked/10)))
			end
		end
		return
	end

	local comp = EntityGetFirstComponentIncludingDisabled(entity, "CharacterPlatformingComponent") or 0;
	if comp == nil then return end
	for key, val in pairs(values) do
		if key ~= nil then
			ComponentSetValue2(comp,key, val+(val*(total_perks_picked/10)))
		end
	end
end

local a = {
    {
		id = "SOLAR_RADAR",
		ui_name = "$perk_name_kupoli_solar_radar",
		ui_description = "$perk_desc_kupoli_solar_radar",
		ui_icon = "mods/souls/files/perk_icons/radar_sun.png",
		perk_icon = "mods/souls/files/perk_icons/radar_sun_inworld.png",
		stackable = STACKABLE_NO,
		func = function( entity_perk_item, entity_who_picked, item_name )
			EntityAddComponent(entity_who_picked, "LuaComponent", {
				_tags = "perk_component",
				script_source_file = "mods/souls/files/scripts/solar_radar.lua",
				execute_every_n_frame = "1",
			})
		end,
	},
	{
		id = "PERK_MOVEMENT",
		ui_name = "$perk_name_kupoli_perk_movement",
		ui_description = "$perk_desc_kupoli_perk_movement",
		ui_icon = "mods/souls/files/perk_icons/perk_movement.png",
		perk_icon = "mods/souls/files/perk_icons/perk_movement_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			total_perks_picked = 1
			apply_movement_changes(entity_who_picked, false)
		end,
		func_remove = function(entity_who_picked)
			apply_movement_changes(entity_who_picked, true)
		end
	},
	{
		id = "ALWAYS_DROP_SOULS",
		ui_name = "$perk_name_kupoli_always_drop_souls",
		ui_description = "$perk_desc_kupoli_always_drop_souls",
		ui_icon = "mods/souls/files/perk_icons/always_drop_souls.png",
		perk_icon = "mods/souls/files/perk_icons/always_drop_souls_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "kupoli_always_drop_souls")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "kupoli_always_drop_souls")
		end
	},
	{
		id = "BIOME_SOULS",
		ui_name = "$perk_name_kupoli_biome_souls",
		ui_description = "$perk_desc_kupoli_biome_souls",
		ui_icon = "mods/souls/files/perk_icons/biome_souls.png",
		perk_icon = "mods/souls/files/perk_icons/biome_souls_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "kupoli_biome_souls")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "kupoli_biome_souls")
		end
	},
	{
		id = "ENEMIES_DROP_WANDS",
		ui_name = "$perk_name_kupoli_enemies_drop_wands",
		ui_description = "$perk_desc_kupoli_enemies_drop_wands",
		ui_icon = "mods/souls/files/perk_icons/enemies_drop_wands.png",
		perk_icon = "mods/souls/files/perk_icons/enemies_drop_wands_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "kupoli_enemies_drop_wands")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "kupoli_enemies_drop_wands")
		end
	},
	--[[{
		id = "KICK_TO_DASH",
		ui_name = "$perk_name_kupoli_kick_dash",
		ui_description = "$perk_desc_kupoli_kick_dash",
		ui_icon = "mods/souls/files/perk_icons/kick_dash.png",
		perk_icon = "mods/souls/files/perk_icons/kick_dash_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "kupoli_kick_to_dash")
			EntityAddComponent( entity_who_picked, "LuaComponent", {
				_tags="kupoli_kick_to_dash",
				script_source_file="mods/souls/files/scripts/kick_to_dash.lua",
				execute_every_n_frame="1",
			} )
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "kupoli_kick_to_dash")
			local comps = EntityGetComponentIncludingDisabled(entity_who_picked, "LuaComponent", "kupoli_kick_to_dash") or {}
			for i=1,#comps do
				EntityRemoveComponent(entity_who_picked, comps[i])
			end
		end
	},]]
	{
		id = "EXTRA_SOUL",
		ui_name = "$perk_name_kupoli_extra_soul",
		ui_description = "$perk_desc_kupoli_extra_soul",
		ui_icon = "mods/souls/files/perk_icons/extra_soul.png",
		perk_icon = "mods/souls/files/perk_icons/extra_soul_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "kupoli_extra_soul")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "kupoli_extra_soul")
		end
	},
}

for i,v in ipairs(a) do
    v.id = "KUPOLI_" .. v.id
    table.insert(perk_list, v)
end

for i,v in ipairs(perk_list) do
	local oldfunc = v.func
	if oldfunc ~= nil then
		v.func = function(entity_perk_item, entity_who_picked, item_name, pickup_count)
			total_perks_picked = total_perks_picked + 1
			if has_movement_perk then
				apply_movement_changes(entity_who_picked, false)
			end
			oldfunc(entity_perk_item, entity_who_picked, item_name, pickup_count)
		end
	else
		v.func = function(entity_perk_item, entity_who_picked, item_name, pickup_count)
			total_perks_picked = total_perks_picked + 1
			if has_movement_perk then
				apply_movement_changes(entity_who_picked, false)
			end
		end
	end
end