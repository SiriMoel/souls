dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity_id, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    
    if not table.contains(soul_types, herd_id) then return end

    if ModSettingGet("moles_n_more.say_soul") == true then
        GamePrint("You have acquired a " .. herd_id .. " soul!")
    end

    AddSoul(herd_id)
end