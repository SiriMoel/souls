dofile_once("mods/souls/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local px = x
local py = y

for i=1,5 do
    px = x + math.random(-75, 75)
    py = y + math.random(-50, 50)

    shoot_projectile( valk, "mods/souls/files/entities/animals/boss_valkoinen/proj_sword.xml", px, py, 0, 0)
end