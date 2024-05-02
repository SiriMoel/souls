dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

shoot_projectile_from_projectile(entity, "mods/tales_of_kupoli/files/entities/animals/boss_bluesun_mimic/proj_purple.xml", x, y, 0, 0)