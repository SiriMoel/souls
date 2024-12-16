local entity_id = GetUpdatedEntityID()
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #spcs do
	local sprite = ComponentGetValue2(spcs[i], "image_file")
	if sprite == "data/ui_gfx/inventory/item_bg_utility.png" then
		ComponentSetValue2(spcs[i], "image_file", "mods/souls/files/entities/misc/card_soul_battery/bg.png")
		break
	end
end