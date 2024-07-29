dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local comp_attack = EntityGetFirstComponentIncludingDisabled(entity, "AIAttackComponent")
local comp_ai = EntityGetFirstComponentIncludingDisabled(entity, "AnimalAIComponent")
local comp_emitter = EntityGetFirstComponentIncludingDisabled(entity, "ParticleEmitterComponent")

--math.randomseed(x,GameGetFrameNum())

if comp_attack ~= nil and comp_emitter ~= nil and comp_ai ~= nil then
    local which = {}

    local pool = {
        {
            proj = "data/entities/projectiles/orb_weaken.xml",
            mat = "void_liquid",
        },
        {
            proj = "data/entities/projectiles/orb_tele.xml",
            mat = "magic_liquid_teleportation",
        },
        {
            proj = "data/entities/projectiles/orb_twitchy.xml",
            mat = "spark_green",
        },
        {
            proj = "data/entities/projectiles/orb_poly.xml",
            mat = "magic_liquid_polymorph",
        },
        {
            proj = "data/entities/projectiles/orb_neutral.xml",
            mat = "spark_white",
        },
        {
            proj = "data/entities/projectiles/orb_hearty.xml",
            mat = "spark_red",
        },
        {
            proj = "data/entities/projectiles/orb_dark.xml",
            mat = "spark_purple",
        },
    }

    which = pool[math.random(1, #pool)]

    ComponentSetValue2(comp_attack, "attack_ranged_entity_file", which.proj)
    ComponentSetValue2(comp_ai, "attack_ranged_entity_file", which.proj)
    ComponentSetValue2(comp_emitter, "emitted_material_name", which.mat)
end