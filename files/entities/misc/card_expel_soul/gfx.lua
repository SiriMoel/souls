local entity_id = GetUpdatedEntityID()
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #spcs do
	local sprite = ComponentGetValue2(spcs[i], "image_file")
	if sprite == "data/ui_gfx/inventory/item_bg_projectile.png" then
		ComponentSetValue2(spcs[i], "image_file", "mods/souls/files/entities/misc/card_expel_soul/bg.png")
		break
	end
end