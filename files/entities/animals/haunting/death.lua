dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/haunting_rewards.lua")
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local comp_level = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "haunting_level")
    local level = ComponentGetValue2(comp_level, "value_int")
    local death_entity = EntityLoad("mods/souls/files/entities/animals/haunting/death_entity.xml", x, y)
    EntityAddComponent2(death_entity, "VariableStorageComponent", {
        _tags="haunting_level",
        name="haunting_level",
        value_int=level
    })
end