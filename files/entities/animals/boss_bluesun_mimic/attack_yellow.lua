dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local target = EntityGetInRadiusWItTag(x, y, 300, "player_unit")[1]

if target ~= nil then
    local px, py = EntityGetTransform(target)

    local vx = 100
    local vy = 100

    shoot_projectile_from_projectile(entity, "mods/souls/files/entities/animals/boss_bluesun_mimic/proj_yellow.xml", x, y, vx, vy)
end