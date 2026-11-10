local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 240, "player_unit") or {}

if #targets > 0 then
    LoadPixelScene("mods/souls/files/biome/curseroom/scene.png", "mods/souls/files/biome/curseroom/visual.png", x-98, y-98, "mods/souls/files/biome/curseroom/background.png", true)

    --if ModSettingGet("souls.collect_soul_from_entity") == true then
    EntityLoad("mods/souls/files/entities/items/curse/curse_item.xml", x, y + 42)
    --end

    EntityKill(this)
end