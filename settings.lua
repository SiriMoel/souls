dofile("data/scripts/lib/mod_settings.lua")
dofile_once("data/scripts/lib/utilities.lua")
--dofile_once("mods/souls/files/scripts/keys.lua")

skeys = {
    [4] = "A",
    [5] = "B",
    [6] = "C",
    [7] = "D",
    [8] = "E",
    [9] = "F",
    [10] = "G",
    [11] = "H",
    [12] = "I",
    [13] = "J",
    [14] = "K",
    [15] = "L",
    [16] = "M",
    [17] = "N",
    [18] = "O",
    [19] = "P",
    [20] = "Q",
    [21] = "R",
    [22] = "S",
    [23] = "T",
    [24] = "U",
    [25] = "V",
    [26] = "W",
    [27] = "X",
    [28] = "Y",
    [29] = "Z",
    [30] = "1",
    [31] = "2",
    [32] = "3",
    [33] = "4",
    [34] = "5",
    [35] = "6",
    [36] = "7",
    [37] = "8",
    [38] = "9",
    [39] = "0",
    [40] = "Return",
    [42] = "Back",
    [43] = "Tab",
    [44] = "Space",
    [45] = "-",
    [46] = "=",
    [47] = "[",
    [48] = "]",
    [49] = [[\]],
    [51] = ";",
    [52] = "'",
    [53] = ",",
    [54] = "~",
    [55] = ".",
    [56] = "/",
    [57] = "CAPS",
    [73] = "Ins",
    [74] = "Home",
    [75] = "PgUp",
    [76] = "Del",
    [77] = "End",
    [78] = "PgDown",
    [79] = "Right",
    [80] = "Left",
    [81] = "Down",
    [82] = "Up",
    [83] = "Num",
    [84] = "KpDiv",
    [85] = "KpMult",
    [86] = "KpMinus",
    [87] = "KpPlus",
    [88] = "KpEnter",
    [89] = "Kp1",
    [90] = "Kp2",
    [91] = "Kp3",
    [92] = "Kp4",
    [93] = "Kp5",
    [94] = "Kp6",
    [95] = "Kp7",
    [96] = "Kp8",
    [97] = "Kp9",
    [98] = "Kp0",
    [99] = "Kp.",
    [103] = "KpEquals",
}

function mod_setting_bool_souls(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = "" 

    if in_main_menu then
		text = value and "ON!" or "Off"
	else
        text = GameTextGet(value and "$souls_setting_on" or "$souls_setting_off")
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

    GuiColorSetForNextWidget(gui, 0.7 - 0.4 * p, 0.3 + 0.4 * p, 0.6 + 0.4 * p, 1.0)

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

function mod_setting_category_button_souls(mod_id, gui, im_id, im_id2, category)
	local image_file = "mods/souls/files/ui_gfx/button_fold_close.png"
	if category._folded then
		image_file = "mods/souls/files/ui_gfx/button_fold_open.png"
	end

	GuiLayoutBeginHorizontal( gui, 0, 0 )
	GuiIdPush( gui, 892304589 )

	--GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawSemiTransparent )
    GuiColorSetForNextWidget(gui, 0.7, 0.7, 0.7, 0.8)
	local clicked1 = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, category.ui_name )
    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)
	if is_visible_string( category.ui_description ) then
		GuiTooltip( gui, category.ui_description, "" )
	end

	GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawActiveWidgetCursorOff )
	GuiOptionsAddForNextWidget( gui, GUI_OPTION.NoPositionTween )
	local clicked2 = GuiImageButton( gui, im_id2, 0, 0, "", image_file )
	if is_visible_string( category.ui_description ) then
		GuiTooltip( gui, category.ui_description, "" )
	end

	local clicked = clicked1 or clicked2
	if clicked then
		category._folded = not category._folded
	end

	GuiIdPop( gui )
	GuiLayoutEnd( gui )

	return clicked
end

