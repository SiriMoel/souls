dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local state = GlobalsGetValue("souls.soul_emulator_state", "0")

if GetSoulsCount("all") == 0 and tonumber(state) >= 2 then
    EntityConvertToMaterial(player, "souls_soul_blood_perfect", true, false)
    EntityInflictDamage(player, 1000000000000, "DAMAGE_CURSE", "You are a soulless being.", "DISINTEGRATED", 0, 0, player, x, y, 0)
end