dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")

if comp_state == nil then return print("Souls - couldnt find state") end

local state = ComponentGetValue2(comp_state, "value_int")

state = state + 1

if state > 4 then
    state = 1
end

ComponentSetValue2(comp_state, "value_int", state)