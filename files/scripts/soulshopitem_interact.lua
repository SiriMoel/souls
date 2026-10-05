dofile_once("mods/souls/files/scripts/souls.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
    if comp_item == nil then print("Souls - couldn't find ItemComponent") return end
    local comp_cost = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soulcost")
    if comp_cost == nil then print("Souls - couldn't find cost component") return end
    local cost = ComponentGetValue2(comp_cost, "value_int")
    local counts = SoulCounts(entity_who_interacted)
    if counts["total"] >= cost then
        local used_n = 0
        local used = {}
        while used_n < cost do
            for k,v in pairs(counts) do
                if tostring(k) ~= "total" and tostring(k) ~= "total_boss" and tostring(k) ~= "boss" then
                    if v > 0 then
                        used[k] = (used[k] or 0) - 1
                        used_n = used_n + 1
                    end
                end
            end
        end
        EditSoulCounts(used, entity_who_interacted)
        EntityLoad("data/entities/particles/image_emitters/shop_effect.xml", x, y-8)
        ComponentSetValue2(comp_item, "is_pickable", true)
        GamePrint("Purchased!")
        local comps = EntityGetAllComponents(this)
        for i,comp in ipairs(comps) do
            if ComponentHasTag(comp, "soulshopitem") then
                EntityRemoveComponent(this, comp)
            end
        end
    else
        GamePrint("You do not have enough souls for this. (" .. cost .. ")")
    end
end