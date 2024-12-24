dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local root = EntityGetRootEntity(this)

local comp_soulscount = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_count")

--GamePrint("hi")

if comp_soulscount == nil then return end

local soulscount = ComponentGetValue2(comp_soulscount, "value_int")

--EntityKillAllWithTag("souls_sotd_soul")

while root == this and #EntityGetInRadiusWithTag(x, y, 100, "souls_sotd_soul") < soulscount do
    local child = EntityLoad( "mods/souls/files/entities/items/soul_of_the_diviner/soul.xml", x, y )
    EntityAddChild(this, child)
    EntitySetTransform(child, x, y)
end

if GlobalsGetValue("souls.soul_emulator_state") == "3" then -- make it rain in wizards den
    local biome = BiomeMapGetName(x, y)
    if biome == "$biome_wizardcave" then
        if #EntityGetInRadiusWithTag(x, y, 100, "spell_cloud") > 0 then
            GlobalsSetValue("souls.soul_emulator_state", "4")
            local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
            if comp_uiinfo ~= nil then
                ComponentSetValue2(comp_uiinfo, "name", "$item_moldos_diviner_soul_2")
            end
            local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
            if comp_item ~= nil then
                ComponentSetValue2(comp_item, "item_name", "$item_moldos_diviner_soul_2")
                ComponentSetValue2(comp_item, "ui_description", "$itemdesc_moldos_diviner_soul_2")
            end
            local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
            if comp_ability ~= nil then
                ComponentSetValue2(comp_ability, "ui_name", "$item_moldos_diviner_soul_2")
            end
            ComponentSetValue2(comp_soulscount, "value_int", 2)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
            GamePrintImportant("SOUL ALTERED!", "The soul weeps.", "mods/souls/files/souls_decoration.png")
            EntityAddComponent2(this, "MagicConvertMaterialComponent", {
                _tags="sotd_debuff,enabled_in_hand,enabled_in_inventory,enabled_in_world",
		        kill_when_finished=true,
		        --from_material=0,
		        from_material_tag="[liquid_common]",
		        steps_per_frame=2,
		        to_material=CellFactory_GetType("souls_soulaway"),
		        clean_stains=false,
		        is_circle=true,
		        radius=64,
		        loop=true,
            })
        end
    end
end

if GlobalsGetValue("souls.soul_emulator_state") == "4" then -- 3 soul projectiles in the sky
    if y < -4000 then
        if #EntityGetInRadiusWithTag(x, y, 100, "soul_projectile")  >= 3 then
            GlobalsSetValue("souls.soul_emulator_state", "5")
            local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
            if comp_uiinfo ~= nil then
                ComponentSetValue2(comp_uiinfo, "name", "$item_moldos_diviner_soul_3")
            end
            local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
            if comp_item ~= nil then
                ComponentSetValue2(comp_item, "item_name", "$item_moldos_diviner_soul_3")
                ComponentSetValue2(comp_item, "ui_description", "$itemdesc_moldos_diviner_soul_3")
            end
            local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
            if comp_ability ~= nil then
                ComponentSetValue2(comp_ability, "ui_name", "$item_moldos_diviner_soul_3")
            end
            ComponentSetValue2(comp_soulscount, "value_int", 3)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
            GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
            GamePrintImportant("SOUL ALTERED!", "The soul is hopeful.", "mods/souls/files/souls_decoration.png")
            EntityAddTag(this, "souls_item_take_more_damage")
        end
    end
end

if GlobalsGetValue("souls.soul_emulator_state") == "5" then -- near 20 charmed creatures
    local targets = EntityGetInRadiusWithTag(x, y, 512, "mortal")
    local amount = 0
    for i,v in ipairs(targets) do
        if GameGetGameEffectCount(v, "CHARM") > 0 then
            amount = amount + 1
        end
    end
    if amount >= 10 then
        GlobalsSetValue("souls.soul_emulator_state", "6")
        local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
        if comp_uiinfo ~= nil then
            ComponentSetValue2(comp_uiinfo, "name", "$item_moldos_diviner_soul_4")
        end
        local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "item_name", "$item_moldos_diviner_soul_4")
            ComponentSetValue2(comp_item, "ui_description", "$itemdesc_moldos_diviner_soul_4")
        end
        local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
        if comp_ability ~= nil then
            ComponentSetValue2(comp_ability, "ui_name", "$item_moldos_diviner_soul_4")
        end
        ComponentSetValue2(comp_soulscount, "value_int", 4)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
        GamePrintImportant("SOUL ALTERED!", "The soul is loving.", "mods/souls/files/souls_decoration.png")
        EntityAddComponent2(this, "LuaComponent", {
            _tags="sotd_debuff,enabled_in_hand,enabled_in_inventory",
            script_source_file="mods/souls/files/entities/items/soul_of_the_diviner/silly.lua",
            execute_every_n_frame=2,
        })
    end
end

if GlobalsGetValue("souls.soul_emulator_state") == "6" then -- start a wave at the amphitheatre
    if GameHasFlagRun("souls.amphitheatre_active") and #EntityGetInRadiusWithTag(x, y, 200, "souls_amphitheatre_enemy") > 0 then
        GlobalsSetValue("souls.soul_emulator_state", "7")
        local comp_uiinfo = EntityGetFirstComponentIncludingDisabled(this, "UIInfoComponent")
        if comp_uiinfo ~= nil then
            ComponentSetValue2(comp_uiinfo, "name", "$item_moldos_diviner_soul_5")
        end
        local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "item_name", "$item_moldos_diviner_soul_5")
            ComponentSetValue2(comp_item, "ui_description", "$itemdesc_moldos_diviner_soul_5")
        end
        local comp_ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
        if comp_ability ~= nil then
            ComponentSetValue2(comp_ability, "ui_name", "$item_moldos_diviner_soul_5")
        end
        ComponentSetValue2(comp_soulscount, "value_int", 5)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)
        GamePrintImportant("SOUL ALTERED!", "The soul is ready.", "mods/souls/files/souls_decoration.png")
        local comps = EntityGetAllComponents(this)
        for i,comp in ipairs(comps) do
            if ComponentHasTag(comp, "sotd_debuff") then
                EntitySetComponentIsEnabled(this, comp, false)
                EntityRemoveComponent(this, comp)
            end
        end
        EntityRemoveTag(this, "souls_deny_reap")
        EntityRemoveTag(this, "souls_item_take_more_damage")
    end
end