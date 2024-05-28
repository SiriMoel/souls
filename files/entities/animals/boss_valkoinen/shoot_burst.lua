dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local opts = { "orb_dark", "orb_poly", "orb_tele" }

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state == nil then return end
local state = tonumber(ComponentGetValue2(comp_state, "value_string"))

if state == 1 then
    for i=1,7 do
        SetRandomSeed( x * GameGetFrameNum(), y + i )
        
        local arc = Random( 0, 100 ) * 0.01 * math.pi * 2
        local vel_x = math.cos( arc ) * 250
        local vel_y = 0 - math.sin( arc ) * 250
        
        local rnd = Random( 1, #opts )
        
        local eid = shoot_projectile( valk, "data/entities/projectiles/" .. opts[rnd] .. ".xml", x, y, vel_x, vel_y )
    end
    print("valk - shooting burst")
end

