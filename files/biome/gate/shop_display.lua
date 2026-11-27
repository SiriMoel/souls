dofile_once("mods/souls/files/scripts/souls.lua")

shop_gui = nil

local shop = GetUpdatedEntityID()
local x, y = EntityGetTransform(shop)

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
    local cam_x, cam_y = GameGetCameraPos()
    local _, _, cam_w, cam_h = GameGetCameraBounds()
    local draw_pos = {
        x = (x - (cam_x - cam_w/2)) / (cam_w),
        y = (y - (cam_y - cam_h/2)) / (cam_h),

    }
    local shop_x = screen_width * draw_pos.x
    local shop_y = screen_height * draw_pos.y

    GuiIdPushString(shop_gui, "shop_gui_" .. shop)

    local soulcounts = SoulCounts()

    local price_comps = EntityGetComponentIncludingDisabled(shop, "VariableStorageComponent", "shop_price") or {}
    if #price_comps > 0 then
        for i = 1, #price_comps do
            local comp = price_comps[i]
            local soul = ComponentGetValue2(comp, "name")
            local price = ComponentGetValue2(comp, "value_int")
            GuiImage(shop_gui, get_gui_id(), shop_x - 7, shop_y + 17 * i, "mods/souls/files/soul_sprites/souls.xml", 1, 1.5, 1.5, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, soul .. "_a")
            local price_text = "x" .. tostring(price)
            local text_x = shop_x + 9
            local text_y = shop_y + 2 + 17 * i
            text_outline(price_text, text_x, text_y, 0)
            if (soul == "soul" and soulcounts["total"] >= price) or (soulcounts[tostring(soul)] >= price) then
                GuiColorSetForNextWidget(shop_gui, 0.25, 0.89, 0.87, 1.0)
            else
                GuiColorSetForNextWidget(shop_gui, 0.7, 0.4, 0.55, 1.0)
            end
            GuiText(shop_gui, text_x, text_y, price_text)
        end
    end
       
    GuiIdPop(shop_gui)
end

local targets = EntityGetInRadiusWithTag(x, y, 14, "player_unit") or {}
if #targets > 0 then
    ShopGuiUpdate()
else
    GuiDestroy(shop_gui)
end