dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/entities/projectiles/adaptive/soul_effects.lua")

local proj = GetUpdatedEntityID()

local comp_soul = EntityGetFirstComponentIncludingDisabled(proj, "VariableStorageComponent", "adaptive_soul")
local soul = ComponentGetValue2(comp_soul, "value_string")

if soul_effects[soul] ~= nil then
    local comp_proj = EntityGetFirstComponent(proj, "ProjectileComponent")
    local comp_part = EntityGetFirstComponent(proj, "ParticleEmitterComponent")
    soul_effects[soul](proj, comp_proj, comp_part)
end

SoulsPrint("A " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " soul was consumed!", "say_consumed_soul")

local spec = EntityGetFirstComponent(proj, "SpriteParticleEmitterComponent", "adaptive_soul")
if spec ~= nil then
    ComponentSetValue2(spec, "sprite_file", "mods/souls/files/soul_sprites/" .. soul .. ".png")
end