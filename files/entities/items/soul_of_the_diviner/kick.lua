dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    local x, y = EntityGetTransform(this)
    local player = GetPlayer()
    if entity_who_kicked ~= player or this ~= root then return end
    if GlobalsGetValue("souls.soul_emulator_state") == "7" then
        GlobalsSetValue("souls.soul_emulator_state", "8")
        local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
        if comp_uiinfo ~= nil then
            ComponentSetValue2(comp_uiinfo, "name", "$item_moldos_diviner_soul_done")
        end
        local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "item_name", "$item_moldos_diviner_soul_done")
            ComponentSetValue2(comp_item, "ui_description", "$itemdesc_moldos_diviner_soul_done")
        end
        local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
        if comp_ability ~= nil then
            ComponentSetValue2(comp_ability, "ui_name", "$item_moldos_diviner_soul_done")
        end
        ComponentSetValue2(comp_soulscount, "value_int", 6)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
        GamePrintImportant("Soul ascended!", "You are divine.", "mods/souls/files/souls_decoration.png")
        EntityRemoveTag(this, "souls_deny_reap")
        local comps = EntityGetAllComponents(this)
        for i,comp in ipairs(comps) do
            if ComponentHasTag(comp, "sotd_debuff") then
                EntitySetComponentIsEnabled(this, comp, false)
                EntityRemoveComponent(this, comp)
            end
        end
    end
    if GlobalsGetValue("souls.soul_emulator_state") == "8" then
        local comp_soul_count_old = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul_count_old")
        local comp_soulinfinite = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul_infinite")
        if comp_soul_count_old ~= nil and comp_soulinfinite ~= nil then
            local soul_number = ComponentGetValue2(comp_soulinfinite, "value_int")
            local soul_count_old = ComponentGetValue2(comp_soul_count_old, "value_int")
            local soul = soul_types[soul_number]
            SetSoulsCount(soul, soul_count_old)
            soul_number = soul_number + 1
            if soul_types[soul_number] == nil then
                soul_number = 1
            end
            GamePrint("You now have infinite " .. SoulNameCheck(soul_types[soul_number]) .. " souls.")
            ComponentSetValue2(comp_soul_count_old, "value_int", GetSoulsCount(soul_types[soul_number]))
            ComponentSetValue2(comp_soulinfinite, "value_int", soul_number)
            SetSoulsCount(soul_types[soul_number], -1)
        end
    end
end