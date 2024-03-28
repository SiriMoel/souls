dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state ~= nil then
    local state = tonumber(ComponentGetValue2(comp_state, "value_int"))
    state = state + 1
    -- 1 - halo spam
    -- 2 - slow homing swords
    -- 3 - pillars
    -- 4 - mage projectile burst

    if state > 4 or state <= 0 then
        state = 1
    end

    ComponentSetValue2(comp_state, "value_string", tostring(state))
    print("Valkoinen state changed")
end