dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/haunting_rewards.lua")
local this = GetUpdatedEntityID()
local comp_life = EntityGetFirstComponent(this, "VariableStorageComponent", "frames_left")
local life = ComponentGetValue2(comp_life, "value_int") or 0
life = life - 1
ComponentSetValue2(comp_life, "value_int", life)
local x, y = EntityGetTransform(this)
local comp_sprite = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent")
local scale_y = 1 + (0.6 * (1 - life/180)) * math.sin(1500/life)
ComponentSetValue2(comp_sprite, "special_scale_y", scale_y)
local comp_part = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent")
local radius = 100 * (1 - life/180)
ComponentSetValue2(comp_part, "area_circle_radius", 1, radius)
if life <= 0 then
    GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
    local comp_level = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "haunting_level")
    local level = ComponentGetValue2(comp_level, "value_int")
    HauntingReward(level, x, y)
    SoulsDeath(this, EntityGetWithTag("player_unit")[1])
    GameScreenshake(5)
    EntityKill(this)
end