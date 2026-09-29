local nxml = dofile_once("mods/souls/lib/nxml.lua")

for content in nxml.edit_file("data/entities/base_wand_pickup.xml") do
    content:create_children(
        { VariableStorageComponent = {
    		_tags="souls_wand_soul_type",
		    name="souls_wand_soul_type",
		    value_int=0
	    }}
    )
end

for content in nxml.edit_file("data/entities/items/pickup/spell_refresh.xml") do
    content:create_children(
	    { LuaComponent = {
    		script_source_file="mods/souls/files/entities/items/soulrefresh/spawn.lua",
            execute_on_added=true,
            remove_after_executed=true
	    }}
    )
end

local drops = {
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
for _,v in ipairs(drops) do
    for content in nxml.edit_file(v.path) do
        content:create_children(
            { LuaComponent = {
                script_death=v.script
	        }}
        )
    end
end

local bosses = {
    "data/entities/animals/boss_alchemist/boss_alchemist.xml",
	"data/entities/animals/boss_limbs/boss_limbs.xml",
	"data/entities/animals/boss_pit/boss_pit.xml",
	"data/entities/animals/boss_dragon.xml",
	"data/entities/animals/boss_wizard/boss_wizard.xml",
	"data/entities/animals/boss_fish/fish_giga.xml",
	"data/entities/animals/boss_spirit/islandspirit.xml",
	"data/entities/animals/boss_ghost/boss_ghost.xml",
	"data/entities/animals/boss_meat/boss_meat.xml",
	"data/entities/animals/boss_robot/boss_robot.xml",
	"data/entities/animals/maggot_tiny/maggot_tiny.xml",
	"data/entities/animals/parallel/alchemist/parallel_alchemist.xml",
	"data/entities/animals/parallel/tentacles/parallel_tentacles.xml",
}
if ModIsEnabled("Apotheosis") then
    
end
for _,path in ipairs(bosses) do
    for content in nxml.edit_file(path) do
        content:set("tags", content:get("tags") .. ",souls_boss")
        content:create_children(
            { VariableStorageComponent = {
        		_tags="souls_reap",
		        name="boss",
		        value_int=1
    	    }}
        )
    end
end

local cloud_spells = {
    "data/entities/projectiles/deck/cloud_acid.xml",
    "data/entities/projectiles/deck/cloud_blood.xml",
    "data/entities/projectiles/deck/cloud_oil.xml",
    "data/entities/projectiles/deck/cloud_thunder.xml",
    "data/entities/projectiles/deck/cloud_water.xml",
}
for _,path in ipairs(cloud_spells) do
    for content in nxml.edit_file(path) do
        content:set("tags", content:get("tags") .. ",spell_cloud")
    end
end