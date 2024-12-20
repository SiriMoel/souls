dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
    if comp_item == nil then print("Souls - couldn't find ItemComponent") return end
    local comp_cost = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soulcost")
    if comp_cost == nil then print("Souls - couldn't find cost component") return end
    local cost = ComponentGetValue2(comp_cost, "value_int")
    if GetSoulsCount("all") - GetSoulsCount("boss") >= cost then
        RemoveRandomSouls(cost)
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
        GamePrint("You do not have enough souls for this.")
    end
end