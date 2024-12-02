dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

local range = 400
local indicator_distance = 20

if #EntityGetAllChildren(entity_id, "tome_magic_robot_page") > 0 then
	range = range * 2
	indicator_distance = indicator_distance * 2
end

-- ping nearby enemies
for _,enemy_id in pairs(EntityGetInRadiusWithTag( pos_x, pos_y, range, "reap_marked")) do
	local enemy_x, enemy_y = EntityGetFirstHitboxCenter(enemy_id)
	local dir_x = enemy_x - pos_x
	local dir_y = enemy_y - pos_y
	local distance = get_magnitude(dir_x, dir_y)

	local indicator_x = 0
	local indicator_y = 0

	if is_in_camera_bounds(enemy_x, enemy_y, -4) then
		indicator_x = enemy_x
		indicator_y = enemy_y - 3
	else
		-- position radar indicators around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		indicator_x = pos_x + dir_x * indicator_distance
		indicator_y = pos_y + dir_y * indicator_distance
	end

	-- display sprite based on proximity
	if distance > range * 0.8 then
		GameCreateSpriteForXFrames( "mods/souls/files/entities/items/tome/radar_faint.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	elseif distance > range * 0.5 then
		GameCreateSpriteForXFrames( "mods/souls/files/entities/items/tome/radar_medium.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	else
		GameCreateSpriteForXFrames( "mods/souls/files/entities/items/tome/radar_strong.png", indicator_x, indicator_y, true, 0, 0, 1, true )
	end
end
