dofile_once("mods/souls/files/scripts/souls.lua")

soul_hats = {
    boss = {
        func = function()
            return HasFlagPersistent("souls_sotd_quest_done")
        end,
        hat = "mods/souls/files/ui_gfx/soul_crown.png",
        offset = -3,
    },
    mage = {
        func = function()
            return HasFlagPersistent("souls_phylactery_activated")
        end,
        hat = "mods/souls/files/ui_gfx/soul_wizard_hat.png",
        offset = -6,
    },
    friendly = {
        func = function()
            return HasFlagPersistent("souls_tome_maxed")
        end,
        hat = "mods/souls/files/ui_gfx/soul_book.png",
        offset = 4,
    },
}

-- thankyou kmccord1 (I think you originally wrote the gui to not use a slow library?)

gui_id = 1 -- ???
 
--local soulscount = 0
local hasinfsouls = false
local soulcounts = {}

local divine = false
 
function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        soulcounts = SoulCounts(player)
        --soulscount = soulcounts["total"]
        divine = EntityHasTag(caster, "souls_divine")
    end
end
 
function OnWorldPostUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        GuiRender()
    end
end

function GuiRender()
    local gui = GuiCreate()
    
    GuiStartFrame(gui)
    
    local screen_width, screen_height = GuiGetScreenDimensions(gui)

    if GlobalsGetValue("souls.first_gui", "true") == "true" then

        -- Souls display
        GuiLayoutBeginHorizontal(gui, 65, 91)
            --[[if hasinfsouls then
                GuiText(gui, 0, 0, "Souls: ∞ + " .. soulscount)
            else
                GuiText(gui, 0, 0, "Souls: " .. soulscount)
            end]]
            local total_str = (GlobalsGetValue("souls.total_boss", "false") == "true" and soulcounts["total_boss"]) or soulcounts["total"]
            GuiText(gui, 0, -6, "Souls: " .. total_str)
        GuiLayoutEnd(gui)

        local year, month, day = GameGetDateAndTimeLocal()
        local christmas = false
        if (month == 12) and (day >= 24) and (day <= 26) then
            christmas = true
        end

        -- Render soul icons and their counts
        GuiLayoutBeginHorizontal(gui, 65, 94)
            for _, soul in ipairs(soul_types) do
                GuiLayoutBeginVertical(gui, 0, 0)
                    --[[local hatted = false
                    local hat
                    local hat_offset = -3
                    if soul_hats[soul] ~= nil then
                        if soul_hats[soul].func() then
                            hat = soul_hats[soul].hat
                            hat_offset = soul_hats[soul].offset
                            hatted = true
                        end
                    end
                    if not hatted then
                        if christmas then
                            hat = "mods/souls/files/ui_gfx/soul_santa_hat.png"
                            hatted = true
                        end
                    end
                    if hatted then
                        GuiZSetForNextWidget(gui, 99998)
                        GuiImage(gui, gui_id, 0, -hat_offset, hat, 1, 0.75, 0.75) 
                        GuiZSetForNextWidget(gui, 99999)
                        GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                    else
                        GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                    end]]
                    GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                    local count, inf = soulcounts[soul], false
                    local t = tostring(math.min(count, 99))
                    if inf then
                        t = "∞"
                    end
                    GuiText(gui, 0, 0, t .. " ")
                GuiLayoutEnd(gui)
            end
        GuiLayoutEnd(gui)

    end

    -- Press down to view full soul counts
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
        local centre_x, centre_y = screen_width / 2, screen_height / 2
        local inc = (math.pi * 2) / #soul_types
        for i,soul in ipairs(soul_types) do
            local xx = centre_x + math.cos(inc * i) * (max_dist * (frame / frame_max))
            local yy = centre_y + math.sin(inc * i) * (max_dist * (frame / frame_max))
            if GlobalsGetValue("souls.hats", "true") == "true" then
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
                --christmas = true
                if not hatted then
                    if christmas then
                        hat = "mods/souls/files/ui_gfx/soul_santa_hat.png"
                        hatted = true
                    end
                end
                if hatted then
                    GuiZSetForNextWidget(gui, 99998)
                    GuiImage(gui, gui_id, xx, yy + hat_offset, hat, 1, 1, 1) 
                    GuiZSetForNextWidget(gui, 99999)               
                end 
            end
            GuiImage(gui, gui_id, xx, yy, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 1, 1)
            local count = soulcounts[soul]
            local t = tostring(math.min(count, 9999))
            if divine then
                t = "∞ +" .. t
            end
            GuiText(gui, xx + 11, yy, t .. " ")
        end
        local centre_text = (GlobalsGetValue("souls.total_boss", "false") == "true" and soulcounts["total_boss"]) or soulcounts["total"]
        --local centre_text_w = GuiGetTextDimensions(gui, centre_text)
        GuiText(gui, centre_x --[[- centre_text_w * 0.5]], centre_y, centre_text)
    end

    GuiDestroy(gui)
end