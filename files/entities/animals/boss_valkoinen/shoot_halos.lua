dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state == nil then return end
local state = tonumber(ComponentGetValue2(comp_state, "value_string"))

if state == 2 then
    shoot_projectile( valk, "mods/tales_of_kupoli/files/entities/animals/boss_valkoinen/halos_host.xml", x, y, 0, -50 )
    print("valk - shooting halos")
end

