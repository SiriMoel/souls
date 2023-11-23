dofile_once("mods/tales_of_kupoli/lib/gusgui/gusgui.lua").init("mods/tales_of_kupoli/lib/gusgui")
--dofile_once("mods/tales_of_kupoli/lib/Noitilities/NL_Init.lua").init("mods/tales_of_kupoli/files/lib/Noitilities")
--ModMagicNumbersFileAdd( "mods/tales_of_kupoli/files/magic_numbers.xml" )
ModMaterialsFileAdd("mods/tales_of_kupoli/files/materials.xml")

dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")
--dofile_once("mods/tales_of_kupoli/files/scripts/molebiomes.lua")

--dofile_once("mods/tales_of_kupoli/lib/Noitilities/NT_ModuleLoader.lua").DofileModules({"GunPatch"})
--PatchGunSystem()

local nxml = dofile_once("mods/tales_of_kupoli/lib/nxml.lua")

dofile_once("mods/tales_of_kupoli/files/gui.lua")

-- set & append
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/tales_of_kupoli/files/actions.lua" )
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/tales_of_kupoli/files/perks.lua" )
ModLuaFileAppend( "data/scripts/items/orb_pickup.lua", "mods/tales_of_kupoli/files/scripts/orb_pickup_append.lua" )
ModLuaFileAppend( "data/scripts/biomes/orbrooms/orbroom_07.lua", "mods/tales_of_kupoli/files/scripts/orbroom_07_append.lua" )

SetFileContent("data/scripts/buildings/sun/spot_4.lua", "spot_4.lua")
SetFileContent("data/scripts/buildings/sun/sun_collision.lua", "sun_collision.lua")
SetFileContent("data/entities/items/pickup/sun/sunbaby.xml", "sunbaby.xml")
SetFileContent("data/entities/items/orbs/orb_base.xml", "orb_base.xml")
SetFileContent("data/entities/items/pickup/sun/newsun.xml", "newsun.xml")
SetFileContent("data/entities/items/pickup/sun/newsun_dark.xml", "newsun_dark.xml")

--hiisi
local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/shotgunner.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/hiisi_shotgunner.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/shotgunner.xml", tostring(xml))

local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/sniper.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/hiisi_sniper.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/sniper.xml", tostring(xml))

local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/scavenger_smg.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/hiisi_pistol.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/scavenger_smg.xml", tostring(xml))

--dragon
local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/boss_dragon.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/dragon.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_dragon.xml", tostring(xml))

--alchemist
local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/boss_alchemist/boss_alchemist.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/alchemist.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_alchemist/boss_alchemist.xml", tostring(xml))

--grandmaster
local xml = nxml.parse(ModTextFileGetContent("data/entities/animals/boss_wizard/boss_wizard.xml"))
xml:add_child(nxml.parse([[
	<LuaComponent
		script_death="mods/tales_of_kupoli/files/scripts/death/grandmaster.lua"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/boss_wizard/boss_wizard.xml", tostring(xml))

--dhl
--[[local dhlsources = {
    "data/entities/animals/wizard_dark",
    "data/entities/animals/wizard_hearty",
    "data/entities/animals/wizard_homing",
    "data/entities/animals/wizard_neutral",
    "data/entities/animals/wizard_poly",
    "data/entities/animals/wizard_returner",
    "data/entities/animals/wizard_swapper",
    "data/entities/animals/wizard_tele",
    "data/entities/animals/wizard_twitchy",
    "data/entities/animals/wizard_weaken",
    "data/entities/animals/monk", -- from monk city?
    "data/entities/animals/firemage",
    "data/entities/animals/firemage_weak",
    "data/entities/animals/thundermage",
    "data/entities/animals/thundermage_big",
}

for i,v in ipairs(dhlsources) do
    local xml = nxml.parse(ModTextFileGetContent(dhlsources[v] .. ".xml"))
    xml:add_child(nxml.parse([[
	    <LuaComponent
		    script_death="mods/tales_of_kupoli/files/scripts/death/dhl.lua"
		    >
	    </LuaComponent>
    ]]--))
    --[[
    ModTextFileSetContent(dhlsources[v] .. ".xml", tostring(xml))
end]]--

-- biomes
local content = ModTextFileGetContent("data/biome/_biomes_all.xml")
local xml = nxml.parse(content) -- sun lab biome is unused
xml:add_children(nxml.parse_many[[
    <Biome height_index="0" color="ff9dceb9" biome_filename="mods/tales_of_kupoli/files/biome/sunlab/sunlab.xml" />
]])
ModTextFileSetContent("data/biome/_biomes_all.xml", tostring(xml))

-- player
function OnPlayerSpawned( player )

    local px, py = EntityGetTransform(player)

    if GameHasFlagRun("tales_of_kupoli_init") then return end

    SoulsInit()

    --[[EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/tales_of_kupoli/files/scripts/player.lua",
        execute_every_n_frame="2",
    })]]--
    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="brilliance_stored",
        name="brilliance_stored",
        value_int=0,
    })
    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags="brilliance_max",
        name="brilliance_max",
        value_int=500,
    })

    --[[EntityAddComponent2(player, "LuaComponent", {
        _tags="",
        script_source_file="mods/tales_of_kupoli/files/sunbook/rosettas/init.lua",
        execute_every_n_frame="10",
    })]]--

    --AddFlagPersistent("progress_greensun")
    --AddFlagPersistent("progress_redsun")
    --AddFlagPersistent("progress_bluesun")
    
    if HasFlagPersistent("progress_greensun") and HasFlagPersistent("progress_redsun") and HasFlagPersistent("progress_bluesun") then
        EntitySetComponentsWithTagEnabled( player, "player_hat2", false )
        EntitySetComponentsWithTagEnabled( player, "player_hat", true ) -- placeholder hat
    end

    if ModSettingGet( "tales_of_kupoli.mina_pearl" ) then
        EntityLoad("mods/tales_of_kupoli/files/entities/items/minapearl/mina_pearl.xml", px, py)
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

-- nxml
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for element in xml:each_child() do
    if element.attr.name == "magic_liquid_hp_regeneration" or element.attr.name == "magic_liquid_hp_regeneration_unstable" then
        element.attr.tags = "[liquid],[water],[magic_liquid],[regenerative],[greensun_fuel],[sunbaby_ignore_list]"
    end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))

function OnModSettingsChanged()
    RenderSouls()
end