function mod_setting_souls_key_magic(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue(mod_setting_get_id(mod_id, setting))
	if type(value) ~= "boolean" then value = setting.value_default or false end

    local key_now = ModSettingGetNextValue(setting.key_setting)

    local key_string = (skeys[key_now] ~= nil) and ("[" .. skeys[key_now] .. "]") or "???"

    local text = value and "!!! " or key_string

    if value then
        GuiColorSetForNextWidget(gui, 1.0, 0.4, 0.7, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.6, 1.0, 1.0, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1.0)

    local text_offset = math.max(GuiGetTextDimensions(gui, text) + 4, 24)

    local clicked, right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + text_offset, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    local set_key

    if value then
        for key = 4, 103 do
            if skeys[key] ~= nil and InputIsKeyDown(key) then
                set_key = key
                break
            end
        end
        if set_key ~= nil then
            ModSettingSetNextValue(setting.key_setting, set_key, false)
            ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), false, false)
        end
    end

    if clicked then
		ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), not value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, not value)
	end
    if right_clicked then
        ModSettingSetNextValue(setting.key_setting, setting.key_setting_default, false)
        ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), false, false)
        mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, false, setting.value_default)
    end

	mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)

end

local mod_id = "souls"
mod_settings_version = 3
mod_settings = {
    {
        category_id = "souls_comms",
        ui_name = "Alerts",
        ui_description = "What do you want to be told?",
        foldable = true,
        _folded = true,
        settings = {
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
                id = "say_not_enough",
                ui_name = "Say not enough souls",
                ui_description = "If you want to be told when you don't have enough souls when casting spells.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
        },
    },
    {
        category_id = "souls_counts",
        ui_name = "GUI Settings",
        ui_description = "Souls GUI settings...",
        foldable = true,
        _folded = true,
        settings = {
            {
		        id = "souls_gui_key",
		        ui_name = "Souls Gui Key",
		        value_default = 29,
		        hidden = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
	        },
            {
                id = "set_gui_key",
                ui_name = "Bind key to view your souls",
                ui_description = "Click this and then press the desired key.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_souls_key_magic,
                key_setting = "souls.souls_gui_key",
                key_setting_default = 29,
            },
            {
                id = "total_boss",
                ui_name = "Include boss souls in total soul count",
                ui_description = "Boss souls aren't normally consumed like other souls.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "hats",
                ui_name = "Enable hats",
                ui_description = "Some souls have an unlockable hat in the GUI.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "first_gui",
                ui_name = "Display soul counts in screen corner",
                ui_description = "Display soul counts in the bottom right corner.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
        },
    },
    {
        category_id = "souls_structures",
        ui_name = "Structures",
        ui_description = "Toggle the structures of this mod.\nWarning: Disabling structures may interfere with certain content in the mod.",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "enable_souldoor",
                ui_name = "Enable Gate?",
                ui_description = "Should this structure appear?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "enable_soulplace",
                ui_name = "Enable the structure in the tree?",
                ui_description = "Should this structure appear?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "enable_amphitheatre",
                ui_name = "Enable Amphitheatre?",
                ui_description = "Should this structure appear?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "enable_shop_structure",
                ui_name = "Enable Shop structure?",
                ui_description = "Should this structure appear?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_bool_souls,
            },
        },
    },
    {
        category_id = "souls_enemies",
        ui_name = "Enemies",
        ui_description = "Adjust the spawning of the mod's enemies.",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "enable_enemies",
                ui_name = "Enable Souls enemies?",
                ui_description = "Should this mod's enemies appear at all?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_bool_souls,
            },
            {
                id = "enemy_puppet_master",
                ui_name = "Nukkejenmestari chance",
                ui_description = "Adjust how often the Souls Master appears.",
                value_default = "1",
                values = {{"0", "0x"}, {"0.3", "0.3x"}, {"0.5", "0.5x"}, {"0.7", "0.7x"}, {"1", "1x"}, {"1.3", "1.3x"}, {"1.5", "1.5x"}},
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_enum_souls,
            },
            {
                id = "enemy_soul_angry",
                ui_name = "Ilkeä naama chance",
                ui_description = "Adjust how often the Angry Soul appears.",
                value_default = "1",
                values = {{"0", "0x"}, {"0.3", "0.3x"}, {"0.5", "0.5x"}, {"0.7", "0.7x"}, {"1", "1x"}, {"1.3", "1.3x"}, {"1.5", "1.5x"}},
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_enum_souls,
            },
            {
                id = "enemy_soul_rogue",
                ui_name = "Roisto sielu chance",
                ui_description = "Adjust how often the Rogue Soul appears.",
                value_default = "1",
                values = {{"0", "0x"}, {"0.3", "0.3x"}, {"0.5", "0.5x"}, {"0.7", "0.7x"}, {"1", "1x"}, {"1.3", "1.3x"}, {"1.5", "1.5x"}},
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_enum_souls,
            },
            {
                id = "enemy_soul_eye",
                ui_name = "Sielun silmä chance",
                ui_description = "Adjust how often the Soul Eye appears.",
                value_default = "1",
                values = {{"0", "0x"}, {"0.3", "0.3x"}, {"0.5", "0.5x"}, {"0.7", "0.7x"}, {"1", "1x"}, {"1.3", "1.3x"}, {"1.5", "1.5x"}},
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_enum_souls,
            },
            {
                id = "enable_hauntings",
                ui_name = "Enable Hauntings",
                ui_description = "This is NYI!",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
        },
    },
    {
        category_id = "misc",
        ui_name = "Miscellaneous",
        ui_description = "More settings!",
        foldable = true,
        _folded = true,
        settings = {
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
                ui_description = "Should some items be bought with souls instead of gold?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_bool_souls,
            },
            --[[{
                id = "starting_souls",
                ui_name = "Start with souls",
                ui_description = "How many souls you want to start with (this is kinda cheaty).",
                value_default = "0",
                values = {{"0", "0"}, {"10", "10"}, {"20", "20"}, {"30", "30"}, {"40", "40"}, {"50", "50"}, {"60", "60"}, {"70", "70"}, {"80", "80"}, {"90", "90"}, {"100", "100"}},
                scope = MOD_SETTING_SCOPE_NEW_GAME,
                ui_fn = mod_setting_enum_souls,
            },]]
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

function souls_mod_settings_gui( mod_id, settings, gui, in_main_menu )
	local im_id = 1

	for i,setting in ipairs(settings) do
		if setting.category_id ~= nil then
			-- setting category
			GuiIdPush( gui, im_id )
			if setting.foldable then
				local im_id2 = im_id
				im_id = im_id + 1
				local clicked_category_heading = mod_setting_category_button_souls( mod_id, gui, im_id, im_id2, setting )
				if not setting._folded then
					GuiAnimateBegin( gui )
					GuiAnimateAlphaFadeIn( gui, 3458923234, 0.1, 0.0, clicked_category_heading )
					mod_setting_group_x_offset = mod_setting_group_x_offset + 6
					souls_mod_settings_gui( mod_id, setting.settings, gui, in_main_menu )
					mod_setting_group_x_offset = mod_setting_group_x_offset - 6
					GuiAnimateEnd( gui )
					GuiLayoutAddVerticalSpacing( gui, 4 )
				end
			else
				GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawSemiTransparent )
				GuiText( gui, mod_setting_group_x_offset, 0, setting.ui_name )
				if is_visible_string( setting.ui_description ) then
					GuiTooltip( gui, setting.ui_description, "" )
				end
				mod_setting_group_x_offset = mod_setting_group_x_offset + 2
				souls_mod_settings_gui( mod_id, setting.settings, gui, in_main_menu )
				mod_setting_group_x_offset = mod_setting_group_x_offset - 2
				GuiLayoutAddVerticalSpacing( gui, 4 )
			end
			GuiIdPop( gui )
		else
			-- setting
			local auto_gui = setting.ui_fn == nil
			local visible = (setting.hidden == nil or not setting.hidden)
			if auto_gui and visible then
				local value_type = type(setting.value_default)
				if setting.not_setting then
					mod_setting_title( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "boolean" then
					mod_setting_bool( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "number" then
					mod_setting_number( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "string" and setting.values ~= nil then
					mod_setting_enum( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "string" then
					mod_setting_text( mod_id, gui, in_main_menu, im_id, setting )
				end
			elseif visible then
				setting.ui_fn( mod_id, gui, in_main_menu, im_id, setting )
			end
		end

		im_id = im_id+1
	end
end

function ModSettingsGui(gui, in_main_menu)
	souls_mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end