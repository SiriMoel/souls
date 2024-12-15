dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    EntityLoad("mods/souls/files/entities/items/soul_of_the_diviner/item.xml", x, y)
    AddSouls("boss", 10)
    GlobalsSetValue("souls.soul_emulator_state", "3")
end