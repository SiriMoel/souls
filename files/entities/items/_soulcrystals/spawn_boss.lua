dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    if this ~= root then return end
    if not EntityHasTag(entity_who_kicked, "player_unit") then return end
    local comp_boss = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul_crystal_boss")
    if comp_boss ~= nil then
        local comp_matinv = EntityGetFirstComponentIncludingDisabled(this, "MaterialInventoryComponent")
        if comp_matinv ~= nil then
            local mats = ComponentGetValue2(comp_matinv, "count_per_material_type")
            local amt = mats[CellFactory_GetType("souls_soul_blood_1") + 1] -- ?
            if amt >= 150 then
                local revived = tonumber(GlobalsGetValue("souls.bosses_revived", "0"))
                revived = revived + 1
                local desc = "The Gods watch intently..."
                if revived > 20 then
                    desc = "The Gods are no longer interested."
                elseif revived > 10 then
                    desc = "The Gods are losing interest..."
                elseif revived > 5 then
                    desc = "The Gods watch..."
                end
                SoulsPrintImportant("THE CRYSTAL SHATTERS!", desc, "boss")
                GlobalsSetValue("souls.bosses_revived", tostring(revived))
                local x, y = EntityGetTransform(this)
                local reviver = EntityLoad("mods/souls/files/entities/items/_soulcrystals/_reviver.xml", x, y - 24)
                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
                EntityAddComponent2(reviver, "VariableStorageComponent", {
                    _tags="souls_boss_to_revive",
                    name="boss",
                    value_string=ComponentGetValue2(comp_boss, "value_string"),
                })
                EntityKill(this)
            end
        else
            print("Souls - could not find soul crystal MaterialInventoryComponent :(")
        end
    else
        print("Souls - could not find soul_crystal_boss component :(")
    end
end