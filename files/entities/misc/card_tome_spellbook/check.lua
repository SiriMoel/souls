local card = GetUpdatedEntityID()
local tome = EntityGetParent(card)
local root = EntityGetRootEntity(card)
local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")
if tome == nil or not EntityHasTag(tome, "soul_tome") or not EntityHasTag(root, "player_unit") then 
    ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_spellbook.png")
else
    local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack")
    local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))
    local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")
    if ca == 1 then -- tome shot
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_shot.png")
    end
    if ca == 2 then -- tome seek
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_seek.png")
    end
    if ca == 3 then -- tome bomb
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_bomb.png")
    end
end