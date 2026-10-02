local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local radius = 40
local targets = EntityGetInRadiusWithTag(x, y, radius, "homing_target") or {}
if #targets > 0 then
    for i, target in ipairs(targets) do
        local c = EntityGetAllChildren(target, "souls_reaper_normal") or {}
        if #c == 0 then
            local tx, ty = EntityGetTransform(target)
            local reaper = EntityLoad("mods/souls/files/entities/misc/reapers/reap_entity.xml", tx, ty)
            EntityAddChild(target, reaper)
        end
    end
end