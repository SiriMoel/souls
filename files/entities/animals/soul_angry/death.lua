dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)

    math.randomseed(x, y+GameGetFrameNum())

    for i=1,1 do
        AddSouls("souls_void", 1)
        if tobool(GlobalsGetValue("souls.say_soul", "true")) == true then
            GamePrint("You have acquired a " .. SoulNameCheck("souls_void") ..  " soul!")
        end
    end

    if math.random(1,6) == 2 then
        CreateItemActionEntity( "MOLDOS_EAT_WAND_FOR_SOULS", x, y )
    end
end