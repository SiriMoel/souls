local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 400, "souls_boss_soul") or {}
local effect_amount = tonumber(GlobalsGetValue("souls.soul_boss_shader_effect_amount", "0"))
if #targets > 0 then
    effect_amount = math.min(effect_amount + 1, 300)
    GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))
    GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 300), 1, 0, 0)
elseif effect_amount > 0 then
    effect_amount = math.max(effect_amount - 1, 0)
    GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))
    GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 300), 1, 0, 0)
end

local trip_effects = EntityGetAllChildren(this, "souls_effect_trip") or {}
local trip_amt = tonumber(GlobalsGetValue("souls.trip_amt", "0"))
if #trip_effects > 0 then
    trip_amt = math.min(trip_amt + 1, 180)
    GlobalsSetValue("souls.trip_amt", tostring(trip_amt))
    GameSetPostFxParameter("souls_trip", math.min(1, trip_amt / 180), 1, 0, 0)
elseif trip_amt > 0 then
    trip_amt = math.max(trip_amt - 1, 0)
    GlobalsSetValue("souls.trip_amt", tostring(trip_amt))
    GameSetPostFxParameter("souls_trip", math.min(1, trip_amt / 180), 1, 0, 0)
end