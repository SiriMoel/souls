dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 72, "player_unit")

if #targets > 0 then
    for i,target in ipairs(targets) do
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(target, "DamageModelComponent")
        if comp_damagemodel ~= nil then
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            EntityInflictDamage(target, max_hp * 0.005, "DAMAGE_CURSE", "Soul drain", "DISINTEGRATED", 0, 0, root, x, y, 0)
        end
    end
end