dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local player = GetPlayer()
local comp_mi = EntityGetFirstComponentIncludingDisabled(entity, "MaterialInventoryComponent") or 0
local comp_player_mi = EntityGetFirstComponentIncludingDisabled(player, "MaterialInventoryComponent") or 0
local comp_ms = EntityGetFirstComponentIncludingDisabled(entity, "MaterialSuckerComponent") or 0
local x, y = EntityGetTransform(entity)

function kick( entity_who_kicked )
    local amount_soulblood = tonumber(ComponentGetValue2(comp_mi, "count_per_material_type")[CellFactory_GetType("soul_blood_perfect") + 1]) or 0 --tostring(CellFactory_GetType("soul_blood_1"))
    local amount_soulblood_player = tonumber(ComponentGetValue2(comp_player_mi, "count_per_material_type")[CellFactory_GetType("soul_blood_perfect") + 1]) or 0 
    if amount_soulblood >= 300 and amount_soulblood_player >= 1 then
        GamePrintImportant("The phylactery hums with energy!", "It is done.", "mods/souls/files/souls_decoration.png")
        GameAddFlagRun("souls_phylactery_done")
        EntityKill(entity)
        EntityLoad("mods/souls/files/entities/items/phylactery/item_done.xml", x, y)
    end
end