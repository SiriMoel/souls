dofile_once("mods/souls/lib/gusgui/gusgui.lua").init("mods/souls/lib/gusgui")
--ModMagicNumbersFileAdd( "mods/souls/files/magic_numbers.xml" )
ModMaterialsFileAdd("mods/souls/files/materials.xml")

dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")
--dofile_once("mods/souls/files/scripts/molebiomes.lua")

--PatchGunSystem()

local nxml = dofile_once("mods/souls/lib/nxml.lua")

--[[if ModSettingGet("souls.alt_map") then
    ModMagicNumbersFileAdd( "mods/souls/files/magic_numbers.xml" )
end]]

-- set & append
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/souls/files/actions.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/souls/files/perks.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/souls/files/status_list.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/souls/files/scripts/drop_money_append.lua" )
SetFileContent("data/entities/base_wand_pickup.xml", "base_wand_pickup.xml")


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
    { 13080, 1650, "mods/souls/files/biome/souldoor/souldoor.xml", true },
}

add_scene(scenes)

-- player
function OnPlayerSpawned( player )

    dofile_once("mods/souls/files/scripts/souls.lua")

    dofile_once("mods/souls/files/gui.lua")

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("souls_init") then return end

    SoulsInit()

    --EntityLoad("mods/souls/files/entities/items/tome/weapon.xml", px, py)
    --CreateItemActionEntity("MOLDOS_UPGRADE_TOME", px, py)

    for i=1,tonumber(ModSettingGet("souls.starting_souls")) do
        local which = soul_types[math.random(1,#soul_types)]
        if which == "gilded" then
            which = "orcs"
        end
        if which == "boss" then
            which = "orcs"
        end
        AddSouls(which, 1)
    end

    EntityAddComponent(player, "LuaComponent", {
        script_damage_about_to_be_received="mods/souls/files/scripts/player_about_to_be_damaged.lua"
    })

    GameAddFlagRun("souls_init")
end

-- moles spawning
--[[if not GameHasFlagRun("souls_moles_init") then -- thanks conga
    for i=1,#molebiomes do v = molebiomes[i]
        local biomepath = table.concat({"data/scripts/biomes/", v.biome, ".lua"})
        local spawnerpath = "mods/souls/files/scripts/molespawner.lua"
        if v.modded ~= nil and v.modded == true then
            biomepath = v.biome
        end
        ModLuaFileAppend(biomepath, spawnerpath)
    end
    GameAddFlagRun("souls_moles_init")
end]]

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n");
    end

    local new_translations = ModTextFileGetContent( table.concat({"mods/souls/files/translations.csv"}) );
    translations = translations .. new_translations;

    ModTextFileSetContent( "data/translations/common.csv", translations );
end

-- biomes
--[[local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content)
xml:add_children(nxml.parse_many[[
)
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))]]
--[[ <Biome height_index="0" color="ff9dceb9" biome_filename="mods/souls/files/biome/sunlab/sunlab.xml" /> ]]

-- nxml

function OnModSettingsChanged()
    --RenderSouls()
end