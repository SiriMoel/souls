dofile( "data/scripts/game_helpers.lua" )
dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup( entity_item, entity_who_picked, name )
	local x, y = EntityGetTransform( entity_item )
	EntityLoad("data/entities/particles/image_emitters/spell_refresh_effect.xml", x, y-12)
	GamePrintImportant("PICKUPED UP SOUL REFRESHER", "All spells refreshed and souls acquired", "mods/souls/files/souls_decoration.png")
	GameRegenItemActionsInPlayer( entity_who_picked )
	local count = GetSoulsCount("all")
	count = math.ceil(count * 0.2) + 5
	if count > 100 then
		count = 100
	end
	for i=1,count do
		local soul = GetRandomSoulType(false)
		AddSouls(soul, 1)
	end
	EntityKill( entity_item )
end
