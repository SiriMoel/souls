local nxml = dofile_once("mods/souls/lib/nxml.lua")

for content in nxml.edit_file("data/entities/player.xml") do
    content:set("tags", content:get("tags") .. ",souls_reap_for_player")
end

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

for content in nxml.edit_file("data/entities/items/orbs/orb_base.xml") do
    content:create_children(
	    { LuaComponent = {
    		script_source_file="mods/souls/files/entities/misc/haunting/spawn_haunting.lua",
            execute_on_added=true,
            remove_after_executed=true
	    }}
    )
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
    table.insert(bosses, "data/entities/animals/boss_toxic_worm/boss_toxic_worm.xml")
    table.insert(bosses, "data/entities/animals/boss_fire_lukki/boss_fire_lukki.xml")
    table.insert(bosses, "data/entities/animals/boss_flesh_monster/boss_flesh_monster.xml")
    table.insert(bosses, "data/entities/animals/boss_musical_ghost/boss_musical_ghost.xml")
end
for _, path in ipairs(bosses) do
    for content in nxml.edit_file(path) do
        content:set("tags", content:get("tags") .. ",souls_boss")
        content:create_children(
            { LuaComponent = {
        		script_death="mods/souls/files/scripts/boss_death.lua",
		        execute_every_n_frame=-1
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
for _, path in ipairs(cloud_spells) do
    for content in nxml.edit_file(path) do
        content:set("tags", content:get("tags") .. ",spell_cloud")
    end
end

local fix_souls = {
    {
        path = "data/entities/animals/lukki/lukki.xml",
        soul = "spider",
    },
    {
        path = "data/entities/animals/lukki/lukki_tiny.xml",
        soul = "spider",
    },
    {
        path = "data/entities/animals/scavenger_heal.xml",
        soul = "orcs",
    },
    {
        path = "data/entities/animals/maggot.xml",
        soul = "worm",
    },
    --[[{
        path = "data/entities/animals/friend.xml",
        soul = "souls_void",
    },]]
    {
        path = "data/entities/animals/boss_limbs/slimeshooter_boss_limbs.xml",
        soul = "slimes",
    },
}
for _, v in ipairs(fix_souls) do
    for content in nxml.edit_file(v.path) do
        content:create_children(
            { VariableStorageComponent = {
    		    _tags = "souls_force_soul_type",
		        name = "souls_force_soul_type",
		        value_string = v.soul
    	    }}
        ) 
    end
end