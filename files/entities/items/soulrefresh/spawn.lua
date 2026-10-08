local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()
SetRandomSeed(x + frame, y + frame)
if Random(1, 4) == 2 then
    EntityKill(this)
    local thing = EntityLoad("mods/souls/files/entities/items/soulrefresh/thing.xml", x, y)
    if ModIsEnabled("disable-auto-pickup") then
        local comp_item = EntityGetFirstComponentIncludingDisabled(thing, "ItemComponent")
        if comp_item == nil then return end
        ComponentSetValue2(comp_item, "auto_pickup", false)
    end
end