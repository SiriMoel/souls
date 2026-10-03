dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
    if comp_soul == nil then return end
    local soul = ComponentGetValue2(comp_soul, "value_string")
    DontFearTheReaper({[soul] = 3}, this)
end