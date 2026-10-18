dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 170, "homing_target") or {}
if #targets > 0 then
    for _, target in ipairs(targets) do
        if not EntityHasTag(target, "souls_tome_fielded") then
            EntityAddTag(target, "souls_tome_fielded")
            local soul_type, herd_id = GetEntitySoulType(target)
            if herd_id ~= "robot" then
                DontFearTheReaper({[soul_type]=1}, target)
            end
        end
    end
end