dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
local total_perks_picked = 0;
local has_movement_perk = false;
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
		ui_icon = "MODLSO DO TGIS",
		perk_icon = "MOLDOS DO THIS",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			has_movement_perk = true;
			local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "run_velocity",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                for _, v in ipairs(values) do
                    ComponentSetValue2(comp,v,ComponentGetValue2(comp,v)*1.2*total_perks_picked)
                end
            end
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
				local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
				if comp ~= nil then
					local values = {
						"run_velocity",
						"velocity_min_x",
						"velocity_max_x",
						"velocity_min_y",
						"velocity_max_y"
					}
	
					for _, v in ipairs(values) do
						ComponentSetValue2(comp,v,ComponentGetValue2(comp,v)*1.2)
					end
				end
	
			end
			oldfunc(entity_perk_item, entity_who_picked, item_name)
		end
	else 
		v.func = function ()
			total_perks_picked = total_perks_picked + 1;
			if has_movement_perk then 
				local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
				if comp ~= nil then
					local values = {
						"run_velocity",
						"velocity_min_x",
						"velocity_max_x",
						"velocity_min_y",
						"velocity_max_y"
					}
	
					for _, v in ipairs(values) do
						ComponentSetValue2(comp,v,ComponentGetValue2(comp,v)*1.2)
					end
				end
			end
		end
	end
end