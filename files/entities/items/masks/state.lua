local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")
local state = ComponentGetValue2(comp_state, "value_bool")
if state_then
    if root == this or not EntityHasTag(root, "player_unit") then

    else
        
    end
    ComponentSetValue2(comp_state, "value_bool", state)
end
if state then
    
end