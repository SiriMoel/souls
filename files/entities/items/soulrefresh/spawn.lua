dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()

math.randomseed(x + frame, y + frame)

if math.random(1, 4) == 2 then
    EntityKill(this)
    local thing = EntityLoad("mods/souls/files/entities/items/soulrefresh/thing.xml", x, y)
    if ModIsEnabled("disable-auto-pickup") then
        local comp_item = EntityGetFirstComponentIncludingDisabled(thing, "ItemComponent")
        if comp_item == nil then return end
        ComponentSetValue2(comp_item, "auto_pickup", false)
    end
end