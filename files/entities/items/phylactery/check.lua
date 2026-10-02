local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local comp_mi = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")
if comp_mi ~= nil then
    local this_amt = tonumber(ComponentGetValue2(comp_mi, "count_per_material_type")[CellFactory_GetType("souls_soul_blood_perfect") + 1])
    if this_amt >= 300 then
        if not EntityHasTag(this, "souls_phylactery_full") then
            GamePrint("The phylactery is full of perfect soul blood.")
            EntityAddTag(this, "souls_phylactery_full")
        end
        local player = EntityGetWithTag("player_unit")[1]
        local comp_player_mi = EntityGetFirstComponentIncludingDisabled(player, "MaterialInventoryComponent")
        if comp_player_mi ~= nil then
            local player_amt = tonumber(ComponentGetValue2(comp_player_mi, "count_per_material_type")[CellFactory_GetType("souls_soul_blood_perfect") + 1])
            if player_amt > 0 then
                local phylactery = EntityLoad("mods/souls/files/entities/items/phylactery/item_done.xml", x, y)
                local comp_phylactery = EntityGetFirstComponentIncludingDisabled(phylactery, "VariableStorageComponent", "phylactery")
                if comp_phylactery ~= nil then
                    ComponentSetValue2(comp_phylactery, "value_int", 10)
                end
                EntityLoad("mods/souls/files/entities/items/phylactery/done_fx.xml", x, y-2)
                GamePrintImportant("THE PHYLACTERY HUMS WITH ENERGY!", "It is done.", "mods/souls/files/souls_decoration.png")
                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y) -- placeholder probably
                GameAddFlagRun("souls_phylactery_done")
                EntityKill(this)
            end
        end
    end
end