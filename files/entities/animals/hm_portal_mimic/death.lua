dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

	--[[local portals = EntityGetInRadiusWithTag(x, y, 50, "hm_portal")
	for i,portal in ipairs(portals) do
		local comps EntityGetAllComponents(portal)
		for i,v in ipairs(comps) do
			EntitySetComponentIsEnabled(portal, v, true)
		end
	end]]

	--[[localportal = EntityLoad("data/entities/buildings/teleport_liquid_powered.xml", x, y)
	EntityRemoveTag(portal, "can_spawn_mimic")
	EntityRemoveComponent(portal, EntityGetFirstComponentIncludingDisabled(portal, "LuaComponent", "mimicspawner") or 0)]]
	--EntityLoad("mods/tales_of_kupoli/files/entities/animals/portal_nochance.xml", x, y)
	local whattodrop = {
		"data/entities/items/pickup/spell_refresh.xml",
		"data/entities/items/pickup/heart_fullhp_temple.xml",
		--"data/entities/items/pickup/wandstone.xml",
		"data/entities/items/wand_unshuffle_06.xml",
		"data/entities/animals/fish.xml",
		"data/entities/items/pickup/goldnugget_10000.xml",
	}
	
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )

	local whichone = whattodrop[math.random(1,#whattodrop)]
	EntityLoad(whichone, x, y)
end