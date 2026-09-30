local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local mark_radius = 56

local targets = EntityGetInRadiusWithTag(x, y, mark_radius, "homing_target") or {}

if #targets > 0 then
    for i = 1, #targets do
        local target = targets[i]
        local c = EntityGetAllChildren(target, "souls_reaper_normal") or {}
        if #c == 0 then
            local r = EntityLoad("mods/souls/files/entities/misc/reapers/base_reap_entity.xml", x y)
            EntityAddChild(target, r)
        end
    end
end