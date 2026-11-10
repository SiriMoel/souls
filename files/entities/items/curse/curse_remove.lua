dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp_mi = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")

if comp_mi ~= nil then
    local amt = tonumber(ComponentGetValue2(comp_mi, "count_per_material_type")[CellFactory_GetType("souls_soulaway") + 1])

    if this_amt >= 30 then
        GameRemoveFlagRun("souls_cursed")

        EntityLoad("mods/souls/files/entities/items/curse_item.xml", x, y - 16)

        -- vfx/sfx

        SoulsPrintImportant("THE CURSE IS LIFTED!", "You are calm.")
        
        EntityKill(this)
    end
end