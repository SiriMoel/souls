dofile_once("mods/souls/files/scripts/utils.lua")

local host = GetUpdatedEntityID()
local x, y = EntityGetTransform(host)

local proj_file = "mods/souls/files/entities/animals/boss_valkoinen/proj_halo.xml"

math.randomseed(x, y + GameGetFrameNum())

local count = 5
local radius = 9

local px = 0
local py = 0

local v_px = 0
local v_py = 0

local arc = 360 / count -- idk if this is the right word but math is stupid anyways

for i=1,count do -- none of this maths is going to do what i want it do
    px = x + radius
    py = y + ( 9 * math.tan(arc) )

    v_px = px
    if math.random(1,2) == 2 then
        v_px = v_px * -1
    end
    v_py = py

    shoot_projectile_from_projectile( host, proj_file, px, py, v_px, v_py)

    arc = arc + ( 360 / count )
end