dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
local total_perks_picked = 0;
local has_movement_perk = false;
local function apply_movement_changes(entity, reset)
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
		for key, value in pairs(values) do
			ComponentSetValue2(comp, key, value)
		end
		return
	end

	print(total_perks_picked/10)
	if not has_movement_perk then
		has_movement_perk = true
		local comp = EntityGetFirstComponentIncludingDisabled(entity, "CharacterPlatformingComponent") or 0;
		for key, val in pairs(values) do
			ComponentSetValue2(comp,key, val+(val*(total_perks_picked/10)))
		end
		return
	end

	local comp = EntityGetFirstComponentIncludingDisabled(entity, "CharacterPlatformingComponent") or 0;
	for key, val in pairs(values) do
		ComponentSetValue2(comp,key, val+(val*(total_perks_picked/10)))
	end
end

local a = {
    --[[{
		id = "SOLAR_RADAR",
		ui_name = "Solar Radar",
		ui_description = "You can sense nearby suns.",
		ui_icon = "mods/tales_of_kupoli/files/perk_icons/radar_sun.png",
		perk_icon = "mods/tales_of_kupoli/files/perk_icons/radar_sun_inworld.png",
		stackable = STACKABLE_NO,
		func = function( entity_perk_item, entity_who_picked, item_name )
			EntityAddComponent(entity_who_picked, "LuaComponent", {
				_tags = "perk_component",
				script_source_file = "mods/tales_of_kupoli/files/scripts/solar_radar.lua",
				execute_every_n_frame = "1",
			})
		end,
	},]]--
	{
		id = "KUPOLI_PERK_MOVEMENT",
		ui_name = "Growing Movement",
		ui_description = "Each perk you pick up increases your movement speed slightly.",
		ui_icon = "mods/tales_of_kupoli/files/perk_icons/radar_sun.png",
		perk_icon = "mods/tales_of_kupoli/files/perk_icons/radar_sun_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			apply_movement_changes(entity_who_picked, false)
		end,
		func_remove = function(entity_who_picked)
			apply_movement_changes(entity_who_picked, true);
		end
	}
}

for i,v in ipairs(a) do
    v.id = "talesofkupoli_" .. v.id
    table.insert(perk_list, v)
end

for i=1, #perk_list do local v = perk_list[i]
	local oldfunc = v.func;
	if oldfunc then
		v.func = function(entity_perk_item, entity_who_picked, item_name)
			total_perks_picked = total_perks_picked + 1;
			if has_movement_perk then
				apply_movement_changes(entity_who_picked, false)
			end
			oldfunc(entity_perk_item, entity_who_picked, item_name)
		end
	else
		v.func = function (entity_perk_item, entity_who_picked, item_name)
			total_perks_picked = total_perks_picked + 1;
			if has_movement_perk then
				apply_movement_changes(entity_who_picked, false)
			end
		end
	end
end

