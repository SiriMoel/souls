--ModMagicNumbersFileAdd( "mods/souls/files/magic_numbers.xml" )
ModMaterialsFileAdd("mods/souls/files/materials.xml")

dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

dofile_once("mods/souls/lib/injection.lua")

-- appends
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/souls/files/actions.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/souls/files/perks.lua")
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/souls/files/scripts/status_list.lua")
ModLuaFileAppend("data/scripts/items/drop_money.lua", "mods/souls/files/scripts/drop_money_append.lua")
ModLuaFileAppend("data/scripts/items/generate_shop_item.lua", "mods/souls/files/scripts/generate_shop_item_append.lua")
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/souls/files/scripts/gun_append.lua")

-- nxml
local nxml = dofile_once("mods/souls/lib/nxml.lua")

dofile_once("mods/souls/files/scripts/gizmo.lua")

-- biome things
local biomes = {
    {path = "data/scripts/biomes/coalmine.lua", script = "mods/souls/files/scripts/biome/coalmine.lua"},
    {path = "data/scripts/biomes/mountain_tree.lua", script = "mods/souls/files/scripts/biome/mountain_tree.lua"},
    {path = "data/scripts/biomes/the_end.lua", script = "mods/souls/files/scripts/biome/the_end.lua"},
}
for i,v in ipairs(biomes) do
    if ModTextFileGetContent(v.path) ~= nil then ModLuaFileAppend(v.path, v.script) end
end

-- enemies
if ModSettingGet("souls.enable_enemies") == true then
    local enemies = {
        {
            func_add = function()
                ModLuaFileAppend("data/scripts/biomes/wandcave.lua", "mods/souls/files/scripts/enemies/puppet_master_wandcave.lua")
                ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/souls/files/scripts/enemies/puppet_master_wizardcave.lua")
            end,
            func_enabled = function() 
                local prob_mult = tonumber(ModSettingGet("souls.enemy_puppet_master"))
                if prob_mult > 0 then return true end
                return false
            end,
        },
        {
            func_add = function()
                ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/souls/files/scripts/enemies/soul_angry_wizardcave.lua")
                ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/souls/files/scripts/enemies/soul_angry_the_end.lua")
            end,
            func_enabled = function() 
                local prob_mult = tonumber(ModSettingGet("souls.enemy_soul_angry"))
                if prob_mult > 0 then return true end
                return false
            end,
        },
        {
            func_add = function()
                ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/souls/files/scripts/enemies/soul_rogue_the_end.lua")
            end,
            func_enabled = function() 
                local prob_mult = tonumber(ModSettingGet("souls.enemy_soul_rogue"))
                if prob_mult > 0 then return true end
                return false
            end,
        },
        {
            func_add = function()
                ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/souls/files/scripts/enemies/soul_eye_the_end.lua")
            end,
            func_enabled = function() 
                local prob_mult = tonumber(ModSettingGet("souls.enemy_soul_eye"))
                if prob_mult > 0 then return true end
                return false
            end,
        },
    }
    for _, v in ipairs(enemies) do
        if v.func_enabled() == true then
            v.func_add()
        end
    end
end

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
	local translations_files = {
		"mods/souls/files/translations/translations.csv",
        "mods/souls/files/translations/spells.csv",
        "mods/souls/files/translations/souls.csv",
        "mods/souls/files/translations/items.csv",
        "mods/souls/files/translations/materials.csv",
        "mods/souls/files/translations/effects.csv",
        "mods/souls/files/translations/animals.csv",
        "mods/souls/files/translations/perks.csv",
	}
	for _,v in ipairs(translations_files) do
		while translations:find("\r\n\r\n") do
        	translations = translations:gsub("\r\n\r\n","\r\n")
    	end
    	local new_translations = ModTextFileGetContent(table.concat({v}))
    	translations = translations .. new_translations
	end
	ModTextFileSetContent("data/translations/common.csv", translations)
end

