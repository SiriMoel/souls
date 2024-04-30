dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local targets = EntityGetInRadiusWithTag(x, y, 7, "player_unit")

local bluesun = EntityGetWithTag("sun_blue_mimic")[1]

for i,player in ipairs(targets) do
    local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent") or 0
    local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
    EntityInflictDamage(player, max_hp * 0.3, "DAMAGE_CURSE", "Blue Sun", "NONE", x, y, bluesun, x, y, 0)
end
