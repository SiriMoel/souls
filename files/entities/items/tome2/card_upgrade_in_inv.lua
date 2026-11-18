local card = GetUpdatedEntityID()
local parent = EntityGetParent(card)
local root = EntityGetRootEntity(card)
local comp_inv = EntityGetFirstComponentIncludingDisabled(root, "Inventory2Component")
if comp_inv == nil then
    GlobalsSetValue("souls.tome_gui_open", "0")
    GlobalsSetValue("souls.tome_gui_frame", tostring(GameGetFrameNum()))
    return
end
local active_item = ComponentGetValue2(comp_inv, "mActiveItem")
if active_item ~= parent then
    GlobalsSetValue("souls.tome_gui_open", "0")
    GlobalsSetValue("souls.tome_gui_frame", tostring(GameGetFrameNum()))
end