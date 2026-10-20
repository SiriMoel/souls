local this = GetUpdatedEntityID()
local spec = EntityGetFirstComponent(this, "SpriteParticleEmitterComponent", "souls_resonate")
if spec ~= nil then
    local frame = GameGetFrameNum()
    local scale = 0.35 + 0.1 * (1 + math.sin(frame / 45))
    ComponentSetValue2(spec, "scale", scale, scale)
    local rot = ComponentGetValue2(spec, "rotation")
    rot = rot + 0.055
    ComponentSetValue2(spec, "rotation", rot)
end