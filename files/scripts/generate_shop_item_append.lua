dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local generate_shop_item_old = generate_shop_item

function generate_shop_item( x, y, cheap_item, biomeid_, is_stealable )
    local frame = GameGetFrameNum()
    SetRandomSeed(x + frame, y)
    if tobool(GlobalsGetValue("souls.enable_soul_shops", "true")) then
        if Random(1, 6) == 1 then
            GenerateSoulShopItem(x, y, biomeid_)
        else
            generate_shop_item_old(x, y, cheap_item, biomeid_, is_stealable)
        end
    else
        generate_shop_item_old(x, y, cheap_item, biomeid_, is_stealable)
    end
end