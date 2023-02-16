ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/moles_n_more/files/actions.lua" )
ModMaterialsFileAdd("mods/moles_n_more/files/materials.xml")
dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/souls.lua")

SetFileContent("data/scripts/buildings/sun/spot_4.lua", "spot_4.lua")
SetFileContent("data/scripts/buildings/sun/sun_collision.lua", "sun_collision.lua")

function OnPlayerSpawned( player ) 
    if GameHasFlagRun("moles_n_more_init") then return end
    SoulsInit()
    EntityAddComponent(player, "LuaComponent", {
        script_source_file="mods/moles_n_more/files/scripts/moles.lua",
        execute_every_n_frame="30",

    })
    GameAddFlagRun("moles_n_more_init")
end