dofile_once("mods/souls/files/scripts/souls.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    dofile_once("mods/souls/files/scripts/souls.lua")
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end

    local shop = GetUpdatedEntityID()
    local x, y = EntityGetTransform(shop)

    local soulcounts = SoulCounts(entity_who_interacted)

    local ok = true
    local total_price = 0
    local price_any = 0
    local to_pay = {}

    local soul_types, all_soul_types, shifts = GetSoulTypes()

    local price_comps = EntityGetComponentIncludingDisabled(shop, "VariableStorageComponent", "shop_price") or {}
    if #price_comps > 0 then
        for _, comp in ipairs(price_comps) do
            local soul = ComponentGetValue2(comp, "name")
            local amt = ComponentGetValue2(comp, "value_int")
            if soul == "soul" then
                price_any = price_any + amt
            else
                soul = shifts[soul] or soul
                if soulcounts[tostring(soul)] >= amt then
                    to_pay[tostring(soul)] = (to_pay[tostring(soul)] or 0) + amt
                else
                    ok = false
                    break
                end
            end
            total_price = total_price + amt
        end
    end

    if not (soulcounts["total"] >= total_price) then
        ok = false
    end

    if ok then
        local buy_1 = SpellUseSpecificSouls(entity_who_interacted, to_pay)
        local buy_2 = SpellUseSouls(entity_who_interacted, price_any)
        if buy_1 and buy_2 then
            SoulsPrint("Purchased!")
            GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/shop_item/create", x, y)
            local items = EntityGetAllChildren(shop, "souls_gate_shop_item") or {}
            if #items > 0 then
                local item = items[1]
                local comp_item = EntityGetFirstComponentIncludingDisabled(item, "ItemComponent")
                if comp_item ~= nil then
                    ComponentSetValue2(comp_item, "is_pickable", true)
                end
                EntityRemoveTag(item, "souls_gate_shop_item")
                EntityRemoveFromParent(item)
                local frame = GameGetFrameNum()
                EntityApplyTransform(item, x,  y - 30)
            end
        else
            SoulsPrint("You do not have enough souls for this.")
            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
        end
    else
        SoulsPrint("You do not have enough souls for this.")
        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
    end
end