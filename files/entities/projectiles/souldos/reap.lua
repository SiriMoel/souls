dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    if not table.contains(soul_types, herd_id) then return end

    SetRandomSeed(x, y)
    math.randomseed(x, y+GameGetFrameNum())

    if math.random(1,15) == 10 then
        herd_id = "gilded"
    end

    if ModSettingGet("souls.say_soul") == true then
        GamePrint("You have acquired two " .. SoulNameCheck(herd_id) .. " souls!")
    end

    AddSoul(herd_id)
    AddSoul(herd_id)
end