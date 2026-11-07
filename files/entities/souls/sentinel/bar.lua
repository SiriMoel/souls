local this = GetUpdatedEntityID()
local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
local soul = ComponentGetValue2(comp_soul, "value_float")
local f = soul / 100
local comp_bar_front = EntityGetFirstComponent(this, "SpriteComponent", "bar_front")
ComponentSetValue2(comp_bar_front, "special_scale_x", f)