--ModMagicNumbersFileAdd( "mods/souls/files/magic_numbers.xml" )
ModMaterialsFileAdd("mods/souls/files/materials.xml")

dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

dofile_once("mods/souls/lib/injection.lua")

-- appends
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/souls/files/actions.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/souls/files/perks.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/souls/files/status_list.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/souls/files/scripts/drop_money_append.lua" )
ModLuaFileAppend( "data/scripts/items/generate_shop_item.lua", "mods/souls/files/scripts/generate_shop_item_append.lua" )

-- nxml
local nxml = dofile_once("mods/souls/lib/nxml.lua")

local xml = nxml.parse(ModTextFileGetContent("data/entities/base_wand_pickup.xml"))
xml:add_child(nxml.parse(([[
    <VariableStorageComponent
        _tags="which_soul_type"
        name="which_soul_type"
        value_string="0"
    ></VariableStorageComponent>
]])))
xml:add_child(nxml.parse(([[
    <VariableStorageComponent
        _tags="which_soul_type_number"
        name="which_soul_type_number"
        value_int="1"
    ></VariableStorageComponent>
]])))
ModTextFileSetContent("data/entities/base_wand_pickup.xml", tostring(xml))

local xml = nxml.parse(ModTextFileGetContent("data/entities/items/pickup/spell_refresh.xml"))
xml:add_child(nxml.parse(([[
    <LuaComponent
        script_source_file="mods/souls/files/entities/items/soulrefresh/spawn.lua"
        execute_on_added="1"
        remove_after_executed="1"
    ></LuaComponent>
]])))
ModTextFileSetContent("data/entities/items/pickup/spell_refresh.xml", tostring(xml))

-- biome things
local biomes = {
    {
        path = "data/scripts/biomes/wizardcave.lua",
        script = "mods/souls/files/scripts/biome/wizardcave.lua",
    },
    {
        path = "data/scripts/biomes/wandcave.lua",
        script = "mods/souls/files/scripts/biome/wandcave.lua",
    },
    {
        path = "data/scripts/biomes/crypt.lua",
        script = "mods/souls/files/scripts/biome/crypt.lua",
    },
    {
        path = "data/scripts/biomes/coalmine.lua",
        script = "mods/souls/files/scripts/biome/coalmine.lua",
    },
    {
        path = "data/scripts/biomes/mountain_tree.lua",
        script = "mods/souls/files/scripts/biome/mountain_tree.lua",
    },
    {
        path = "data/scripts/biomes/the_end.lua",
        script = "mods/souls/files/scripts/biome/the_end.lua",
    },
}
for i,v in ipairs(biomes) do
    if ModTextFileGetContent(v.path) ~= nil then
        ModLuaFileAppend(v.path, v.script)
    end
end
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff3fe2df" biome_filename="mods/souls/files/biome/soulbiome/biome.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- drops
local dropdoers = {
    {
        path = "data/entities/animals/boss_alchemist/boss_alchemist.xml",
        script = "mods/souls/files/scripts/death/boss_alchemist.lua",
    },
    {
        path = "data/entities/animals/boss_limbs/boss_limbs.xml",
        script = "mods/souls/files/scripts/death/boss_limbs.lua",
    },
    {
        path = "data/entities/animals/boss_pit/boss_pit.xml",
        script = "mods/souls/files/scripts/death/boss_pit.lua",
    },
    {
        path = "data/entities/animals/boss_dragon.xml",
        script = "mods/souls/files/scripts/death/boss_dragon.lua",
    },
    {
        path = "data/entities/animals/boss_wizard/boss_wizard.xml",
        script = "mods/souls/files/scripts/death/boss_wizard.lua",
    },
    {
        path = "data/entities/animals/boss_fish/fish_giga.xml",
        script = "mods/souls/files/scripts/death/boss_fish.lua",
    },
    {
        path = "data/entities/animals/boss_spirit/islandspirit.xml",
        script = "mods/souls/files/scripts/death/boss_deer.lua",
    },
    {
        path = "data/entities/animals/boss_ghost/boss_ghost.xml",
        script = "mods/souls/files/scripts/death/boss_ghost.lua",
    },
    {
        path = "data/entities/animals/boss_meat/boss_meat.xml",
        script = "mods/souls/files/scripts/death/boss_meat.lua",
    },
    {
        path = "data/entities/animals/boss_robot/boss_robot.xml",
        script = "mods/souls/files/scripts/death/boss_robot.lua",
    },
    {
        path = "data/entities/animals/maggot_tiny/maggot_tiny.xml",
        script = "mods/souls/files/scripts/death/maggot_tiny.lua",
    },
}

