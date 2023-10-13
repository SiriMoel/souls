dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local bookitem = GetUpdatedEntityID()
local x, y = EntityGetTransform(bookitem)

if #EntityGetInRadiusWithTag(x, y, 10, "player_unit") > 0 then
    GameAddFlagRun("molething_sunbook_unlocked")
    EntityKill(bookitem)
end