local this = GetUpdatedEntityID()
local diviner = EntityGetWithTag("souls_diviner")[1]
local comp_state = EntityGetFirstComponentIncludingDisabled(diviner, "VariableStorageComponent", "state")
if comp_state ~= nil then
    local comp = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
    if comp ~= nil then
        local state = ComponentGetValue2(comp_state, "value_int")
        ComponentSetValue2(comp, "ui_description", "$itemdesc_souls_tablet_" .. state)
    end
end