dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

shoot_projectile_from_projectile(entity, "mods/souls/files/entities/animals/boss_bluesun_mimic/proj_purple.xml", x, y, 0, 0)