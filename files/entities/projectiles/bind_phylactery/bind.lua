dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local proj = GetUpdatedEntityID()
local x, y = EntityGetTransform(proj)

local targets = EntityGetInRadiusWithTag(x, y, 30, "human")

if #targets > 0 then
    local target = targets[1]

    GlobalsSetValue("kupoli_phylactery_entity", tostring(target))
    GamePrint("Phylactery bound soul name: " .. EntityGetName(target))
end