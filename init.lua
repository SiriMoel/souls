dofile_once("mods/tales_of_kupoli/lib/gusgui/gusgui.lua").init("mods/tales_of_kupoli/lib/gusgui")
--ModMagicNumbersFileAdd( "mods/tales_of_kupoli/files/magic_numbers.xml" )
ModMaterialsFileAdd("mods/tales_of_kupoli/files/materials.xml")

dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
--dofile_once("mods/tales_of_kupoli/files/scripts/molebiomes.lua")

--PatchGunSystem()

local nxml = dofile_once("mods/tales_of_kupoli/lib/nxml.lua")

--[[if ModSettingGet("tales_of_kupoli.alt_map") then
    ModMagicNumbersFileAdd( "mods/tales_of_kupoli/files/magic_numbers.xml" )
end]]

-- set & append
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/tales_of_kupoli/files/actions.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/tales_of_kupoli/files/perks.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/tales_of_kupoli/files/status_list.lua" )
ModLuaFileAppend( "data/scripts/items/orb_pickup.lua", "mods/tales_of_kupoli/files/scripts/orb_pickup_append.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/tales_of_kupoli/files/scripts/drop_money_append.lua" )
--ModLuaFileAppend( "data/scripts/biome/temple_altar_left.lua", "mods/tales_of_kupoli/files/scripts/temple_altar_left_things.lua" )
--ModLuaFileAppend( "data/scripts/biome/temple_altar_left_empty.lua", "mods/tales_of_kupoli/files/scripts/temple_altar_left_things.lua" )
ModLuaFileAppend( "data/scripts/gun/gun.lua", "mods/tales_of_kupoli/files/scripts/gun_append.lua" )
--ModLuaFileAppend( "data/scripts/biomes/orbrooms/orbroom_07.lua", "mods/tales_of_kupoli/files/scripts/orbroom_07_append.lua" )

SetFileContent("data/scripts/buildings/sun/spot_4.lua", "spot_4.lua")
SetFileContent("data/scripts/buildings/sun/sun_collision.lua", "sun_collision.lua")
SetFileContent("data/entities/items/pickup/sun/sunbaby.xml", "sunbaby.xml")
SetFileContent("data/entities/items/orbs/orb_base.xml", "orb_base.xml")
SetFileContent("data/entities/items/pickup/sun/newsun.xml", "newsun.xml")
SetFileContent("data/entities/items/pickup/sun/newsun_dark.xml", "newsun_dark.xml")
--SetFileContent("data/biome/orbrooms/orbroom_07.xml", "orbroom_07.xml")
SetFileContent("data/entities/projectiles/deck/cloud_thunder.xml", "cloud_thunder.xml")
SetFileContent("data/entities/projectiles/deck/cloud_blood.xml", "cloud_blood.xml")
SetFileContent("data/entities/projectiles/deck/cloud_oil.xml", "cloud_oil.xml")
SetFileContent("data/entities/projectiles/deck/cloud_water.xml", "cloud_water.xml")
SetFileContent("data/entities/projectiles/deck/cloud_acid.xml", "cloud_acid.xml")
SetFileContent("data/scripts/biomes/tower_end.lua", "tower_end.lua")
--SetFileContent("data/scripts/biomes/temple_altar.lua", "temple_altar.lua")
SetFileContent("data/entities/buildings/teleport_liquid_powered.xml", "teleport_liquid_powered.xml")

