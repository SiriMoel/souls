dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

-- thankyou kmccord1 <3
 
local soulscount = 0
local phylactery_points = 0
local souls = {}
 
function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        soulscount = GetSoulsCount("all")
        phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0")) or 0
 
        souls = {}
        for _, value in ipairs(soul_types) do
            souls[value] = GetSoulsCount(value)
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
 
    -- Souls and Phylactery points display
    GuiLayoutBeginHorizontal(gui, 65, 91)
        GuiText(gui, 0, 0, "Souls: " .. soulscount)
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
                if christmas then
                    GuiZSetForNextWidget(gui, 99998)
                    GuiImage(gui, gui_id, 0, 0, "mods/souls/files/soul_santa_hat.png", 1, 0.75, 0.75)
                    GuiZSetForNextWidget(gui, 99999)
                    GuiImage(gui, gui_id, 0, -5, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                else
                    GuiImage(gui, gui_id, 0, 0, "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png", 1, 0.75, 0.75)
                end
                GuiText(gui, 0, 0, tostring(math.min(souls[soul], 99)) .. " ")
            GuiLayoutEnd(gui)
        end
    GuiLayoutEnd(gui)
 
    GuiDestroy(gui)
end