dofile("data/scripts/lib/mod_settings.lua")
dofile_once("data/scripts/lib/utilities.lua")

function mod_setting_bool_souls(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = GameTextGet(value and "$souls_setting_on" or "$souls_setting_off")

    if in_main_menu then
		text = value and "ON!" or "Off"
	end

    if value then
        GuiColorSetForNextWidget(gui, 0.6, 1.0, 1.0, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.6, 0.4, 0.4, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		ModSettingSetNextValue(mod_setting_get_id(mod_id,setting), not value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, not value)
	end
	if right_clicked then
		local new_value = setting.value_default or false
		ModSettingSetNextValue(mod_setting_get_id(mod_id,setting), new_value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, new_value)
	end

	mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
end

function mod_setting_enum_souls(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "string" then value = setting.value_default or "" end

	local value_id = 1
	for i,val in ipairs(setting.values) do
		if val[1] == value then
			value_id = i
			break
		end
	end

	local text = setting.values[value_id][2]

    local p = value_id / #setting.values

    GuiColorSetForNextWidget(gui, 0.9 - 0.4 * p, 0.3 + 0.4 * p, 0.6 + 0.4 * p, 1.0)

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)
	
    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		local value_old = value
		value_id = value_id + 1
		if value_id > #(setting.values) then
			value_id = 1
		end
		value = setting.values[value_id][1]
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value_old, value )
	end
	if right_clicked and setting.value_default then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), setting.value_default, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, setting.value_default )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )

end

local mod_id = "souls"
mod_settings_version = 2
mod_settings = {
    {
        id = "say_soul",
        ui_name = "Say acquired soul",
        ui_description = "If you want to be told what souls you acquire.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "say_consumed_soul",
        ui_name = "Say consumed soul",
        ui_description = "If you want to be told what souls you consume when using adaptive spells.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "collect_soul_from_entity",
        ui_name = "Collect souls",
        ui_description = "If you want souls to spawn as an entity that must be collected.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "enable_soul_shops",
        ui_name = "Enable Soul Shops",
        ui_description = "If you want some items to be bought with souls instead of gold.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "button_down_gui",
        ui_name = "Press down to view full soul counts",
        ui_description = "If you want to be able to view your full soul counts (>99) by holding down.",
        value_default = false,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "button_z_gui",
        ui_name = "Press Z to view full soul counts",
        ui_description = "If you want to be able to view your full soul counts (>99) by holding Z.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "first_gui",
        ui_name = "Display soul counts in screen corner",
        ui_description = "Display soul counts in the bottom right corner.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_souls,
    },
    {
        id = "starting_souls",
        ui_name = "Start with souls",
        ui_description = "How many souls you want to start with (this is kinda cheaty).",
        value_default = "0",
        values = {{"0", "0"}, {"10", "10"}, {"20", "20"}, {"30", "30"}, {"40", "40"}, {"50", "50"}, {"60", "60"}, {"70", "70"}, {"80", "80"}, {"90", "90"}, {"100", "100"}},
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_enum_souls,
    },
    --[[{
        id = "spell_spawn_chance_multiplier",
        ui_name = "Spell spawn chance multiplier",
        ui_description = "How frequently do you want this mod's spells to spawn?",
        value_default = "1",
        values = {{"0.3", "x0.3"}, {"0.5", "x0.5"}, {"0.7", "x0.7"}, {"1", "x1"}, {"1.5", "x1.5"}, {"2", "x2"}},
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_enum_souls,
    },]]
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end


function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end