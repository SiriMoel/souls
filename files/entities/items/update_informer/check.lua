local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 200, "player_unit") or {}
if #targets == 0 then
    EntityKill(this)
end