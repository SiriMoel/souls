local this = GetUpdatedEntityID()
local state = tonumber(GlobalsGetValue("souls_diviner_state", "0"))
local comp = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
ComponentSetValue2(comp, "ui_description", "$itemdesc_souls_tablet_" .. state)