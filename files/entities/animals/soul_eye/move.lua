dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y, r, scale_x, scale_y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 400, "player_unit") or {}

if #targets == 0 then return end

local px, py = EntityGetTransform(targets[1])

local movespeed = 0.2

local dist_p_t = 5

local dist_p = DistanceBetween(x, y, px, py)

local tx, ty = px, py

local theta = (math.pi / 2) - math.atan(y - py, x - px)

tx = ((dist_p_t * math.sin(theta)) / math.sin(math.pi / 2)) + py
ty = ((dist_p_t * math.sin((math.pi / 2) - theta)) / math.sin(math.pi / 2)) + py

local dist_t = DistanceBetween(x, y, tx, ty)

if dist_t > 0 then
    local dist_t_x = math.abs(tx - x)
    local dist_t_y = math.abs(ty - y)

    local amt_x = movespeed * (dist_t_x / dist_p_t)
    local amt_y = movespeed * (dist_t_y / dist_p_t)

    if x <= tx then
        x = x + amt_x
    else
        x = x - amt_x
    end

    if y <= ty then
        y = y + amt_y
    else
        y = y - amt_y
    end
end

EntitySetTransform(this, x, y, r, scale_x, scale_y)