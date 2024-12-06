dofile_once("data/scripts/lib/mod_settings.lua")
dofile_once("data/scripts/lib/utilities.lua")

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "souls"
mod_settings_version = 1
mod_settings = {
    {
        image_filename = "mods/souls/ddd.png",
        ui_fn = mod_setting_image,
    },
    {
        id = "say_soul",
        ui_name = "Say acquired soul",
        ui_description = "If you want to be told what souls you acquire.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "say_consumed_soul",
        ui_name = "Say consumed soul",
        ui_description = "If you want to be told what souls you consume when using adaptive spells.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "collect_soul_from_entity",
        ui_name = "Collect souls",
        ui_description = "If you want souls to spawn as an entity that must be collected.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
    {
        id = "starting_souls",
        ui_name = "Start with souls",
        ui_description = "How many souls you want to start with (this is kinda cheaty).",
        value_default = 0,
        value_min = 0,
        value_max = 100,
        value_display_multiplier = 1,
        value_display_formatting = " $0 souls",
        scope = MOD_SETTING_SCOPE_NEW_GAME,
    },
    {
        id = "spell_spawn_chance_multiplier",
        ui_name = "Spell spawn chance multiplier",
        ui_description = "How frequently do you want this mod's spells to spawn.",
        value_default = 1.0,
        value_min = 0,
        value_max = 2,
        value_display_multiplier = 1,
        value_display_formatting = " $0x multiplier",
        scope = MOD_SETTING_SCOPE_NEW_GAME,
    },
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