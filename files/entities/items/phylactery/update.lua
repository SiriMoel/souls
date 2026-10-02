local this = GetUpdatedEntityID()
local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
local comp_p = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "phylactery")
if comp_p ~= nil and comp_item ~= nil then
    local amt = ComponentGetValue2(comp_p, "value_int")
    ComponentSetValue2(comp_item, "uses_remaining", math.max(amt, 0))
end