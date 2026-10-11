local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)
if not EntityHasTag(root, "player_unit") then return end
local gec = EntityGetFirstComponent(this, "GameEffectComponent")
local frames = ComponentGetValue2(gec, "frames")
if frames <= 0 then
    EntityKill(this)
    return
end
EntityInflictDamage(root, 0.04, "DAMAGE_CURSE", "$status_souls_absinthe_bad", "DISINTEGRATED", 0, 0, root, x, y, 0)