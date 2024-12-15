dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")

if comp_state == nil then return print("Souls - couldnt find state") end

local state = ComponentGetValue2(comp_state, "value_int")

local player = GetPlayer()
local px, py = EntityGetTransform(player)

if state == 1 then -- soul drain fields
    local proj_x = x
    local proj_y = y
    for i=1,3 do
        proj_x = x + math.random(-20, 20)
        proj_y = y + math.random(-20, 20)
        local vel_x = math.cos(0 - math.atan2(py - y, px - x)) * 1000.0
        local vel_y = 0 - math.sin(0 - math.atan2(py - y, px - x)) * 1000.0
        shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/soul_drain_field_small.xml", proj_x, proj_y, vel_x, vel_y)
    end
    for i=1,4 do
        proj_x = x + math.random(-8, 8)
        proj_y = y + math.random(-8, 8)
        local vel_x = math.cos(0 - math.atan2(py - y, px - x)) * 1500.0
        local vel_y = 0 - math.sin(0 - math.atan2(py - y, px - x)) * 1500.0
        shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/proj_expel_soul.xml", proj_x, proj_y, vel_x, vel_y)
    end
end

if state == 2 then -- "beam" of fast moving soul projectiles
    local proj_x = x
    local proj_y = y
    for i=1,15 do
        proj_x = x + math.random(-20, 20)
        proj_y = y + math.random(-20, 20)
        local vel_x = math.cos(0 - math.atan2(py - y, px - x)) * 1500.0
        local vel_y = 0 - math.sin(0 - math.atan2(py - y, px - x)) * 1500.0
        shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/proj_expel_soul.xml", proj_x, proj_y, vel_x, vel_y)
    end
end

if state == 3 then -- valkoinen sword attack thing but when they explode they drain souls
    local proj_x = x
    local proj_y = y
    for i=1,25 do
        proj_x = x + math.random(-200, 200)
        proj_y = y + math.random(-100, 100)
        shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/proj_sword.xml", proj_x, proj_y, 0, 0)
    end
end

if #EntityGetWithTag("souls_boss_soul_field") < 1 then
    local vel_x = math.cos(0 - math.atan2(py - y, px - x)) * 2.0
    local vel_y = 0 - math.sin(0 - math.atan2(py - y, px - x)) * 2.0
    shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/soul_drain_field.xml", x, y, vel_x, vel_y)
end