local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml"))
xml:add_child(nxml.parse([[
    <LuaComponent
        _enabled="1" 
        execute_every_n_frame="240"
        script_source_file="mods/tales_of_kupoli/files/scripts/mountain_altar_things.lua" 
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml", tostring(xml))

-- enemies
local biomes = {
    {
        path = "data/scripts/biomes/wizardcave.lua",
        script = "mods/tales_of_kupoli/files/scripts/biome/wizardcave.lua",
    },
    {
        path = "data/scripts/biomes/wandcave.lua",
        script = "mods/tales_of_kupoli/files/scripts/biome/wandcave.lua",
    },
    {
        path = "data/scripts/biomes/crypt.lua",
        script = "mods/tales_of_kupoli/files/scripts/biome/crypt.lua",
    },
    {
        path = "data/scripts/biomes/coalmine.lua",
        script = "mods/tales_of_kupoli/files/scripts/biome/coalmine.lua",
    },
}
for i,v in ipairs(biomes) do
    if ModTextFileGetContent(v.path) ~= nil then
        ModLuaFileAppend(v.path, v.script)
    end
end

--drops etc
local dropdoers = {
    --hiisi
    {
        path = "data/entities/animals/shotgunner.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_shotgunner.lua",
    },
    {
        path = "data/entities/animals/sniper.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_sniper.lua",
    },
    {
        path = "data/entities/animals/scavenger_smg.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_pistol.lua",
    },
    {
        path = "data/entities/animals/scavenger_glue.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_glue.lua",
    },
    {
        path = "data/entities/animals/scavenger_poison.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_poison.lua",
    },
    {
        path = "data/entities/animals/scavenger_mine.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_mine.lua",
    },

    --bosses
    {
        path = "data/entities/animals/boss_dragon.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/dragon.lua",
    },
    {
        path = "data/entities/animals/boss_alchemist/boss_alchemist.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_alchemist.lua",
    },
    {
        path = "data/entities/animals/boss_limbs/boss_limbs.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_pyramid.lua",
    },
    {
        path = "data/entities/animals/boss_robot/boss_robot.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_robot.lua",
    },
    {
        path = "data/entities/animals/boss_pit/boss_pit.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_squid.lua",
    },
    {
        path = "data/entities/animals/boss_centipede/boss_centipede.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_kolmi.lua",
    },
    {
        path = "data/entities/animals/maggot_tiny/maggot_tiny.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_tiny.lua",
    },
    {
        path = "data/entities/animals/boss_wizard/boss_wizard.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/grandmaster.lua",
    },
    {
        path = "data/entities/animals/boss_ghost/boss_ghost.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/boss_ghost.lua",
    },

    --other
    {
        path = "data/entities/animals/lukki/lukki_dark.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/dark_lukki.lua",
    },
    {
        path = "data/entities/animals/goblin_bomb.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/goblin_bomb.lua",
    },
    {
        path = "data/entities/animals/fish.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/fish.lua",
    },
    {
        path = "data/entities/animals/fish_large.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/fish_large.lua",
    },
    {
        path = "data/entities/animals/shaman.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/shaman.lua",
    },
    {
        path = "data/entities/animals/shotgunner_hell.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_shotgunner.lua",
    },
    {
        path = "data/entities/animals/sniper_hell.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/hiisi_sniper.lua",
    },
    {
        path = "data/entities/animals/flamer.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/robot_flamer.lua",
    },
    {
        path = "data/entities/animals/icer.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/robot_icer.lua",
    },
    {
        path = "data/entities/animals/frog_big.xml",
        script = "mods/tales_of_kupoli/files/scripts/death/three_random_souls.lua",
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

local wizards = {
    "data/entities/animals/wizard_dark.xml",
    "data/entities/animals/wizard_hearty.xml",
    "data/entities/animals/wizard_homing.xml",
    "data/entities/animals/wizard_neutral.xml",
    "data/entities/animals/wizard_poly.xml",
    "data/entities/animals/wizard_returner.xml",
    "data/entities/animals/wizard_swapper.xml",
    "data/entities/animals/wizard_tele.xml",
    "data/entities/animals/wizard_twitchy.xml",
    "data/entities/animals/wizard_weaken.xml",
    "data/entities/animals/monk.xml",
    "data/entities/animals/kupoli_soul_angry.xml",
    "data/entities/animals/kupoli_puppet_master.xml",
}
for i,v in ipairs(wizards) do
    if ModTextFileGetContent(v) ~= nil then
        local xml = nxml.parse(ModTextFileGetContent(v))
        xml:add_child(nxml.parse([[
            <LuaComponent
                script_death="mods/tales_of_kupoli/files/scripts/death/wizards.lua"
                >
            </LuaComponent>
        ]]))
        ModTextFileSetContent(v, tostring(xml))
    end
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
	{ -4500, -7000, "mods/tales_of_kupoli/files/biome/rainaltar/rainaltar.xml", true },
    { 13080, 1650, "mods/tales_of_kupoli/files/biome/souldoor/souldoor.xml", true },
    { -1000, -10000, "mods/tales_of_kupoli/files/biome/sillychest/sillychest.xml", true },
    { 13080, 2870, "mods/tales_of_kupoli/files/biome/wandstatue/wandstatue.xml"},

    { 16165, -1790, "mods/tales_of_kupoli/files/entities/items/essencewand_earth/weapon.xml", true },
    { -14090, 360, "mods/tales_of_kupoli/files/entities/items/essencewand_fire/weapon.xml", true },
    {-13020, -5380, "mods/tales_of_kupoli/files/entities/items/essencewand_air/weapon.xml", true },
    { -14040, 13570, "mods/tales_of_kupoli/files/entities/items/essencewand_spirits/weapon.xml", true },
    { -5340, 16640, "mods/tales_of_kupoli/files/entities/items/essencewand_water/weapon.xml", true },
    --{ 0, 0, "mods/tales_of_kupoli/files/entities/items/shovel/weapon.xml", true }, -- testing

    { 4518, 805, "mods/tales_of_kupoli/files/sunbook/item/item.xml", true },
}

add_scene(scenes)

-- player
function OnPlayerSpawned( player )

    dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

    dofile_once("mods/tales_of_kupoli/files/gui.lua")

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("tales_of_kupoli_init") then return end

    SoulsInit()

    if ModIsEnabled("Apotheosis") then
        print("tales x apotheosis compat working!")
    end

    if ModSettingGet( "tales_of_kupoli.spawn_tome" ) then
        EntityLoad("mods/tales_of_kupoli/files/entities/items/tome/weapon.xml", px, py)
        CreateItemActionEntity("KUPOLI_UPGRADE_TOME", px, py)
    end

    for i=1,tonumber(ModSettingGet("tales_of_kupoli.starting_souls")) do
        local which = soul_types[math.random(1,#soul_types)]
        if which == "gilded" then
            which = "orcs"
        end
        AddSoul(which)
    end

    --for i=1,100 do AddSoul("slimes") GamePrintImportant("REMINDER TO REMOVE THE DEBUG SOULS", "GO DO THAT MOLDOS") end
    --for i=1,4 do EntityLoad("mods/tales_of_kupoli/files/entities/revived/_tablets/alchemist.xml", px, py) end
    --for i=1,2 do EntityLoad("mods/tales_of_kupoli/files/entities/items/moldos_special/weapon.xml", px, py) end
    --for i=1,2 do EntityLoad("mods/tales_of_kupoli/files/entities/items/towerwand_gift/weapon.xml", px, py) end
    --for i=1,4 do EntityLoad("mods/tales_of_kupoli/files/entities/items/amethyst_orb/item.xml", px, py) end
    --GameAddFlagRun("kupoli_better_weapons")
    --for i=1,2 do EntityLoad("mods/tales_of_kupoli/files/entities/items/darklukkirifle/weapon.xml", px, py) end
    --for i=1,2 do EntityLoad("mods/tales_of_kupoli/files/entities/items/hiisisniper/weapon.xml", px, py) end
    --for i=1,1 do EntityLoad("data/entities/animals/kupoli_bluesun_mimic.xml", px, py) end
    --for i=1,1000 do AddSoul("gilded") end
    --CreateItemActionEntity("KUPOLI_OPEN_GATE", px, py)

    --[[EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/tales_of_kupoli/files/scripts/player.lua",
        execute_every_n_frame=15,
    })]]

    --[[EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="brilliance_stored",
        name="brilliance_stored",
        value_int=0,
    })
    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="brilliance_max",
        name="brilliance_max",
        value_int=500,
    })]]--

    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="movetimer",
        name="movetimer",
        value_int=0,
    })
    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="cd",
        name="kickcd",
        value_int=0,
    })

    --[[EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/tales_of_kupoli/files/scripts/player_kick.lua",
        execute_every_n_frame="1",
    })

    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="soul_kick_cd",
        name="soul_kick_cd",
        value_int=0,
    })]]--

    --AddFlagPersistent("progress_greensun")
    --AddFlagPersistent("progress_redsun")
    --AddFlagPersistent("progress_bluesun")

    --[[if HasFlagPersistent("progress_greensun") and HasFlagPersistent("progress_redsun") and HasFlagPersistent("progress_bluesun") then
        EntitySetComponentsWithTagEnabled( player, "player_hat2", false )
        EntitySetComponentsWithTagEnabled( player, "player_hat", true ) -- placeholder hat
    end]]--

    if ModSettingGet( "tales_of_kupoli.mina_pearl" ) then
        EntityLoad("mods/tales_of_kupoli/files/entities/items/minapearl/mina_pearl.xml", px + 5, py)
        --EntityLoad("mods/tales_of_kupoli/files/entities/items/forgewand/weapon.xml", px - 5, py)
    end

    if ModSettingGet( "tales_of_kupoli.sunbook_unlocked_on_start" ) then
        GameAddFlagRun("talesofkupoli_sunbook_unlocked")
    end

    GameAddFlagRun("tales_of_kupoli_init")
