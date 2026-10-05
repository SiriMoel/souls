dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    if not EntityHasTag(entity_who_kicked, "player_unit") then return end
    local this = GetUpdatedEntityID()
    local comp_boss = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul_crystal_boss")
    if comp_boss ~= nil then
        local comp_matinv = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")
        if comp_matinv ~= nil then
            local mats = ComponentGetValue2(comp_matinv, "count_per_material_type")
            local amt = mats[CellFactory_GetType("souls_soul_blood_1") + 1] -- ?
            if amt >= 300 then
                SoulsPrintImportant("REVIVAL COMPLETE!", "The Gods watch intently...", "boss")
                local x, y = EntityGetTransform(this)
                EntityLoad(ComponentGetValue2(comp_boss, "value_string"), x, y - 20)
                EntityKill(this)
            end
        else
            print("Souls - could not find soul crystal MaterialInventoryComponent :(")
        end
    else
        print("Souls - could not find soul_crystal_boss component :(")
    end
end