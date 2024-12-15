dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
        
local comp_shieldparticles = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent", "shield")

if comp_shieldparticles == nil then return end

EntitySetComponentIsEnabled(this, comp_shieldparticles, false)