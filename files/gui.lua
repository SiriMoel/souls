dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

-- thankyou kmccord1 <3
 
local soulscount = 0
local hasinfsouls = false
local phylactery_points = 0
local soulcounts = {}
local soul_emulator_image = "mods/souls/files/gui/soul_emulator/0.png"
 
function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        soulscount, hasinfsouls = GetSoulsCount("all")
        phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0")) or 0
 
        soulcounts = {}
        for _, value in ipairs(soul_types) do
            soulcounts[value] = GetSoulsCount(value)
        end

        if GameHasFlagRun("souls_soul_emulated") then
            soul_emulator_image = "mods/souls/files/gui/soul_emulator/" .. GlobalsGetValue("souls.soul_emulator_state", "1") .. ".png"
        end

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

    -- Soul Emulator stuff
    if GameHasFlagRun("souls_soul_emulated") then
        GuiLayoutBeginHorizontal(gui, 65, 82.5)
            GuiImage(gui, gui_id, 0, 0, soul_emulator_image, 1, 1, 1)
        GuiLayoutEnd(gui)
    end

    -- Souls and Phylactery points display
    GuiLayoutBeginHorizontal(gui, 65, 91)
        if hasinfsouls then
            GuiText(gui, 0, 0, "Souls: ∞ + " .. soulscount)
        else
            GuiText(gui, 0, 0, "Souls: " .. soulscount)
        end
        if GameHasFlagRun("souls_phylactery_done") then
            GuiText(gui, 0, 0, "Phylactery: " .. phylactery_points)
        end
    GuiLayoutEnd(gui)

    local year, month, day = GameGetDateAndTimeLocal()
    local christmas = false
    if month == 12 and day <= 25 then
        christmas = true
    end

    -- Render soul icons and their counts
    GuiLayoutBeginHorizontal(gui, 65, 94)
        for _, soul in ipairs(soul_types) do
            GuiLayoutBeginVertical(gui, 0, 0)
                if HasFlagPersistent("souls_sotd_quest_done") and soul == "boss" then
                    GuiZSetForNextWidget(gui, 99998)
                    GuiImage(gui, gui_id, 0, -2.5, "mods/souls/files/gui/soul_crown.png", 1, 0.75, 0.75)
                    GuiZSetForNextWidget(gui, 99999)
                    GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                elseif christmas then
                    GuiZSetForNextWidget(gui, 99998)
                    GuiImage(gui, gui_id, 0, -2.5, "mods/souls/files/gui/soul_santa_hat.png", 1, 0.75, 0.75)
                    GuiZSetForNextWidget(gui, 99999)
                    GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                else
                    GuiImage(gui, gui_id, 0, 0, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                end
                local count, inf = GetSoulsCount(soul) --tostring(math.min(soulcounts[soul], 99))
                local t = tostring(math.min(count, 99))
                if inf then
                    t = "∞"
                end
                GuiText(gui, 0, 0, t .. " ")
            GuiLayoutEnd(gui)
        end
    GuiLayoutEnd(gui)

    -- Press down to view full soul counts
    local player = GetPlayer()
    local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
    if comp_controls ~= nil and tobool(GlobalsGetValue("souls.button_down_gui", "true")) then
        if ComponentGetValue2(comp_controls, "mButtonDownDown") then
            local frame = tonumber(GlobalsGetValue("souls.button_down_down", "0"))
            frame = frame + 1
            GlobalsSetValue("souls.button_down_down", tostring(frame))
            local centre_x, centre_y = screen_width / 2, screen_height / 2
            local inc = (math.pi * 2) / #soul_types
            for i,soul in ipairs(soul_types) do
                xx = centre_x + math.cos(inc * i) * (70 * (math.min(frame, 20) / 20))
                yy = centre_y + math.sin(inc * i) * (70 * (math.min(frame, 20) / 20))
                GuiImage(gui, gui_id, xx, yy, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                local count, inf = GetSoulsCount(soul) --tostring(math.min(soulcounts[soul], 99))
                local t = tostring(math.min(count, 9999))
                if inf then
                    t = "∞"
                end
                GuiText(gui, xx + 8, yy, t .. " ")
            end
        else
            GlobalsSetValue("souls.button_down_down", "0")
        end
    end
 
    GuiDestroy(gui)
end