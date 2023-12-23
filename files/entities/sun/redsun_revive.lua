dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local sun = GetUpdatedEntityID()
local x, y = EntityGetTransform(sun)

local targets = EntityGetInRadiusWithTag(x, y, 110, "redsun_revive")

for i,v in ipairs(targets) do
    local boss_comp = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "boss") or 0
    local boss = ComponentGetValue2(boss_comp, "value_string")
    EntityLoad(boss, x, y)
    EntityKill(v)
end