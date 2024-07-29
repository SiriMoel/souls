dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

if GameHasFlagRun("kupoli_phylactery_done") then

else
    --GamePrint("I am looking...")

    local targets = EntityGetInRadiusWithTag(x, y, 60, "potion")
    for i,potion in ipairs(targets) do
        if CellFactory_GetName(GetMaterialInventoryMainMaterial(potion)) == "material_souljuice" 
        and not GameHasFlagRun("phylactery_stage1_done") then
            local tx, ty = EntityGetTransform(potion)
            EntityRemoveComponent(potion,EntityGetFirstComponentIncludingDisabled(potion, "MaterialInventoryComponent") or 0)
            EntityKill(potion)
            --CreateItemActionEntity("KUPOLI_BIND_PHYLACTERY", tx, ty)
            -- spawn empty, unpowered phylactery
            GameAddFlagRun("phylactery_stage1_done")
        end
    end
    if GameHasFlagRun("phylactery_stage1_done") then
        -- player drinks the blood
        if #EntityGetInRadiusWithTag(x, y, 60, "kupoli_effect_souljuice") > 0
        and #EntityGetInRadiusWithTag(x, y, 60, "kupoli_phylactery_vessel") > 0 then
            GamePrint("yes")
            EntityKill(EntityGetInRadiusWithTag(x, y, 60, "kupoli_phylactery_vessel")[1])
            GameAddFlagRun("kupoli_phylactery_done")
            -- spawn the final phylactery
            --[[EntityAddComponent(GetPlayer(), "LuaComponent", {
                script_damage_about_to_be_received="mods/souls/files/phylactery/about_to_be_damaged.lua"
            })]]--
        end
    end
end