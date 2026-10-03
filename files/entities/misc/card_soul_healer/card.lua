dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)

if EntityHasTag(root, "player_unit") then
    if SpellUseSouls(root, 1) then
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(root, "DamageModelComponent") or 0
        local hp = ComponentGetValue2(comp_damagemodel, "hp")
        local hp_max = ComponentGetValue2(comp_damagemodel, "max_hp")
        local x, y = EntityGetTransform(root)
        EntityInflictDamage(root, hp_max * -0.04, "DAMAGE_HEALING", "Soul healing", "DISINTEGRATED", 0, 0, card, x, y, 0)
    end
end