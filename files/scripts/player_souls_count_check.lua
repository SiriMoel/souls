dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local player = GetUpdatedEntityID()

local state = GlobalsGetValue("souls.soul_emulator_state", "0")

if GetSoulsCount("all") == 0 and state >= 2 then
    EntityConvertToMaterial(player, "soul_blood_perfect", true, false)
end