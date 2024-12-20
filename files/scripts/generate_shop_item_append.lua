dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local generate_shop_item_old = generate_shop_item

function generate_shop_item( x, y, cheap_item, biomeid_, is_stealable )
    local frame = GameGetFrameNum()
    math.randomseed(x + frame, y + frame)
    if tobool(GlobalsGetValue("souls.enable_soul_shops", "true")) then
        if math.random(1, 4) == 1 then
            GenerateSoulShopItem(x, y, biomeid_)
        else
            generate_shop_item_old(x, y, cheap_item, biomeid_, is_stealable)
        end
    else
        generate_shop_item_old(x, y, cheap_item, biomeid_, is_stealable)
    end
end