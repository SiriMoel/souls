local this = GetUpdatedEntityID()
local comp_life = EntityGetFirstComponent(this, "LifetimeComponent")
local lifetime = ComponentGetValue2(comp_life, "lifetime")
local life = lifetime / 180
local comp_part = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent")
local radius = 60 * life
ComponentSetValue2(comp_part, "area_circle_radius", radius, radius)