-- idk???
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff3fe2df" biome_filename="mods/souls/files/biome/soulbiome/biome.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- pixel scenes (thanks graham)
local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
	for i = 1, #table do
		string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		if table[i][4] then
			-- make things show up in first 2 parallel worlds
			-- hopefully this won't cause too much lag when starting a run
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end
local scenes = {}
local possible_scenes = {
    {
        scene = {13080, 1650, "mods/souls/files/biome/souldoor/souldoor.xml", false},
        func = function() return ModSettingGet("souls.enable_souldoor") end,
    },
    {
        scene = {-1568, -400, "mods/souls/files/biome/soulplace/place.xml", false},
        func = function() return ModSettingGet("souls.enable_soulplace") end,
    },
    {
        scene = {-1144, -455, "mods/souls/files/biome/soulplace/sign.xml", false},
        func = function() return ModSettingGet("souls.enable_soulplace") end,
    },
    {
        scene = {-270, 18100, "mods/souls/files/biome/amphitheatre/amphitheatre.xml", false},
        func = function() return ModSettingGet("souls.enable_amphitheatre") end,
    },
    {
        scene = {0, 19500, "mods/souls/files/biome/soulshop/soulshop.xml", true},
        func = function() return ModSettingGet("souls.enable_shop_structure") end,
    },
}
for _,v in ipairs(possible_scenes) do
    if v.func() then table.insert(scenes, v.scene) end
end
add_scene(scenes)

-- shaders (ty nathan)
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "// liquid distortion", "mods/souls/files/shaders/pre.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "gl_FragColor", "mods/souls/files/shaders/post.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;", "mods/souls/files/shaders/global.frag")
GameSetPostFxParameter("souls_boss_soul_effect_amount", 0, 0, 0, 0)

-- apotheosis
if ModIsEnabled("Apotheosis") then
    --print("Souls - Apotheosis detected!")
end

-- glimmers expanded
if ModIsEnabled("GlimmersExpanded") then
    --print("Souls - GlimmersExpanded detected!")
	ModLuaFileAppend("mods/GlimmersExpanded/files/lib/glimmer_data.lua", "mods/souls/files/scripts/glimmersexpanded.lua")
end

-- meta leveling
if ModIsEnabled("meta_leveling") then
    ModLuaFileAppend("mods/meta_leveling/files/for_modders/rewards_append.lua", "mods/souls/files/scripts/ml_rewards.lua")
    ModLuaFileAppend("mods/meta_leveling/files/for_modders/progress_appends.lua", "mods/souls/files/scripts/ml_progress.lua")
    --ModLuaFileAppend("mods/meta_leveling/files/for_modders/stats_append.lua", "mods/souls/files/scripts/ml_stats.lua")
end

if ModIsEnabled("cheatgui") then
	ModLuaFileAppend("data/hax/special_spawnables.lua", "mods/souls/files/scripts/cheatgui_special_spawnables.lua")
end

if ModIsEnabled("foolish_flame") then
	ModLuaFileAppend("mods/foolish_flame/files/scripts/bounty_rewards.lua", "mods/souls/files/scripts/ff_bounty_rewards.lua")
end

