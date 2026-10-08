dofile_once("mods/souls/files/scripts/souls.lua")

local soul_hats = {
    boss = {
        func = function()
            return HasFlagPersistent("souls_sotd_quest_done")
        end,
        hat = "mods/souls/files/gui/soul_crown.png",
    },
    mage = {
        func = function()
            return HasFlagPersistent("souls_souls_phylactery_activated")
        end,
        hat = "mods/souls/files/gui/soul_wizard_hat.png",
    },
}

-- thankyou kmccord1 (I think you originally wrote the gui to not use a slow library?)

gui_id = 1 -- ???
 
local soulscount = 0
local hasinfsouls = false
local soulcounts = {}

local divine = false
 
function OnWorldPreUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        soulcounts = SoulCounts(player)
        soulscount = soulcounts["total"]
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
            GuiText(gui, 0, 0, "Souls: " .. soulscount)
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
                    local hatted = false
                    local hat
                    if soul_hats[soul] ~= nil then
                        if soul_hats[soul].func() then
                            hat = soul_hats[soul].hat
                            hatted = true
                        end
                    end
                    if not hatted then
                        if christmas then
                            hat = "mods/souls/files/gui/soul_santa_hat.png"
                            hatted = true
                        end
                    end
                    if hatted then
                        GuiZSetForNextWidget(gui, 99998)
                        GuiImage(gui, gui_id, 0, -2.5, hat, 1, 0.75, 0.75) 
                        GuiZSetForNextWidget(gui, 99998)               
                    end 
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
    if frame > 0 then        
        local centre_x, centre_y = screen_width / 2, screen_height / 2
        local inc = (math.pi * 2) / #soul_types
        for i,soul in ipairs(soul_types) do
            local xx = centre_x + math.cos(inc * i) * (70 * (frame / frame_max))
            local yy = centre_y + math.sin(inc * i) * (70 * (frame / frame_max))
            local hatted = false
            local hat
            if soul_hats[soul] ~= nil then
                if soul_hats[soul].func() then
                    hat = soul_hats[soul].hat
                    hatted = true
                end
            end
            if not hatted then
                if christmas then
                    hat = "mods/souls/files/gui/soul_santa_hat.png"
                    hatted = true
                end
            end
            if hatted then
                GuiZSetForNextWidget(gui, 99998)
                GuiImage(gui, gui_id, xx, yy - 2.5, hat, 1, 0.75, 0.75) 
                GuiZSetForNextWidget(gui, 99998)               
            end 
            GuiImage(gui, gui_id, xx, yy, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
            local count = soulcounts[soul]
            local t = tostring(math.min(count, 9999))
            if divine then
                t = "∞ +" .. t
            end
            GuiText(gui, xx + 8, yy, t .. " ")
        end
        local centre_text = soulcounts["total_boss"]
        local centre_text_w = GuiGetTextDimensions(giu, centre_text)
        GuiText(gui, centre_x - centre_text_w * 0.5, centre_y, centre_text)
    end

    GuiDestroy(gui)
end