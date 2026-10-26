local this = GetUpdatedEntityID()
local comp_life = EntityGetFirstComponent(this, "VariableStorageComponent", "frames_left")
local life = ComponentGetValue2(comp_life, "value_int") or 0
life = life - 1
ComponentSetValue2(comp_life, "value_int", life)
local x, y = EntityGetTransform(this)
EntitySetTransform(this, x, y - 0.6 * (1 - life/60))
local comp_part = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent")
local radius = 60 * (life/60)
ComponentSetValue2(comp_part, "area_circle_radius", radius, radius)
if life <= 0 then
    --GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
    GameScreenshake(10)
    EntityKill(this)
end