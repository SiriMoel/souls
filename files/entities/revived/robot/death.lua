dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
	
	perk_spawn( x - 8, y, "MAP" )
	perk_spawn( x + 8, y, "KUPOLI_SOLAR_RADAR" )

	AddFlagPersistent( "miniboss_robot" )

	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )

	EntityLoad("mods/tales_of_kupoli/files/entities/items/revmechakolmiwand/weapon.xml", x, y)

	local spawntablet = math.random(1, 2)
	if spawntablet == 1 then
		EntityLoad( "mods/tales_of_kupoli/files/entities/revived/_tablets/robot.xml", x, y)
	end
end