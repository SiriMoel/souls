dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state == nil then return end
local state = tonumber(ComponentGetValue2(comp_state, "value_string"))

if state == 4 then
    print("valk - shooting swords")

    local px = x
    local py = y

    for i=1,25 do
        px = x + math.random(-200, 200)
        py = y + math.random(-100, 100)

        shoot_projectile( valk, "mods/tales_of_kupoli/files/entities/animals/boss_valkoinen/proj_sword.xml", px, py, 0, 0)
    end
end