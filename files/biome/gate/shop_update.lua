local shop = GetUpdatedEntityID()

local items = EntityGetAllChildren(shop, "souls_gate_shop_item") or {}
if #items > 0 then
    EntitySetComponentsWithTagEnabled(shop, "soul_shop", true)

    local item = items[1]

    local x, y = EntityGetTransform(shop)
    local frame = GameGetFrameNum()

    local item_x = x
    local item_y = y - 30 + 4 * math.sin(frame / 50)

    EntityApplyTransform(item, item_x, item_y)
else
    EntitySetComponentsWithTagEnabled(shop, "soul_shop", false)
end