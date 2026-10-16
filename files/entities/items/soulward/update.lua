local this = GetUpdatedEntityID()
local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soulward_stored")
if comp ~= nil and comp_item ~= nil then
    local amt = ComponentGetValue2(comp, "value_float")
    ComponentSetValue2(comp_item, "uses_remaining", math.min(math.max(math.floor(amt / 0.04 + 0.5), 0), 9999))
end