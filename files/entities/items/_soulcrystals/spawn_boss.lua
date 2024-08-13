dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local comp_mi = EntityGetFirstComponentIncludingDisabled(entity, "MaterialInventoryComponent") or 0
local comp_ms = EntityGetFirstComponentIncludingDisabled(entity, "MaterialSuckerComponent") or 0
local x, y = EntityGetTransform(entity)

function kick( entity_who_kicked )
    local amount_soulblood = ComponentGetValue2(comp_mi, "count_per_material_type")[CellFactory_GetType("soul_blood_1") + 1] or 0 --tostring(CellFactory_GetType("soul_blood_1"))
    --GamePrint(tostring(amount_soulblood))
    if amount_soulblood >= 300 then
        GamePrint("Revived a boss!")
        EntityKill(entity)
        EntityLoad(ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "boss") or 0, "value_string"), x, y)
    end
end