local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local gec = EntityGetFirstComponent(this, "GameEffectComponent")
if gec == nil then return end
local frames = ComponentGetValue2(gec, "frames")
local life = frames/1200
local radius = 500 * life
local comp = EntityGetFirstComponent(this, "FogOfWarRemoverComponent")
local comp2 = EntityGetFirstComponent(this, "LightComponent")
ComponentSetValue2(comp, "radius", radius)
ComponentSetValue2(comp2, "radius", radius)
local x, y = EntityGetTransform(root)
 GameCreateSpriteForXFrames("mods/souls/files/entities/misc/effect_sight/seen_player.png", x, y - 6, true, 0, 0, 1, true)
local targets = EntityGetInRadiusWithTag(x, y, radius, "homing_target") or {}
if #targets > 0 then
    for i = 1, #targets do
        local target = targets[i]
        local tx, ty = EntityGetTransform(target)
        GameCreateSpriteForXFrames("mods/souls/files/entities/misc/effect_sight/seen.png", tx, ty - 6, true, 0, 0, 1, true)
    end
end
local targets2 = EntityGetInRadiusWithTag(x, y, radius, "item_pickup") or {}
if #targets2 > 0 then
    for i = 1, #targets do
        local target = targets2[i]
        if EntityGetRootEntity(target) == target then
            local tx, ty = EntityGetTransform(target)
            GameCreateSpriteForXFrames("mods/souls/files/entities/misc/effect_sight/seen_item.png", tx, ty - 6, true, 0, 0, 1, true)
        end
    end
end
local targets3 = EntityGetInRadiusWithTag(x, y, radius, "wand") or {}
if #targets3 > 0 then
    for i = 1, #targets3 do
        local target = targets3[i]
        if EntityGetRootEntity(target) == target then
            local tx, ty = EntityGetTransform(target)
            GameCreateSpriteForXFrames("mods/souls/files/entities/misc/effect_sight/seen_wand.png", tx, ty - 6, true, 0, 0, 1, true)
        end
    end
end