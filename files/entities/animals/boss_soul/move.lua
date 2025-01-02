dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y, r, scale_x, scale_y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 400, "player_unit") or {}

if #targets == 0 then return end

local px, py = EntityGetTransform(targets[1])

local movespeed = 1

local tx, ty = px, py - 70

local nx, ny = x, y

local dist_t = DistanceBetween(x, y, tx, ty)
local dist_p = DistanceBetween(x, y, px, py)

movespeed = math.min(1.2, (100 / dist_p))

if x >= px then
    if scale_x > 0 then
        scale_x = scale_x * -1
    end
else
    if scale_x < 0 then
        scale_x = scale_x * -1
    end
end

if dist_p <= 75 then
    if y < ty then
        ny = y + (1 * movespeed)
    end
    if y > ty then
        ny = y - (1 * movespeed)
    end
else
    local theta = math.asin((ty - y) / dist_t)
    if x < tx then
        nx = x + movespeed
    end
    if x > tx then
        nx = x - movespeed
    end
    ny = y + (movespeed * math.tan(theta))
end

if DistanceBetween(x, y, nx, ny) > 10 then
    nx = x
    ny = y
end

EntitySetTransform(this, nx, ny, r, scale_x, scale_y)