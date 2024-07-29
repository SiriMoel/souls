dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local phylactery_points = tonumber(GlobalsGetValue("kupoli_phylactery_points", "0"))

if phylactery_points <= 0 then
    -- change sprite
else
    -- change sprite
end