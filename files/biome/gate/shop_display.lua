dofile_once("mods/souls/files/scripts/souls.lua")

shop_gui = nil

local shop = GetUpdatedEntityID()
local x, y = EntityGetTransform(shop)
local targets = EntityGetInRadiusWithTag(x, y, 14, "player_unit") or {}
if #targets > 0 then
    ShopGuiUpdate()
else
    GuiDestroy(shop_gui)
end

local function text_outline(text, tx, ty, z)
    local dist = 1
    local pos = { -- box :)
        {tx - dist, ty - dist}, {tx, ty - dist}, {tx + dist, ty - dist},
        {tx - dist, ty},                                {tx + dist, ty},
        {tx - dist, ty + dist}, {tx, ty + dist}, {tx + dist, ty + dist},
    }
    for i = 1, #pos do
        GuiColorSetForNextWidget(shop_gui, 0.1, 0.1, 0.1, 1.0)
        GuiZSetForNextWidget(shop_gui, z + 0.1)
        GuiText(shop_gui, pos[i][1], pos[i][2], text)
    end
end

function ShopGuiUpdate()
    shop_gui = shop_gui or GuiCreate()

    GuiStartFrame(shop_gui)

    local gui_id = 0
    local function get_gui_id()
        gui_id = gui_id + 1
        return gui_id
    end

    local screen_width, screen_height = GuiGetScreenDimensions(shop_gui)
    --local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
    local uv = {
        x = 0.5,--(x - cam_x) / cam_w,
        y = 0.5,--/9y - cam_y) / cam_h,
    }
    local shop_x = screen_width * uv.x
    local shop_y = screen_height * uv.y

    GuiIdPushString(shop_gui, "shop_gui_" .. shop)

    local price_comps = EntityGetComponentIncludingDisabled(shop, "VariableStorageComponent", "shop_price") or {}
    if #price_comps > 0 then
        for i = 1, #price_comps do
            local comp = price_comps[i]
            local soul = ComponentGetValue2(comp, "name")
            local price = ComponentGetValue2(comp, "value_int")
            GuiImage(shop_gui, get_gui_id(), shop_x - 7, shop_y - 17 * i, "mods/souls/files/soul_sprites/souls.xml", 1, 1.5, 1.5, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, soul)
            local price_text = "x" .. tostring(price)
            local text_x = shop_x + 9
            local text_y = shop_y + 2 - 17 * i
            text_outline(price_text, text_x, text_y, 0)
            GuiText(shop_gui, text_x, text_y, price_text)
        end
    end
       
    GuiIdPop(shop_gui)
end