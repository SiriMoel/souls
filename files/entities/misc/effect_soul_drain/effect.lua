dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local player = GetPlayer()
local x, y = EntityGetTransform(player)

if root == player then
    if (GetSoulsCount("all") - GetSoulsCount("boss")) > 0 then
        local soul = GetRandomSoul(false)
        RemoveSoul(soul)
    else
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
        if comp_damagemodel ~= nil then
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            EntityInflictDamage(player, max_hp * 0.025, "DAMAGE_CURSE", "Soul drain", "DISINTEGRATED", 0, 0, root, x, y, 0)
        end
    end
end