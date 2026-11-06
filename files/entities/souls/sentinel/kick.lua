function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    if not EntityHasTag(entity_who_kicked, "player_unit") then return end
    local c = EntityGetAllChildren(this) or {}
    for i, v in ipairs(c) do
        EntityKill(v)
    end
    EntityKill(this)
end