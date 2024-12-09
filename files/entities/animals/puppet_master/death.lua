dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()

    local type = ""

    for i=1,5 do
        type = GetRandomSoulType(false)
        if tobool(GlobalsGetValue("souls.say_soul", "true")) == true then
            GamePrint("You have acquired a " .. SoulNameCheck(type) ..  " soul!")
        end
        AddSouls(type, 1)
    end
end