dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local player = GetPlayer()
local root = EntityGetRootEntity(GetUpdatedEntityID())

if root == player then
    GamePrint("hi")
    local x, y = EntityGetTransform(root)
    if #EntityGetInRadiusWithTag(x, y, 60, "kupoli_phylactery_constructor") > 0
    and #EntityGetInRadiusWithTag(x, y, 60, "kupoli_phylactery_vessel") > 0
    and GameHasFlagRun("phylactery_stage1_done") then
        GamePrint("yes")
    end
else 
    GamePrint(EntityGetName(root)) -- testing
    GamePrint("no")
end