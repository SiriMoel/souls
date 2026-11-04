local sprites_path = "mods/souls/files/soul_sprites/souls.png"
local soul_sprites = {
    {soul = "soul", pos = {x = 1, y = 1}, not_soul_type = true},
    {soul = "bat", pos = {x = 1, y = 12}},
    {soul = "fly", pos = {x = 1, y = 23}},
    {soul = "friendly", pos = {x = 1, y = 34}},
    {soul = "mage", pos = {x = 1, y = 45}},
    {soul = "orcs", pos = {x = 1, y = 56}},
    {soul = "slimes", pos = {x = 1, y = 67}},
    {soul = "spider", pos = {x = 1, y = 78}},
    {soul = "zombie", pos = {x = 1, y = 89}},
    {soul = "worm", pos = {x = 1, y = 100}},
    {soul = "fungus", pos = {x = 1, y = 111}},
    {soul = "ghost", pos = {x = 1, y = 122}},
    {soul = "souls_void", pos = {x = 1, y = 133}},
    {soul = "boss", pos = {x = 1, y = 144}},
    {soul = "mage_corrupted", pos = {x = 1, y = 155}, apotheosis = true},
    {soul = "ghost_whisp", pos = {x = 1, y = 166}, apotheosis = true},
}

-- (thanks yui)
---Split abgr
---@param abgr_int integer
---@return number red, number green, number blue, number alpha
local function abgr_split(abgr_int)
    local r = bit.band(abgr_int, 0xFF)
    local g = bit.band(bit.rshift(abgr_int, 8), 0xFF)
    local b = bit.band(bit.rshift(abgr_int, 16), 0xFF)
    local a = bit.band(bit.rshift(abgr_int, 24), 0xFF)

    return r, g, b, a
end

---Merge rgb
---@param r number
---@param g number
---@param b number
---@param a number
---@return integer color
local function abgr_merge(r, g, b, a)
    return bit.bor(bit.band(r, 0xFF), bit.lshift(bit.band(g, 0xFF), 8), bit.lshift(bit.band(b, 0xFF), 16), bit.lshift(bit.band(a, 0xFF), 24))
end

local function green(pixel)
    local r, g, b, a = abgr_split(pixel)
    local green_pixel = abgr_merge(0.2, g, 0.2, a)
    return green_pixel
end

local sprites_image, sprites_width, sprites_height = ModImageMakeEditable(sprites_path, 172, 177)

if ModSettingGet("souls.green") then
    for x = 0, sprites_width do
        for y = 0, sprites_height do
            local pixel = ModImageGetPixel(sprites_image, x, y)
            local green_pixel = green(pixel)
            ModImageSetPixel(sprites_image, x, y, green_pixel)
        end
    end
    local banshee_image, banshee_width, banshee_height = ModImageMakeEditable("mods/souls/files/entities/animals/boss_banshee/sprite.png", 324, 168)
    for x = 0, banshee_width do
        for y = 0, banshee_height do
            local pixel = ModImageGetPixel(banshee_image, x, y)
            local green_pixel = green(pixel)
            ModImageSetPixel(banshee_image, x, y, green_pixel)
        end
    end
end

for _, soul in ipairs(soul_sprites) do
    local soul_image = ModImageMakeEditable("mods/souls/files/soul_sprites/" .. soul.soul .. ".png", 10, 10)
    for x = 0, 9 do
        for y = 0, 9 do
            local pixel = ModImageGetPixel(sprites_image, soul.pos.x + x, soul.pos.y + y)
            ModImageSetPixel(soul_image, x, y, pixel)
        end
    end
    
    if not soul.not_soul_type then
        local soul_image_silhouette = ModImageMakeEditable("mods/souls/files/soul_sprites/silhouettes/" .. soul.soul .. ".png", 10, 10)
        for x = 0, 9 do
            for y = 0, 9 do
                local pixel = ModImageGetPixel(sprites_image, soul.pos.x + x, soul.pos.y + y)
                local r, g, b, a = abgr_split(pixel)
                local val = (r + g + b) / 3
                local bw_pixel = abgr_merge(val, val, val, a)
                ModImageSetPixel(soul_image_silhouette, x, y, bw_pixel)
            end
        end
    end
end