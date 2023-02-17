ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/moles_n_more/files/actions.lua" )
ModMaterialsFileAdd("mods/moles_n_more/files/materials.xml")
dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/souls.lua")
dofile_once("mods/moles_n_more/files/scripts/molebiomes.lua")

SetFileContent("data/scripts/buildings/sun/spot_4.lua", "spot_4.lua")
SetFileContent("data/scripts/buildings/sun/sun_collision.lua", "sun_collision.lua")

function OnPlayerSpawned( player ) 
    if GameHasFlagRun("moles_n_more_init") then return end
    SoulsInit()
    GameAddFlagRun("moles_n_more_init")
end

-- moles spawning

if not GameHasFlagRun("moles_n_more_moles_init") then -- thanks conga
    for i=1,#molebiomes do v = molebiomes[i]
        local biomepath = table.concat({"data/scripts/biomes/", v.biome, ".lua"})
        local spawnerpath = "mods/moles_n_more/files/scripts/molespawner.lua"
        if v.modded ~= nil and v.modded == true then
            biomepath = v.biome
        end
        ModLuaFileAppend(biomepath, spawnerpath)      
    end
    GameAddFlagRun("moles_n_more_moles_init")
end