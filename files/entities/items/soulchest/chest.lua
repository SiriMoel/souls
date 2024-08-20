dofile_once("mods/souls/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local keys = EntityGetInRadiusWithTag( x, y, 8, "souls_soul_key" )

math.randomseed(x, y+tonumber(StatsGetValue("world_seed")))

if ( #keys > 0 ) then

	local pool = {
		"data/entities/items/pickup/goldnugget_200.xml",
		--"data/entities/items/pickup/goldnugget_200.xml",
		--"data/entities/items/pickup/goldnugget_200.xml",
		"data/entities/items/pickup/goldnugget_200.xml",
		"data/entities/items/pickup/goldnugget_1000.xml",
		"data/entities/items/pickup/potion.xml",
		"data/entities/items/pickup/potion_secret.xml",
		"data/entities/items/pickup/spell_refresh.xml",
		"data/entities/items/pickup/safe_haven.xml",
		"data/entities/items/pickup/moon.xml",
		"data/entities/items/pickup/thunderstone.xml",
		"data/entities/items/pickup/evil_eye.xml",
		"data/entities/items/pickup/brimstone.xml",

		"souls",
		"mods/souls/files/entities/items/amethyst_orb/item.xml",
		"mods/souls/files/entities/items/deadringer/item.xml",
	}

	local which = pool[math.random(1,#pool)]

	if which == "souls" then
		for i=1,15 do
			AddSouls(15, false)
		end
	else
		EntityLoad(which, x, y)
	end

	for i,v in ipairs(keys) do
		EntityKill(v)
	end
	EntityKill( entity_id )
end