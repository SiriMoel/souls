dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

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
        desc = "Apply a laser sight and make your wand shoot faster projectiles.",
        actionid = "",
        sprite = "mods/tales_of_kupoli/files/entities/alterants/sniperkit/alterant.png",
        sprite_inhand = "mods/tales_of_kupoli/files/entities/alterants/sniperkit/alterant_inhand.png",
        sprite_ui = "mods/tales_of_kupoli/files/entities/alterants/sniperkit/alterant_ui.png",
        sprite_onwand = "mods/tales_of_kupoli/files/entities/alterants/sniperkit/alterant_onwand.png",
        func_apply = function(weapon)
            local x, y = EntityGetTransform(weapon)
            local sniperbeam = EntityLoad("mods/tales_of_kupoli/files/entities/alterants/sniperkit/sniperbeam.xml", x, y)
            EntityAddChild(weapon, sniperbeam)
            ComponentObjectSetValue2(EntityGetFirstComponentIncludingDisabled(weapon, "AbilityComponent") or 0, "gun_config", "speed_multiplier", 1.4)
        end,
    },
}

function SpawnAlterant(id, x, y)
    local a = EntityLoad("mods/tales_of_kupoli/files/entities/alterants/alterant.xml", x, y)
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
end