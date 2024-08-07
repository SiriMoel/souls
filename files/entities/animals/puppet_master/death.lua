dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()

    local type = ""

    for i=1,5 do
        type = soul_types[math.random(1,#soul_types)]
        if ModSettingGet("souls.say_soul") == true then
            GamePrint("You have acquired a " .. SoulNameCheck(type) ..  " soul!")
        end
        AddSouls(type, 1)
    end
end