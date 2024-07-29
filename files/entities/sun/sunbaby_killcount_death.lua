dofile_once("mods/souls/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity )
    
    local sunbaby = EntityGetInRadiusWithTag(x, y, 260, "sunbaby")
    
    for i,sun in ipairs(sunbaby) do
        local comp = EntityGetFirstComponentIncludingDisabled(sun, "VariableStorageComponent", "sunbaby_kills") or 0
        local value = ComponentGetValue2(comp, "value_int")
        value = value + 1
        ComponentSetValue2(comp, "value_int", value)
    end
end