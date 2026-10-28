function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)

    local e = EntityGetInRadiusWithTag(x, y, 300, "souls_boss_banshee") or {}
    if #e > 0 then
        if not EntityHasTag(e, "souls_banshee_ring_down") then
        EntityLoad("mods/souls/files/entities/animals/boss_banshee/minion_soul.xml", x, y)
        end
    end
end