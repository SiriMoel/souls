dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local targets = EntityGetInRadiusWithTag(x, y, 7, "sun_blue_mimic")

local bluesun = EntityGetWithTag("sun_blue_mimic")[1]

for i,sun in ipairs(targets) do
    local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(sun, "DamageModelComponent") or 0
    EntityInflictDamage(player, -100, "DAMAGE_HEALING", "Blue Sun", "NONE", x, y, bluesun, x, y, 0)
    EntityKill(entity)
end

local targets2 = EntityGetInRadiusWithTag(x, y, 7, "projectile_player")

if #targets2 > 0 then
    EntityKill(entity)
end
