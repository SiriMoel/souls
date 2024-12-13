dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")

if comp_state == nil then return print("Souls - couldnt find state") end

local state = ComponentGetValue2(comp_state, "value_int")

local player = GetPlayer()
local px, py = EntityGetTransform(player)

if state == 1 then -- rocket roll but souls
    
end

if state == 2 then -- soul projectiles -> soul drain fields
    
end

if state == 3 then -- "beam" of fast moving soul projectiles
    
end

if state == 4 then -- valkoinen sword attack thing but when they explode they drain souls
    
end

if #EntityGetWithTag("souls_boss_soul_field") > 0 then
    local vel_x = math.cos(0 - math.atan2(py - y, px - x)) * 2.0
    local vel_y = 0 - math.sin(0 - math.atan2(py - y, px - x)) * 2.0
    shoot_projectile(this, "mods/souls/files/entities/animals/boss_soul/soul_drain_field.xml", x, y, vel_x, vel_y)
end