local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()
local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "count")
local count = ComponentGetValue2(comp, "value_int")
count = count - 1
local range = 170
local min_x, max_x = x - range * 0.5, x + range * 0.5
local min_y, max_y = y - range * 0.5, y + range * 0.5
SetRandomSeed(x + frame, y)
local minion_x = Random(min_x, max_x)
local minion_y = Random(min_y, max_y)
EntityLoad("mods/souls/files/entities/animals/boss_banshee/minion.xml", minion_x, minion_y)
if count <= 0 then
    EntityKill(this)
else
    ComponentSetValue2(comp, "value_int", count)
end