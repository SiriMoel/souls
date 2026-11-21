local this = GetUpdatedEntityID()
local comp_potion = EntityGetFirstComponentIncludingDisabled(this, "PotionComponent")
if comp_potion ~= nil then
    ComponentSetValue2(comp_potion, "never_color", false)
    ComponentSetValue2(comp_potion, "custom_color_material", CellFactory_GetType("souls_living_particles"))
end