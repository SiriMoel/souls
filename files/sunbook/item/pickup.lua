dofile_once("mods/moles_things/files/scripts/utils.lua")

local bookitem = GetUpdatedEntityID()
local x, y = EntityGetTransform(bookitem)

if #EntityGetInRadiusWithTag(x, y, 5, "player_unit") > 0 then
    GameAddFlagRun("molething_sunbook_unlocked")
    EntityKill(bookitem)
end