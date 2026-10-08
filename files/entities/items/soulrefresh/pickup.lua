dofile("data/scripts/game_helpers.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup(entity_item, entity_who_picked, name)
	if not EntityHasTag(entity_who_picked, "player_unit") then return end
	local x, y = EntityGetTransform(entity_item)
	SetRandomSeed(x, y + entity_item)
	EntityLoad("data/entities/particles/image_emitters/spell_refresh_effect.xml", x, y-12)
	SoulsPrintImportant("PICKED UP SOUL REFRESHER", "All spells refreshed and some souls acquired")
	GameRegenItemActionsInPlayer(entity_who_picked)
	local count = SoulCount("total_boss", entity_who_picked)
	count = math.ceil(count * 0.2) + 5
	if count > 100 then
		count = 100
	end
	local souls = {}
    for i = 1, count do
        local which = soul_types[Random(1, #soul_types - 2)]
        souls[which] = (souls[which] or 0) + 1
    end
    EditSoulCounts(souls, entity_who_picked)
	EntityKill(entity_item)
end
