dofile_once("mods/moles_things/files/scripts/utils.lua")
dofile_once("mods/moles_things/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    
    if not table.contains(soul_types, herd_id) then return end

    if ModSettingGet("moles_things.say_soul") == true then
        GamePrint("You have acquired a " .. herd_id .. " soul!")
    end

    AddSoul(herd_id)
end