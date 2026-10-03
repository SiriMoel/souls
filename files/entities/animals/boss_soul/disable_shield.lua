local this = GetUpdatedEntityID()   
local comp_shieldparticles = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent", "shield")
if comp_shieldparticles == nil then return end
EntitySetComponentIsEnabled(this, comp_shieldparticles, false)