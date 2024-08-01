dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local comp_mi = EntityGetFirstComponentIncludingDisabled(entity, "MaterialInventoryComponent")
local x, y = EntityGetTransform(entity)

if comp_mi ~= nil then
    local amount_soulblood = ComponentObjectGetValue2(comp_mi, "count_per_material_type", "soul_blood_1")
    if amount_soulblood >= 300 then
        EntityKill(entity)
        EntityLoad(Componentgetvalue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "boss"), "value_string"), x, y)
    end
else
    GamePrint("SOULS - cannot find material inventory")
end