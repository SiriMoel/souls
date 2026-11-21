dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/soul_hats.lua")
dofile_once("mods/souls/files/scripts/tome_upgrades.lua")

souls_gui = nil

function SoulsGuiUpdate()
    local player = EntityGetWithTag("player_unit") or {}
    if #player == 0 then return end
    player = player[1]

    local soul_types = GetSoulTypes()

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
        --[[if not hatted then
            if christmas then
            hat = "mods/souls/files/ui_gfx/soul_santa_hat.png"
            hatted = true
            end
        end]]
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

        for i, soul in ipairs(soul_types) do

            local x = centre_x + math.cos(inc * i) * (max_dist * open)
            local y = centre_y + math.sin(inc * i) * (max_dist * open)
            
            if GlobalsGetValue("souls.hats", "true") == "true" then
                local hatted, hat, hat_offset = soul_hat(soul)
                if hatted then
                    GuiZSetForNextWidget(souls_gui, -5)
                    GuiImage(souls_gui, get_gui_id(), x, y + hat_offset, hat, open, 1, 1) 
                end 
            end

            local anim = soul
            if animated == "true" then anim = soul .. "_a" end

            GuiZSetForNextWidget(souls_gui, -4)
            GuiImage(souls_gui, get_gui_id(), x, y, "mods/souls/files/soul_sprites/souls.xml", open, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, anim)

            local count = soulcounts[soul]
            local t = tostring(math.min(count, 9999))
            if divine then
                t = "∞ +" .. t
            end

            GuiZSetForNextWidget(souls_gui, -4)
            GuiColorSetForNextWidget(souls_gui, 1, 1, 1, open)
            GuiText(souls_gui, x + 11, y, t .. " ")
        end

        local centre_text = (GlobalsGetValue("souls.total_boss", "false") == "true" and soulcounts["total_boss"]) or soulcounts["total"]

        GuiZSetForNextWidget(souls_gui, -4)
        GuiImage(souls_gui, get_gui_id(), centre_x - 5, centre_y, "mods/souls/files/soul_sprites/souls.xml", open, 1, 1, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, (animated == "true") and "soul_a" or "soul")

        GuiZSetForNextWidget(souls_gui, -4)
        GuiColorSetForNextWidget(souls_gui, 1, 1, 1, open)
        GuiText(souls_gui, centre_x + 6, centre_y, centre_text)
    end

    -- tome upgrade gui

    GuiOptionsClear(souls_gui)
    GuiOptionsAdd(souls_gui, GUI_OPTION.NoPositionTween)
    --GuiOptionsAdd(souls_gui, GUI_OPTION.DrawFadeIn)
    local tome_gui_open = GlobalsGetValue("souls.tome_gui_open", "0")
    if tome_gui_open == "1" then
        local tome = EntityGetWithTag("soul_tome")[1]
        if tome == nil then return end

        local upgrade_width = 30 * 4
        local start_x = screen_width / 2 - upgrade_width * #tome_upgrades * 0.5
        local start_y = screen_height - 90

        for i, upgrade in ipairs(tome_upgrades) do
            local comp_upgrade_count = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "tome_upgrade_" .. i)
            local upgrade_count = ComponentGetValue2(comp_upgrade_count, "value_int") or 0
            local upgrade_cost = upgrade.func_cost(upgrade_count) 
            
            local x = start_x + upgrade_width * (i - 1)
            local y = start_y

            GuiZSetForNextWidget(souls_gui, 5)
            GuiImage(souls_gui, get_gui_id(), x, y, "mods/souls/files/ui_gfx/tome_upgrades/upgrade_bg_2.png", 1, 2, 2, 0)           

            GuiZSetForNextWidget(souls_gui, 4)
            local upgrade_button = GuiImageButton(souls_gui, get_gui_id(), x + upgrade_width * 0.5 - 20, y, "", upgrade.icon)

            local function text_outline(text, tx, ty, z)
                local dist = 1
                local pos = { -- box :)
                    {tx - dist, ty - dist}, {tx, ty - dist}, {tx + dist, ty - dist},
                    {tx - dist, ty},                                {tx + dist, ty},
                    {tx - dist, ty + dist}, {tx, ty + dist}, {tx + dist, ty + dist},
                }
                for i = 1, #pos do
                    GuiColorSetForNextWidget(souls_gui, 0.1, 0.1, 0.1, 1.0)
                    GuiZSetForNextWidget(souls_gui, z + 0.1)
                    GuiText(souls_gui, pos[i][1], pos[i][2], text)
                end
            end

            for text_i, line in ipairs(upgrade.text) do
                local text_width, text_height = GuiGetTextDimensions(souls_gui, line[1])
                local text_x = x + upgrade_width * 0.5 - text_width * 0.5
                local text_y = y - 4 - text_height * text_i

                text_outline(line[1], text_x, text_y, 4)
                if line[2] == "good" then
                    GuiColorSetForNextWidget(souls_gui, 0.5, 1.0, 0.6, 1.0)
                elseif line[2] == "bad" then
                    GuiColorSetForNextWidget(souls_gui, 1.0, 0.6, 0.6, 1.0)
                end
                GuiZSetForNextWidget(souls_gui, 4)
                GuiText(souls_gui, text_x, text_y, line[1])
            end

            local cost_text = tostring(upgrade_cost) .. " souls"
            local text_width, text_height = GuiGetTextDimensions(souls_gui, cost_text)
            local cost_text_x = x + upgrade_width * 0.5 - text_width * 0.5
            local cost_text_y = y + 48
            text_outline(cost_text, cost_text_x, cost_text_y, 3)
            GuiZSetForNextWidget(souls_gui, 3)
            if soulcounts["total"] >= upgrade_cost then
                GuiColorSetForNextWidget(souls_gui, 0.25, 0.89, 0.87, 1.0)
            else
                GuiColorSetForNextWidget(souls_gui, 0.7, 0.4, 0.55, 1.0)
            end
            GuiText(souls_gui, cost_text_x, cost_text_y, cost_text)

            if upgrade_button then
                local player_x, player_y = EntityGetTransform(player)
                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", player_x, player_y)
                if SoulCount("total", player) >= upgrade_cost then
                    if SpellUseSouls(player, upgrade_cost) then
                        upgrade.func_apply(tome)
                        ComponentSetValue2(comp_upgrade_count, "value_int", upgrade_count + 1)
                        local maxed = CheckIsTomeMaxed(tome)
                        if maxed then
                            if not GameHasFlagRun("souls_tome_maxed") then
                                GameAddFlagRun("souls_tome_maxed")
                            end
                            if not HasFlagPersistent("souls_tome_maxed") then
                                AddFlagPersistent("souls_tome_maxed")
                            end
                            GlobalsSetValue("souls.tome_gui_open", "0")
                            GlobalsSetValue("souls.tome_gui_frame", tostring(GameGetFrameNum()))
                            local upgraders = EntityGetWithTag("souls_tome_upgrade_card") or {}
                            if #upgraders > 0 then
                                for _, v in ipairs(upgraders) do
                                    EntityKill(v)
                                end
                            end
                            SoulsPrintImportant("Tome maxed!", "It cannot be upgraded any further.", "divine")
                            GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_light", player_x, player_y)
                        else
                            SoulsPrint("Tome upgraded!")
                            --SoulsPrintImportant("Tome upgraded!", "A " .. upgrade.name .. " upgrade has been applied to the tome.", "souls")
                        end
                        EntityLoad("mods/souls/files/entities/misc/soul_blood_fx.xml", player_x, player_y - 5)
                    else
                        SoulsPrint("You do not have enough souls for this. (" .. upgrade_cost .. ")")
                    end
                else
                    SoulsPrint("You do not have enough souls for this. (" .. upgrade_cost .. ")")
                end
            end
        end
    end
    GuiOptionsClear(souls_gui)

    GuiIdPop(souls_gui)
end