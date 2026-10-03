local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)
local x, y = EntityGetTransform(root)
local targets = EntityGetInRadiusWithTag(x, y, 150, "souls_reaper") or {}
if #targets > 0 then
    for i = 1, #targets do
        local target = EntityGetParent(targets[i])
        LoadGameEffectEntityTo(target, "data/entities/misc/effect_apply_on_fire.xml")
    end
end