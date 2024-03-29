dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state == nil then return end
local state = tonumber(ComponentGetValue2(comp_state, "value_string"))

if state == 3 then
    print("valk - shooting pillars")

    --GamePrint("go go gadget pillars")

    local lp_x = x - 150
    local lp_y = y
    local lp_v_x = 1000
    local lp_v_y = 0

    local rp_x = x + 150
    local rp_y = y
    local rp_v_x = -1000
    local rp_v_y = 0

    shoot_projectile( valk, "mods/tales_of_kupoli/files/entities/animals/boss_valkoinen/proj_pillar.xml", lp_x, lp_y, lp_v_x, lp_v_y )
    shoot_projectile( valk, "mods/tales_of_kupoli/files/entities/animals/boss_valkoinen/proj_pillar.xml", rp_x, rp_y, rp_v_x, rp_v_y )

    for i=1,10 do
        px = x + math.random(-150, 150)
        py = y + math.random(-100, 100)

        shoot_projectile( valk, "mods/tales_of_kupoli/files/entities/animals/boss_valkoinen/proj_sword.xml", px, py, 0, 0)
    end
end