local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 230, "player_unit") or {}
if #targets > 0 then
    LoadPixelScene("mods/souls/files/biome/soulplace/scene.png", "mods/souls/files/biome/soulplace/visual.png", x-256, y-256, "mods/souls/files/biome/soulplace/background.png", true, nil, nil, 48)
    EntityKill(this)
end