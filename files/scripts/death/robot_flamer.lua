dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")
dofile_once("mods/souls/files/alterants.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local x, y = EntityGetTransform( GetUpdatedEntityID() )

	SetRandomSeed(x, y)
	math.randomseed(x, y+GameGetFrameNum())

	local r = math.random(1,4)
	if r == 2 then
		EntityLoad("mods/souls/files/entities/items/robot_flamethrower/weapon.xml", x, y-20)
	end
end