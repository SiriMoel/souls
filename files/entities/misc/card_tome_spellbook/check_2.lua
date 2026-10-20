local card = GetUpdatedEntityID()
local tome = EntityGetParent(card)
local root = EntityGetRootEntity(card)
local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")
if tome == nil or not EntityHasTag(tome, "soul_tome") or not EntityHasTag(root, "player_unit") then 
    ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_spellbook_2.png")
else
    local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack")
    local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))
    local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")
    if ca == 1 then
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_spear.png")
    end
    if ca == 2 then
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_field.png")
    end
    if ca == 3 then
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_buff.png")
    end
end