dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local entity = GetUpdatedEntityID()
    local root = EntityGetRootEntity(entity)
    local comp_mi = EntityGetFirstComponentIncludingDisabled(entity, "MaterialInventoryComponent") or 0
    local x, y = EntityGetTransform(entity)
    if root ~= entity then return end
    local amount_soulblood = ComponentGetValue2(comp_mi, "count_per_material_type")[CellFactory_GetType("souls_soul_blood_1") + 1] or 0 --tostring(CellFactory_GetType("souls_soul_blood_1"))
    --GamePrint(tostring(amount_soulblood))
    if amount_soulblood >= 300 then
        GamePrintImportant("REVIVAL COMPLETE!", "The Gods watch intently...", "mods/souls/files/souls_decoration.png")
        EntityKill(entity)
        EntityLoad(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "boss") or 0, "value_string"), x, y)
    end
end