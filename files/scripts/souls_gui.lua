dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/soul_hats.lua")

souls_gui = nil

function SoulsGuiUpdate()
    local player = EntityGetWithTag("player_unit") or {}
    if #player == 0 then return end
    player = player[1]

    local soulcounts = SoulCounts(player)
    local divine = EntityHasTag(player, "souls_divine")

    local year, month, day = GameGetDateAndTimeLocal()
    local christmas = false
    if (month == 12) and (day >= 24) and (day <= 26) then
        christmas = true
    end
    
    souls_gui = souls_gui or GuiCreate()

    GuiStartFrame(souls_gui)

    local gui_id = 0
    local function get_gui_id()
        gui_id = gui_id + 1
        return gui_id
    end

    local function soul_hat(soul)
        local hatted = false
        local hat
        local hat_offset = -3
        if soul_hats[soul] ~= nil then
            if soul_hats[soul].func() then
                hat = soul_hats[soul].hat
                hatted = true
                hat_offset = soul_hats[soul].offset
            end
        end
        if not hatted then
            if christmas then
            hat = "mods/souls/files/ui_gfx/soul_santa_hat.png"
            hatted = true
            end
        end
        return hatted, hat, hat_offset
    end

    local screen_width, screen_height = GuiGetScreenDimensions(souls_gui)

    GuiIdPushString(souls_gui, "souls_gui")

    -- legacy gui

    if GlobalsGetValue("souls.first_gui", "true") == "true" then
        local animated = GlobalsGetValue("souls.animated_souls", "true")

        local width_each = 14

        local start_x = screen_width - width_each * (#soul_types + 1)
        local start_y = screen_height - 25

        local total_str = (GlobalsGetValue("souls.total_boss", "false") == "true" and soulcounts["total_boss"]) or soulcounts["total"]
        if divine then
            total_str = "∞ +" .. total_str
        end
        GuiText(souls_gui, start_x, start_y - 12, "Souls: " .. total_str)

        for i = 0, #soul_types - 1 do
            local soul = soul_types[i + 1]

            if GlobalsGetValue("souls.hats", "true") == "true" then
                local hatted, hat, hat_offset = soul_hat(soul)
                if hatted then
                    GuiZSetForNextWidget(souls_gui, -1)
                    GuiImage(souls_gui, get_gui_id(), start_x + width_each * i, start_y + hat_offset, hat, 1, 1, 1)
                end 
            end

            local anim = soul
            if animated == "true" then anim = soul .. "_a" end
            GuiImage(souls_gui, get_gui_id(), start_x + width_each * i, start_y, "mods/souls/files/soul_sprites/souls.xml", 1, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, anim)

            local count_text = math.min(soulcounts[soul], 99)
            local text_width = GuiGetTextDimensions(souls_gui, count_text)
            GuiText(souls_gui, start_x + i * width_each + 5 - text_width * 0.5, start_y + 14, count_text)
        end
    end

    -- circle gui
    
    local souls_key = tonumber(GlobalsGetValue("souls.souls_gui_key", "29"))
    local frame = tonumber(GlobalsGetValue("souls.button_down_down", "0"))
    local frame_max = 8
    if InputIsKeyDown(souls_key) then
        frame = math.min(frame + 1, frame_max)
    else
        frame = math.max(frame - 1, 0)
    end
    GlobalsSetValue("souls.button_down_down", tostring(frame))
    local max_dist = 80
    if frame > 0 then        
        local open = frame / frame_max

        local animated = GlobalsGetValue("souls.animated_souls", "true")

        local centre_x, centre_y = screen_width / 2, screen_height / 2
        local inc = (math.pi * 2) / #soul_types

        for i,soul in ipairs(soul_types) do

            local x = centre_x + math.cos(inc * i) * (max_dist * open)
            local y = centre_y + math.sin(inc * i) * (max_dist * open)
            
            if GlobalsGetValue("souls.hats", "true") == "true" then
                local hatted, hat, hat_offset = soul_hat(soul)
                if hatted then
                    GuiZSetForNextWidget(souls_gui, -1)
                    GuiImage(souls_gui, get_gui_id(), x, y + hat_offset, hat, open, 1, 1) 
                end 
            end

            local anim = soul
            if animated == "true" then anim = soul .. "_a" end

            GuiImage(souls_gui, get_gui_id(), x, y, "mods/souls/files/soul_sprites/souls.xml", open, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, anim)

            local count = soulcounts[soul]
            local t = tostring(math.min(count, 9999))
            if divine then
                t = "∞ +" .. t
            end
            
            GuiColorSetForNextWidget(souls_gui, 1, 1, 1, open)
            GuiText(souls_gui, x + 11, y, t .. " ")
        end

        local centre_text = (GlobalsGetValue("souls.total_boss", "false") == "true" and soulcounts["total_boss"]) or soulcounts["total"]

        GuiImage(souls_gui, get_gui_id(), centre_x - 5, centre_y, "mods/souls/files/soul_sprites/souls.xml", open, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, (animated == "true") and "soul_a" or "soul")

        GuiColorSetForNextWidget(souls_gui, 1, 1, 1, open)
        GuiText(souls_gui, centre_x + 6, centre_y, centre_text)
    end

    GuiIdPop(souls_gui)
end