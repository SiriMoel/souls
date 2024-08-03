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

-- player
function OnPlayerSpawned( player )

    dofile_once("mods/souls/files/scripts/souls.lua")

    dofile_once("mods/souls/files/gui.lua")

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("souls_init") then return end

    SoulsInit()

    --EntityLoad("mods/souls/files/entities/items/tome/weapon.xml", px, py)
    --CreateItemActionEntity("MOLDOS_UPGRADE_TOME", px, py)

    --EntityLoad("mods/souls/files/entities/items/_soulcrystals/alchemist.xml", px, py)

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

function OnModSettingsChanged()
    --RenderSouls()
end