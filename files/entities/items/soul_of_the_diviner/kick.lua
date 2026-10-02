dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    local x, y = EntityGetTransform(this)
    local comp_soulscount = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_count") or 0
    if not EntityHasTag(entity_who_kicked, "player_unit") or this ~= root then return end
    local diviner = EntityGetAllChildren(player, "souls_diviner")[1]
    local comp_state = EntityGetFirstComponentIncludingDisabled(diviner, "VariableStorageComponent", "state")
    local diviner_state = ComponentGetValue2(comp_state, "value_int")
    if diviner_state == 7 then
        ComponentSetValue2(comp_state, "value_int", 8)
        local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
        if comp_uiinfo ~= nil then
            ComponentSetValue2(comp_uiinfo, "name", "$item_souls_diviner_soul_done")
        end
        local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "item_name", "$item_souls_diviner_soul_done")
            ComponentSetValue2(comp_item, "ui_description", "$itemdesc_souls_diviner_soul_done")
        end
        local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
        if comp_ability ~= nil then
            ComponentSetValue2(comp_ability, "ui_name", "$item_souls_diviner_soul_done")
        end
        ComponentSetValue2(comp_soulscount, "value_int", 6)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
        GamePrintImportant("SOUL ASCENDED!", "You have become divine.", "mods/souls/files/souls_decoration.png")
        AddFlagPersistent("souls_sotd_quest_done")
        GameAddFlagRun("souls_divine")
        EntityAddTag(entity_who_kicked, "souls_divine")
        EntityRemoveTag(this, "souls_deny_reap")
        EntityRemoveTag(this, "souls_item_take_more_damage")
        local comps = EntityGetAllComponents(this)
        for i,comp in ipairs(comps) do
            if ComponentHasTag(comp, "sotd_debuff") then
                EntitySetComponentIsEnabled(this, comp, false)
                EntityRemoveComponent(this, comp)
            end
        end
    end
end