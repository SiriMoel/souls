dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

SetRandomSeed(x, y+GameGetFrameNum())

local path = "mods/tales_of_kupoli/files/entities/animals/boss_bluesun_mimic/"

local opts = {
    "boss_dragon.xml",
    "boss_alchemist.xml",
    "boss_robot.xml",
    "boss_wizard.xml",
}

local boss = EntityLoad(opts[math.random(1,#opts)], x, y)

EntityKill(entity)