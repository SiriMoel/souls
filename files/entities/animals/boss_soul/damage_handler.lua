dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    if damage > 0 then
        local this = GetUpdatedEntityID()
        local player = GetPlayer()
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(this, "DamageModelComponent") or 0
        local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
        if entity_thats_responsible ~= player then
            return 0, 0
        end
        if damage > (max_hp * 0.1) then
            damage = max_hp * 0.1
        end
    end
    return damage, critical_hit_chance
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    if not EntityHasTag(projectile_thats_responsible, "soul_projectile") then
        EntityInflictDamage(this, (damage * -1.5), "DAMAGE_HEALING", message, "DISINTEGRATED", 0, 0, entity_thats_responsible, x, y, 0)
        GamePrint("Only soul magic can hurt it...")
    end
end