end

-- moles spawning
--[[if not GameHasFlagRun("tales_of_kupoli_moles_init") then -- thanks conga
    for i=1,#molebiomes do v = molebiomes[i]
        local biomepath = table.concat({"data/scripts/biomes/", v.biome, ".lua"})
        local spawnerpath = "mods/tales_of_kupoli/files/scripts/molespawner.lua"
        if v.modded ~= nil and v.modded == true then
            biomepath = v.biome
        end
        ModLuaFileAppend(biomepath, spawnerpath)
    end
    GameAddFlagRun("tales_of_kupoli_moles_init")
end]]

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n");
    end

    local new_translations = ModTextFileGetContent( table.concat({"mods/tales_of_kupoli/files/translations.csv"}) );
    translations = translations .. new_translations;

    ModTextFileSetContent( "data/translations/common.csv", translations );
end

-- biomes
--[[local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
)
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))]]
--[[ <Biome height_index="0" color="ff9dceb9" biome_filename="mods/tales_of_kupoli/files/biome/sunlab/sunlab.xml" /> ]]

-- nxml
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for element in xml:each_child() do
    if element.attr.name == "magic_liquid_hp_regeneration" or element.attr.name == "magic_liquid_hp_regeneration_unstable" then
        element.attr.tags = "[liquid],[water],[magic_liquid],[regenerative],[greensun_fuel],[sunbaby_ignore_list]"
    end
    if element.attr.name == "radioactive_liquid" then
        element.attr.tags = "[liquid],[corrodible],[soluble],[radioactive],[impure],[liquid_common],[greensun_fuel],[sunbaby_ignore_list]"
    end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))

function OnModSettingsChanged()
    RenderSouls()
end