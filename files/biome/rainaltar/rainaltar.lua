dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
--dofile( "data/scripts/items/generate_shop_item.lua" )

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

local targets = EntityGetInRadiusWithTag(x, y, 50, "kupoli_cloud")

function generate_shop_item( x, y ) -- stolen from generate_shop_item.lua

	local item = "KUPOLI_WORM_ENHANCER"
	local cardcost = 500000

	local eid = CreateItemActionEntity( item, x, y )
	
	local offsetx = 6
	local text = tostring(cardcost)
	local textwidth = 0
	
	for i=1,#text do
		local l = string.sub( text, i, i )
		
		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	
	offsetx = textwidth * 0.5 - 0.5

	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml",
		is_text_sprite="1", 
		offset_x=tostring(offsetx), 
		offset_y="25", 
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(cardcost),
		z_index="-1",
		} )

	local stealable_value = "0"
	
	EntityAddComponent( eid, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world", 
		cost=cardcost,
		stealable=stealable_value
		} )
		
	EntityAddComponent( eid, "LuaComponent", { 
		script_item_picked_up="data/scripts/items/shop_effect.lua",
		} )
end

if #targets >= 1 then
    if not EntityHasTag(altar, "kupoli_secret_done") then
        generate_shop_item(x, y)
        local e = EntityLoad("mods/souls/files/biome/rainaltar/emitter.xml", x, y)
    	EntityAddChild(entity_id, e)
        EntityAddTag(altar, "kupoli_secret_done")
    end
end