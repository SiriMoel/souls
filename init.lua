ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/moles_n_more/files/actions.lua" )
ModMaterialsFileAdd("mods/moles_n_more/files/materials.xml")
dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/souls.lua")
dofile_once("mods/moles_n_more/files/scripts/molebiomes.lua")

-- set
SetFileContent("data/scripts/buildings/sun/spot_4.lua", "spot_4.lua")
SetFileContent("data/scripts/buildings/sun/sun_collision.lua", "sun_collision.lua")
SetFileContent("data/entities/items/pickup/sun/sunbaby.xml", "sunbaby.xml")

-- player
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

-- nxml
local nxml = dofile_once("mods/moles_n_more/lib/nxml.lua")
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for element in xml:each_child() do
    if element.attr.name == "magic_liquid_hp_regeneration" or element.attr.name == "magic_liquid_hp_regeneration_unstable" then
        element.attr.tags = "[liquid],[water],[magic_liquid],[regenerative],[greensun_fuel]"
    end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))