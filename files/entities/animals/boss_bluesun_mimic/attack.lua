dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local bluesun = GetUpdatedEntityID()
local x, y = EntityGetTransform(bluesun)

SetRandomSeed(x, y+GameGetFrameNum())

local spot = {
    {
        x = x - 200,
        y = y - 200,
    },
    {
        x = x + 200,
        y = y - 200,
    },
    {
        x = x + 200,
        y = y + 200,
    },
    {
        x = x - 200,
        y = y + 200,
    },
}

local path = "mods/tales_of_kupoli/files/entities/animals/boss_bluesun_mimic/"
local opts = { "attack_green", "attack_red", "attack_yellow", "attack_purple" }

for i=1,4 do
    local which = opts[math.random(1,#opts)]
    if opts == "attack_green" then
        print("bluesun attack green")
        shoot_projectile(bluesun, path .. "proj_green.xml", spot[i].x, spot[i].y, 0, 0)
    end
    if opts == "attack_red" then
        print("bluesun attack red")
        shoot_projectile(bluesun, path .. "attack_red.xml", spot[i].x, spot[i].y, 0, 0)
    end
    if opts == "attack_yellow" then
        print("bluesun attack yellow")
        shoot_projectile(bluesun, path .. "attack_yellow.xml", spot[i].x, spot[i].y)
    end
    if opts == "attack_purple" then
        print("bluesun attack purple")
        shoot_projectile(bluesun, path .. "attack_purple.xml", spot[i].x, spot[i].y, 0, 0)
    end
end