local this = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(this, "SpriteComponent", "haunting_soul")
if comp ~= nil then
    local frame_now = GameGetFrameNum()
    --[[local angle = frame_now/240 * math.pi * 2
    local dist = 14 + math.sin(frame_now/60) * 2
    local offset_x = math.cos(angle) * dist + 7
    local offset_y = math.sin(angle) * dist + 9]]
    -- or
    local offset_x = 7
    local offset_y = 30 + 5 * math.sin(frame_now / 60)
	ComponentSetValue2(comp, "offset_x", offset_x)
    ComponentSetValue2(comp, "offset_y", offset_y)
end