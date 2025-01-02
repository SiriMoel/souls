dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 300, "player_unit") or {}

local effect_amount = tonumber(GlobalsGetValue("souls.soul_boss_shader_effect_amount", "0"))

if #targets > 0 then
    effect_amount = math.min(effect_amount + 1, 600)
else
    effect_amount = math.max(effect_amount - 1, 0)
end

GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))

GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 600), 1, 0, 0)