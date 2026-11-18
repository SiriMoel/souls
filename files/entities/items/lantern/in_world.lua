local this = GetUpdatedEntityID()
local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lantern_soul")
local soul = ComponentGetValue2(comp_soul, "value_string")
if soul ~= "" then
    EntitySetComponentsWithTagEnabled(this, "lantern_on", true)
end