dofile_once("mods/souls/files/scripts/utils.lua")

local valk = GetUpdatedEntityID()
local x, y = EntityGetTransform(valk)

local comp_state = EntityGetFirstComponentIncludingDisabled(valk, "VariableStorageComponent", "state") or nil

if comp_state ~= nil then
    local state = tonumber(ComponentGetValue2(comp_state, "value_string"))
    state = state + 1
    -- 1 - mage proj burst
    -- 2 - halos
    -- 3 - pillars
    -- 4 - swords

    if state > 4 or state <= 0 then
        state = 1
    end

    ComponentSetValue2(comp_state, "value_string", tostring(state))
    print("Valkoinen state changed")
end