local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
LoadPixelScene("mods/souls/files/biome/fountain/scene.png", "", x-53, y-68, "mods/souls/files/biome/fountain/background.png", true)
EntityKill(this)