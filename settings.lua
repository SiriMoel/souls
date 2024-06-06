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

local mod_id = "tales_of_kupoli"
mod_settings_version = 1 
mod_settings = {
    {
        image_filename = "mods/tales_of_kupoli/aaa.png",
        ui_fn = mod_setting_image,
    },
    {
        category_id = "soul_settings",
        ui_name = "Soul-related settings",
        ui_description = "Tales' soul related settings",
        settings = {
            --[[{
		        id = "spawn_with_soul_spells",
                ui_name = "Spawn with Soul Spells",
                ui_description = "If you want to spawn with some Soul related spells.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
	        },]]
            {
                id = "show_souls",
                ui_name = "Render Souls (recommended Off)",
                ui_description = "If you want to see souls around your player in game.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
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
            --[[{
                id = "spawn_tome",
                ui_name = "Spawn Tome",
                ui_description = "If you want spawn with the Soul Tome.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },]]--
            {
				id = "starting_souls",
				ui_name = "Start with souls",
				ui_description = "How many souls you want to start with (this is kinda cheaty)",
				value_default = 0,
				value_min = 0,
				value_max = 100,
				value_display_multiplier = 1,
				value_display_formatting = " $0 souls",
				scope = MOD_SETTING_SCOPE_NEW_GAME,
			},
        },
    },
    {
        category_id = "other_settings",
        ui_name = "Other Settings",
        ui_description = "The mod's other settings",
        settings = {
            {
                id = "inject_spells",
                ui_name = "Inject Spells",
                ui_description = "If you want spells to be injected throughout vanilla spells.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
            {
                id = "sunbook_unlocked_on_start",
                ui_name = "Start with Sun Tablet unlocked",
                ui_description = "",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
            {
                id = "redsun_altar",
                ui_name = "Red Sun Tablets at Mountain Altar",
                ui_description = "If you want Red Sun Tablets to be usable at the mountain altar.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
            {
                id = "mina_pearl",
                ui_name = "Mould N Pearl",
                ui_description = "If you want to start with the pearl from Mould N.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
        },
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