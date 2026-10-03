dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

if EntityHasTag(root, "player_unit") then
    if SoulCount("total", root) > 0 then
        LoseSouls(root, 1, true)
    else
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent")
        if comp_damagemodel ~= nil then
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            EntityInflictDamage(root, max_hp * 0.025, "DAMAGE_CURSE", "Soul drain", "DISINTEGRATED", 0, 0, root, x, y, 0)
        end
    end
end