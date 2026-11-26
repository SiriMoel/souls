local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

LoadPixelScene("mods/souls/files/biome/gate/scene.png", "mods/souls/files/biome/gate/visual.png", x-256, y-256, "mods/souls/files/biome/gate/background.png", true)

local to_spawn = {
    {"mods/souls/files/biome/gate/reroller.xml", 0, -3},
    {"mods/souls/files/biome/gate/shop.xml", -54, 2},
    {"mods/souls/files/biome/gate/shop.xml", -98, 2},
    {"mods/souls/files/biome/gate/shop.xml", 54, 2},
    {"mods/souls/files/biome/gate/shop.xml", 98, 2},
}

for _, v in ipairs(to_spawn) do
    EntityLoad(v[1], x + v[2], y + v[3])
end