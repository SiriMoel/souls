dofile_once("mods/souls/files/scripts/utils.lua")

function damage_about_to_be_recieved(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()
    local phylactery_points = tonumber(GlobalsGetValue("kupoli_phylactery_points", "0"))

    if tonumber(GlobalsGetValue("kupoli_phylactery_points_used")) == 250 then
        EntityAddTag(player, "kupoli_lich")
    end

    if  phylactery_points > 0 then
        GlobalsSetValue("kupoli_phylactery_points", tostring(phylactery_points - 1))
        GlobalsSetValue("kupoli_phylactery_points_used", tostring(tonumber(GlobalsGetValue("kupoli_phylactery_points_used")) + 1))
        return 0, 0
    elseif phylactery_points <= 0 then
        return damage * 1.5, critical_hit_chance
    end

    return damage, critical_hit_chance
end