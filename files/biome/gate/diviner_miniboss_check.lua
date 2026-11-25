local gate = GetUpdatedEntityID()
local x, y = EntityGetTransform(gate)
if GameHasFlagRun("souls_spawn_soul_boss") then
    local players = EntityGetInRadiusWithTag(x, y, 250, "player_unit") or {}
    if #players > 0 then
        EntityLoad("data/entities/animals/souls_boss_soul.xml", x, y - 40)
        GameRemoveFlagRun("souls_spawn_soul_boss")
    end
end