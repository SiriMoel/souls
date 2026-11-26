dofile_once("mods/souls/files/scripts/souls.lua")

reroller_gui = nil

local reroller = GetUpdatedEntityID()

local function text_outline(text, tx, ty, z)
    local dist = 1
    local pos = { -- box :)
        {tx - dist, ty - dist}, {tx, ty - dist}, {tx + dist, ty - dist},
        {tx - dist, ty},                                {tx + dist, ty},
        {tx - dist, ty + dist}, {tx, ty + dist}, {tx + dist, ty + dist},
    }
    for i = 1, #pos do
        GuiColorSetForNextWidget(reroller_gui, 0.1, 0.1, 0.1, 1.0)
        GuiZSetForNextWidget(reroller_gui, z + 0.1)
        GuiText(reroller_gui, pos[i][1], pos[i][2], text)
    end
end

function RerollerGuiUpdate()
    reroller_gui = reroller_gui or GuiCreate()

    GuiStartFrame(reroller_gui)

    local gui_id = 0
    local function get_gui_id()
        gui_id = gui_id + 1
        return gui_id
    end

    local screen_width, screen_height = GuiGetScreenDimensions(reroller_gui)
    local pos_x = screen_width * 0.5
    local pos_y = screen_height * 0.5

    GuiIdPushString(reroller_gui, "reroller_gui_" .. reroller)

    local price_comp = EntityGetFirstComponentIncludingDisabled(reroller, "VariableStorageComponent", "reroll_price")
    if price_comp ~= nil then
        local price = ComponentGetValue2(price_comp, "value_int")
        GuiImage(reroller_gui, get_gui_id(), pos_x - 7, pos_y - 17, "mods/souls/files/soul_sprites/souls.xml", 1, 1.5, 1.5, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, "soul_a")
        local price_text = "x" .. tostring(price)
        local text_x = pos_x + 9
        local text_y = pos_y + 2 - 17
        text_outline(price_text, text_x, text_y, 0)
        GuiText(reroller_gui, text_x, text_y, price_text)
    end
       
    GuiIdPop(reroller_gui)
end

local x, y = EntityGetTransform(reroller)
local targets = EntityGetInRadiusWithTag(x, y, 14, "player_unit") or {}
if #targets > 0 then
    RerollerGuiUpdate()
else
    GuiDestroy(reroller_gui)
end