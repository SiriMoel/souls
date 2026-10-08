dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

if EntityHasTag(root, "player_unit") then
    local effect_amount = tonumber(GlobalsGetValue("souls.soul_boss_shader_effect_amount", "0"))
    effect_amount = math.min(effect_amount + 80, 300)
    GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))
    GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 300), 1, 0, 0)
    if SoulCount("total", root) > 0 then
        LoseSouls(root, 1, true)
        --GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
        EntityInflictDamage(root, 0.0, "DAMAGE_CURSE", "Soul drain", "DISINTEGRATED", 0, 0, root, x, y, 0)
    else
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent")
        if comp_damagemodel ~= nil then
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            EntityInflictDamage(root, max_hp * 0.03, "DAMAGE_CURSE", "Soul drain", "DISINTEGRATED", 0, 0, root, x, y, 0)
        end
    end
end