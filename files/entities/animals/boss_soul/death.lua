dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)

    EntityLoad("mods/souls/files/entities/items/soul_of_the_diviner/item.xml", x, y - 4)

    local player = EntityGetWithTag("player_unit")[1]

    local diviner = EntityGetAllChildren(player, "souls_diviner")[1]
    local comp_state = EntityGetFirstComponentIncludingDisabled(diviner, "VariableStorageComponent", "state")
    ComponentSetValue2(comp_state, "value_int", 3)

    local comp_soulcheck = EntityGetFirstComponent(player, "LuaComponent", "diviner_state_2")
    if comp_soulcheck ~= nil then
        EntityRemoveComponent(player, comp_soulcheck)
    end
end