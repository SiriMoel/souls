local shop = GetUpdatedEntityID()

local items = EntityGetAllChildren(shop, "souls_gate_shop_item") or {}
if #items > 0 then
    EntitySetComponentsWithTagEnabled(shop, "soul_shop", true)

    local item = items[1]

    local x, y = EntityGetTransform(shop)
    local frame = GameGetFrameNum()

    local item_x = x
    local item_y = y - 28 --+ 1 * math.sin(frame / 50)

    if EntityHasTag(item, "item_action") then
        item_y = item_y + 6
    elseif EntityHasTag(item, "souls_soul") then
        item_y = item_y - 5
    end

    local comp_inhtransform = EntityGetFirstComponentIncludingDisabled(item, "InheritTransformComponent")
    if comp_inhtransform ~= nil then
        local _, _, scale_x, scale_y, rot = ComponentGetValue2(comp_inhtransform, "Transform")
        ComponentSetValue2(comp_inhtransform, "Transform", item_x, item_y, scale_x, scale_y, rot)
        EntitySetTransform(item, item_x, item_y)
    else
        EntityApplyTransform(item, item_x, item_y)
    end
else
    EntitySetComponentsWithTagEnabled(shop, "soul_shop", false)
end