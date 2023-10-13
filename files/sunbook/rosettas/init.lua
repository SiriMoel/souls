dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local orbs = EntityGetInRadiusWithTag(x, y, 50, "noita_orb")

--GamePrint("Orb spotted!")

for i,orb in orbs do
    local orb_comp = EntityGetFirstComponent(orb, "OrbComponent") or 0
    local orb_id = ComponentGetValue2(orb_comp, "orb_id") or 0
end