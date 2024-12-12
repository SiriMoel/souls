dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup(entity_item, entity_who_picked, item_name)
    local x, y = EntityGetTransform(entity_item)
    GameAddFlagRun("souls_soul_emulated")
    GlobalsSetValue("souls.soul_emulator_state", "1")
    EntityLoad("data/entities/particles/image_emitters/perk_effect.xml", x, y)
    EntityLoad("mods/souls/files/entities/items/soul_tablet/item.xml", x, y - 6)
    GamePrintImportant("Soul emulated!", "Something irreversible has occured.", "mods/souls/files/souls_decoration.png")
    EntityKill(entity_item)
end