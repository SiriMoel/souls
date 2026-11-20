dofile_once("mods/souls/files/scripts/gate_shop.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end

    local reroller = GetUpdatedEntityID()
    local x, y = EntityGetTransform(reroller)

    local ok = true
    local comp_price = EntityGetFirstComponentIncludingDisabled(reroller, "VariableStorageComponent", "reroll_price")
    if comp_price ~= nil then
        local price = ComponentGetValue2(comp_price, "value_int")
        if SpellUseSouls(entity_who_interacted, price) then
            price = price + 3
            ComponentSetValue2(comp_price, "value_int", price)
        else
            ok = false
            SoulsPrint("You do not have enough souls for this.")
            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
        end
    end
    if ok then
        local shops = EntityGetInRadiusWithTag(x, y, 250, "souls_gate_shop") or {}
        if #shops > 0 then
            --SoulsPrintImportant("ITEMS REROLLED!", "The Gate offers you with new choices...", "void")
            SoulsPrint("Rerolled!")
            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
            GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/shop_item/create", x, y)
            GameScreenshake(5)
            for _, shop in ipairs(shops) do
                GateShop(shop)
            end
        end
    end
end