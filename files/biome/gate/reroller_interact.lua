dofile_once("mods/souls/files/scripts/gate_shop.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end

    local reroller = GetUpdatedEntityID()
    local x, y = EntityGetTransform(reroller)

    local shops = EntityGetInRadiusWithTag(x, y, 250, "souls_gate_shop") or {}
    if #shops > 0 then
        SoulsPrint("Rerolled!")
        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
        for _, shop in ipairs(shops) do
            GateShop(shop)
        end
    end
end