local card = GetUpdatedEntityID()
local parent = EntityGetParent(card)
local root = EntityGetRootEntity(card)
if parent == nil or parent == root or card == root then
    GlobalsSetValue("souls.tome_gui_open", "0")
    GlobalsSetValue("souls.tome_gui_frame", tostring(GameGetFrameNum()))
end