-- player
function OnPlayerSpawned(player)

    dofile_once("mods/souls/files/scripts/souls.lua")

    dofile_once("mods/souls/files/gui.lua")

    if not HasFlagPersistent("souls_updated_1_5") then
        AddFlagPersistent("souls_updated_1_5")
        SoulsPrintImportant("Souls has been (majorly) updated!", "The change notes are on the workshop page.", "divine")
    end

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("souls_init") then return end

    SoulsInit(player)

    GlobalsSetValue("souls.collect_soul_from_entity", tostring(ModSettingGet("souls.collect_soul_from_entity")))
    GlobalsSetValue("souls.say_soul", tostring(ModSettingGet("souls.say_soul")))
    GlobalsSetValue("souls.say_consumed_soul", tostring(ModSettingGet("souls.say_consumed_soul")))
    GlobalsSetValue("souls.say_not_enough", tostring(ModSettingGet("souls.say_not_enough")))
    GlobalsSetValue("souls.enable_soul_shops", tostring(ModSettingGet("souls.enable_soul_shops")))
    GlobalsSetValue("souls.first_gui", tostring(ModSettingGet("souls.first_gui")))
    GlobalsSetValue("souls.souls_gui_key", tostring(ModSettingGet("souls.souls_gui_key")))
    --GlobalsSetValue("souls.spell_spawn_chance_multiplier", tostring(ModSettingGet("souls.spell_spawn_chance_multiplier")))
    GlobalsSetValue("souls.enable_enemies", tostring(ModSettingGet("souls.enable_enemies")))
    GlobalsSetValue("souls.enemy_puppet_master", tostring(ModSettingGet("souls.enemy_puppet_master")))
    GlobalsSetValue("souls.enemy_soul_angry", tostring(ModSettingGet("souls.enemy_soul_angry")))
    GlobalsSetValue("souls.enemy_soul_rogue", tostring(ModSettingGet("souls.enemy_soul_rogue")))
    GlobalsSetValue("souls.enemy_soul_eye", tostring(ModSettingGet("souls.enemy_soul_eye")))

    GlobalsSetValue("souls.amphitheatre_enemy_count", "10")

    local starting_souls = tonumber(ModSettingGet("souls.starting_souls")) or 0
    if starting_souls > 0 then
        local souls = {}
        for i=1,starting_souls do
            local which = soul_types[Random(1, #soul_types - 2)]
            souls[which] = (souls[which] or 0) + 1
        end
        EditSoulCounts(souls, player)
    end
    
    EntityAddComponent2(player, "LuaComponent", {
        script_damage_about_to_be_received="mods/souls/files/scripts/player_damage_handler.lua",
        --script_damage_received="mods/souls/files/scripts/player_damage_handler.lua",
    })

    EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/souls/files/scripts/player_everyframe.lua",
        execute_every_n_frame=1,
    })

    --AcquireManySouls(player) -- DONT FORGET TO COMMENT THIS!!!

    GameAddFlagRun("souls_init")
end

-- genomes
dofile_once("mods/souls/files/scripts/genomes.lua")

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
        GlobalsSetValue("souls.collect_soul_from_entity", tostring(ModSettingGet("souls.collect_soul_from_entity")))
        GlobalsSetValue("souls.say_soul", tostring(ModSettingGet("souls.say_soul")))
        GlobalsSetValue("souls.say_consumed_soul", tostring(ModSettingGet("souls.say_consumed_soul")))
        GlobalsSetValue("souls.say_not_enough", tostring(ModSettingGet("souls.say_not_enough")))
        GlobalsSetValue("souls.enable_soul_shops", tostring(ModSettingGet("souls.enable_soul_shops")))
        GlobalsSetValue("souls.first_gui", tostring(ModSettingGet("souls.first_gui")))
        --GlobalsSetValue("souls.spell_spawn_chance_multiplier", tostring(ModSettingGet("souls.spell_spawn_chance_multiplier")))

        GlobalsSetValue("souls.souls_gui_key", tostring(ModSettingGet("souls.souls_gui_key")))
        
        GlobalsSetValue("souls.enable_enemies", tostring(ModSettingGet("souls.enable_enemies")))
        GlobalsSetValue("souls.enemy_puppet_master", tostring(ModSettingGet("souls.enemy_puppet_master")))
        GlobalsSetValue("souls.enemy_soul_angry", tostring(ModSettingGet("souls.enemy_soul_angry")))
        GlobalsSetValue("souls.enemy_soul_rogue", tostring(ModSettingGet("souls.enemy_soul_rogue")))
        GlobalsSetValue("souls.enemy_soul_eye", tostring(ModSettingGet("souls.enemy_soul_eye")))
    end
end