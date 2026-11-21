dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID()
local comp_matinv = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")
if comp_matinv ~= nil then
    local mats = ComponentGetValue2(comp_matinv, "count_per_material_type")
    local amt = mats[CellFactory_GetType("souls_soul_blood_1") + 1]
    local comp_mat_suck = EntityGetFirstComponentIncludingDisabled(this, "MaterialSuckerComponent")
    local required = ComponentGetValue2(comp_mat_suck, "barrel_size") or 150
    if amt >= required - 5 then
        SoulsPrintImportant("The crystal is full!", "It is ready.", "boss")
        local comp_part = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent")
        if comp_part ~= nil then
            ComponentSetValue2(comp_part, "emitted_material_name", "souls_soul_particles")
        end
        local comp_potion = EntityGetFirstComponentIncludingDisabled(this, "PotionComponent")
        if comp_potion ~= nil then
            ComponentSetValue2(comp_potion, "custom_color_material", CellFactory_GetType("souls_nothing_particles"))
        end
        local this_comp = GetUpdatedComponentID()
        EntityRemoveComponent(this, this_comp)
    end
end