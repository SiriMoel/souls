dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local sun = GetUpdatedEntityID()
local x, y = EntityGetTransform(sun)

local targets = EntityGetInRadiusWithTag(x, y, 175, "redsun_revive")

if #targets >= 1 then
    for i,v in ipairs(targets) do
        local boss_comp = EntityGetFirstComponentIncludingDisabled(i, "VariableStorageComponent", "boss") or 0
        local boss = ComponentGetValue2(boss_comp, "boss")
        EntityLoad(boss, x, y)
    end
end