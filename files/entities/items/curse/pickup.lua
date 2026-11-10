dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup(item, picker, item_name)
	local x, y = EntityGetTransform(item)

	local curse = EntityLoad("mods/souls/files/entities/items/curse/curse_entity.xml", x, y)
	EntityAddChild(picker, curse)

	GameAddFlagRun("souls_cursed")
	AddFlagPersistent("souls_curse_picked")

	-- vfx/sfx

	SoulsPrintImportant("YOU ARE CURSED!", "This is very scary...")

	EntityKill(item)
end