local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 240, "player_unit") or {}

if #targets > 0 then
    LoadPixelScene("mods/souls/files/biome/bansheeplace/scene.png", "mods/souls/files/biome/bansheeplace/visual.png", x-98, y-98, "mods/souls/files/biome/bansheeplace/background.png", true)

    EntityLoad("data/entities/props/physics/chain_torch_ghostly.xml", x - 28, y - 74)
    EntityLoad("data/entities/props/physics/chain_torch_ghostly.xml", x + 28, y - 74)

    EntityLoad("mods/souls/files/entities/animals/boss_banshee/spawner.xml", x, y - 6)

    EntityKill(this)
end