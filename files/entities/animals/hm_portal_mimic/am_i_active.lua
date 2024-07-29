dofile_once("mods/souls/files/scripts/utils.lua")

local portal = GetUpdatedEntityID()
local x, y = EntityGetTransform(portal)

local comps = EntityGetComponent(portal, "", "prtl")

if #EntityGetInRadiusWithTag(x, y, 25, "hm_mimic") > 0 then

else

end