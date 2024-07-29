dofile_once("mods/souls/files/scripts/utils.lua")

alterants = {
    {
        id = "",
        name = "",
        desc = "",
        actionid = "",
        sprite = "",
        sprite_inhand = "",
        sprite_ui = "",
        sprite_onwand = "",
        func_apply = function(weapon)
        end,
    },
    {
        id = "SNIPER_KIT",
        name = "Sniper Kit",
        desc = "Apply a laser sight and make your wand shoot faster and more accurate projectiles.",
        actionid = "",
        sprite = "mods/souls/files/entities/alterants/sniperkit/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/sniperkit/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/sniperkit/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/sniperkit/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
            local sniperbeam = EntityLoad("mods/souls/files/entities/alterants/sniperkit/sniperbeam.xml", x, y)
            EntityAddChild(weapon, sniperbeam)
            local speed = ComponentObjectGetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "speed_multiplier") or 0
            local spread = ComponentObjectGetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "spread_degrees") or 0
            spread = spread - 3
            if spread < 0 then
                spread = 0
            end
            if speed == nil then
                speed = 1
            end
            speed = speed + 0.4
            ComponentObjectSetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "speed_multiplier", speed)
            ComponentObjectSetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "spread_degrees", spread)
        end,
    },
    {
        id = "SHOTGUN_KIT",
        name = "Shotgun Kit",
        desc = "Apply an extra barrel to your wand.",
        actionid = "",
        sprite = "mods/souls/files/entities/alterants/shotgunkit/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/shotgunkit/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/shotgunkit/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/shotgunkit/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
            local spread = ComponentObjectGetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "spread_degrees") or 0
            local spellspercast = ComponentObjectGetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "actions_per_round") or 0
            spread = spread + 3
            spellspercast = spellspercast + 1
            ComponentObjectSetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "spread_degrees", spread)
            ComponentObjectSetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "actions_per_round", spellspercast)
        end,
    },
    {
        id = "POISONER_KIT",
        name = "Poisoner Kit",
        desc = "Shoot a trail of poison.",
        actionid = "KUPOLI_ALTERANT_POISONER_KIT",
        sprite = "mods/souls/files/entities/alterants/poisonerkit/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/poisonerkit/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/poisonerkit/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/poisonerkit/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
    {
        id = "HOMING_RAG",
        name = "Rag of Homing",
        desc = "The mages may want this back.",
        actionid = "KUPOLI_ALTERANT_HOMING_RAG",
        sprite = "mods/souls/files/entities/alterants/homingrag/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/homingrag/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/homingrag/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/homingrag/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
    {
        id = "RANDOM_RAG",
        name = "Rag of Risk",
        desc = "The mages may want this back.",
        actionid = "KUPOLI_ALTERANT_RANDOM_RAG",
        sprite = "mods/souls/files/entities/alterants/randomrag/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/randomrag/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/randomrag/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/randomrag/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
    {
        id = "MAGIC_GLUE",
        name = "Glue Kit",
        desc = "Sticky...",
        actionid = "KUPOLI_ALTERANT_MAGIC_GLUE",
        sprite = "mods/souls/files/entities/alterants/magicglue/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/magicglue/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/magicglue/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/magicglue/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
    {
        id = "FIRECRACKER",
        name = "Firecracker",
        desc = "Fun and festive!",
        actionid = "KUPOLI_ALTERANT_FIRECRACKER",
        sprite = "mods/souls/files/entities/alterants/firecracker/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/firecracker/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/firecracker/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/firecracker/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
    {
        id = "FISH",
        name = "Fish",
        desc = "",
        actionid = "KUPOLI_ALTERANT_FIRECRACKER",
        sprite = "mods/souls/files/entities/alterants/fish/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/fish/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/fish/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/fish/alterant_onwand.png",
        func_apply = function(weapon)
            GameAddFlagRun("kupoli_alterant_fish_applied")
        end,
    },
    {
        id = "FISH_LARGE",
        name = "Fish",
        desc = "",
        actionid = "KUPOLI_ALTERANT_FIRECRACKER",
        sprite = "mods/souls/files/entities/alterants/fishlarge/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/fishlarge/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/fishlarge/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/fishlarge/alterant_onwand.png",
        func_apply = function(weapon)
            GameAddFlagRun("kupoli_alterant_fish_large_applied")
        end,
    },
    {
        id = "TELE_RAG",
        name = "Rag of Relocation",
        desc = "The mages may want this back.",
        actionid = "KUPOLI_ALTERANT_TELE_RAG",
        sprite = "mods/souls/files/entities/alterants/telerag/alterant.png",
        sprite_inhand = "mods/souls/files/entities/alterants/telerag/alterant_inhand.png",
        sprite_ui = "mods/souls/files/entities/alterants/telerag/alterant_ui.png",
        sprite_onwand = "mods/souls/files/entities/alterants/telerag/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
        end,
    },
}

function SpawnAlterant(id, x, y)
    --[[
    local a = EntityLoad("mods/souls/files/entities/alterants/alterant.xml", x, y)
    for i,v in ipairs(alterants) do
        if v.id == id then
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "UIInfoComponent") or 0, "name", v.name)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "ItemComponent") or 0, "item_name", v.name)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "ItemComponent") or 0, "ui_description", v.desc)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "AbilityComponent") or 0, "ui_name", v.name)

            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "ItemComponent") or 0, "ui_sprite", v.sprite_ui)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "PhysicsImageShapeComponent") or 0, "image_file", v.sprite)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(a, "SpriteComponent") or 0, "image_file", v.sprite_inhand)

            EntityAddComponent2(a, "VariableStorageComponent", {
                _tags="alterant_id",
                name="alterant_id",
                value_string=v.id,
            })
        end
    end
    ]]--
end

function AddAlterant(wand, a)
    --[[local alterant = {}
    for i,v in ipairs(alterants) do
        if v.id == a then
            alterant = v
        end
    end

    EntityAddComponent2(wand, "SpriteComponent", {
        _enabled="1",
        _tags="enabled_in_hand,enabled_in_world",
        offset_x=4,
        offset_y=4,
        image_file=alterant.sprite_onwand,
    })
    if alterant.actionid ~= "" then
        AddGunActionPermanent(wand, alterant.actionid)
    end
    alterant.func_apply(wand)
    table.insert(applied_alterants, alterant.id)]]--
end