for i,v in ipairs(dropdoers) do
    local xml = nxml.parse(ModTextFileGetContent(v.path))
    xml:add_child(nxml.parse(([[
        <LuaComponent
              script_death="%s"
              >
        </LuaComponent>
    ]]):format(v.script)))
    ModTextFileSetContent(v.path, tostring(xml))
end

-- clouds
local clouds = {
    "data/entities/projectiles/deck/cloud_acid.xml",
    "data/entities/projectiles/deck/cloud_blood.xml",
    "data/entities/projectiles/deck/cloud_oil.xml",
    "data/entities/projectiles/deck/cloud_thunder.xml",
    "data/entities/projectiles/deck/cloud_water.xml",
}
for i,v in ipairs(clouds) do
    local xml = nxml.parse(ModTextFileGetContent(v))
    xml.attr.tags = xml.attr.tags .. ",spell_cloud"
    ModTextFileSetContent(v, tostring(xml))
end

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

local scenes = {
    { 13080, 1650, "mods/souls/files/biome/souldoor/souldoor.xml", false },
    { -1568, -400, "mods/souls/files/biome/soulplace/place.xml", false },
    { -1144, -455, "mods/souls/files/biome/soulplace/sign.xml", false },
    { -270, 18100, "mods/souls/files/biome/amphitheatre/amphitheatre.xml", false },
    { 0, 19500, "mods/souls/files/biome/soulshop/soulshop.xml", true },
}

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

-- player
function OnPlayerSpawned(player)

    dofile_once("mods/souls/files/scripts/souls.lua")

    dofile_once("mods/souls/files/gui.lua")

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("souls_init") then return end

    SoulsInit()

    GlobalsSetValue("souls.collect_soul_from_entity", tostring(ModSettingGet("souls.collect_soul_from_entity")))
    GlobalsSetValue("souls.say_soul", tostring(ModSettingGet("souls.say_soul")))
    GlobalsSetValue("souls.say_consumed_soul", tostring(ModSettingGet("souls.say_consumed_soul")))
    GlobalsSetValue("souls.enable_soul_shops", tostring(ModSettingGet("souls.enable_soul_shops")))
    GlobalsSetValue("souls.button_down_gui", tostring(ModSettingGet("souls.button_down_gui")))

    GlobalsSetValue("souls.amphitheatre_enemy_count", "10")

    --EntityLoad("mods/souls/files/entities/items/tome/weapon.xml", px, py)
    --EntityLoad("mods/souls/files/entities/items/soul_emulator/item.xml", px, py)
    --EntityLoad("mods/souls/files/entities/items/soul_of_the_diviner/item.xml", px, py)
    --GlobalsSetValue("souls.soul_emulator_state", "3")
    --EntityLoad("data/entities/animals/moldos_boss_soul.xml", 0, -100)
    --CreateItemActionEntity("MOLDOS_UPGRADE_TOME", px, py)
    --for i=1,3 do EntityLoad("data/entities/animals/moldos_soul_rogue.xml", 0, -100) end
    --for i=1,300 do AddSouls(GetRandomSoulType(true), 10) end
    --EntityLoad("mods/souls/files/entities/items/_soulcrystals/alchemist.xml", px, py)
    --GenerateSoulShopItem(px, py)
    --EntityLoad("data/entities/animals/moldos_soul_eye.xml", px, py)

    for i=1,tonumber(ModSettingGet("souls.starting_souls")) do
        local which = soul_types[math.random(1,#soul_types)]
        if which == "souls_void" then
            which = "orcs"
        end
        if which == "boss" then
            which = "orcs"
        end
        AddSouls(which, 1)
    end
    
    EntityAddComponent2(player, "LuaComponent", {
        script_damage_about_to_be_received="mods/souls/files/scripts/player_damage_handler.lua",
        --script_damage_received="mods/souls/files/scripts/player_damage_handler.lua",
    })

    EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/souls/files/scripts/player_everyframe.lua",
        execute_every_n_frame=1,
    })

    GameAddFlagRun("souls_init")
end

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/souls/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end

-- genomes
dofile_once("mods/souls/files/scripts/genomes.lua")

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
        GlobalsSetValue("souls.collect_soul_from_entity", tostring(ModSettingGet("souls.collect_soul_from_entity")))
        GlobalsSetValue("souls.say_soul", tostring(ModSettingGet("souls.say_soul")))
        GlobalsSetValue("souls.say_consumed_soul", tostring(ModSettingGet("souls.say_consumed_soul")))
        GlobalsSetValue("souls.enable_soul_shops", tostring(ModSettingGet("souls.enable_soul_shops")))
        GlobalsSetValue("souls.button_down_gui", tostring(ModSettingGet("souls.button_down_gui")))
    end
end