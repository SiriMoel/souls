dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

local range = 800
local indicator_distance = 20

for _,sun_id in pairs(EntityGetInRadiusWithTag( pos_x, pos_y, range, "sun")) do
	local sun_x, sun_y = EntityGetFirstHitboxCenter(sun_id)
	local dir_x = sun_x - pos_x
	local dir_y = sun_y - pos_y
	local distance = get_magnitude(dir_x, dir_y)

	local indicator_x = 0
	local indicator_y = 0

	if is_in_camera_bounds(sun_x, sun_y, -4) then
		indicator_x = sun_x
		indicator_y = sun_y - 3
	else
		-- position radar indicators around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		indicator_x = pos_x + dir_x * indicator_distance
		indicator_y = pos_y + dir_y * indicator_distance
	end

	-- display sprite based on proximity
	if distance > range * 0.8 then
		GameCreateSpriteForXFrames( "mods/moles_n_more/files/particles/radar_sun_faint.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	elseif distance > range * 0.5 then
		GameCreateSpriteForXFrames( "mods/moles_n_more/files/particles/radar_sun_medium.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	else
		GameCreateSpriteForXFrames( "mods/moles_n_more/files/particles/radar_sun_strong.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	end
end