dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/sunbook_pages.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local gusgui = dofile_once("mods/tales_of_kupoli/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_brilliance = 0
local comp_brilliance_max = 0
local p_brilliance = 0
local p_brilliance_max = 0
local soulscount = 0

local sunbook_page = 1
local sunbook_prevbutton_shown = false
local sunbook_nextbutton_shown = false
local sunbook_page_scalemult = 1
Gui.state.souls = {}
Gui.state.sunbook_open = true;
Gui.state.sunbook_unlocked = false;
function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        soulscount = GetSoulsCount("all")
        Gui.state.soulscount = soulscount

        unlocked_sbp = sunbookpages
        for i,v in ipairs(rosettas) do
            if GameHasFlagRun(v.name) then
                if table.contains(unlocked_sbp, v) == false then
                    table.insert(unlocked_sbp, v)
                end
            end
        end
        for i,v in ipairs(traces) do
            if GameHasFlagRun(v.name) then
                if table.contains(unlocked_sbp, v) == false then
                    table.insert(unlocked_sbp, v)
                end
            end
        end

        Gui.state.soultypes = soul_types
    end


    for _, value in ipairs(soul_types) do
        Gui.state.souls[value] = GetSoulsCount(value)
    end


    Gui.state.sunbook_prev_visible = (unlocked_sbp[sunbook_page - 1] ~= nil)
    Gui.state.sunbook_next_visible = (unlocked_sbp[sunbook_page + 1] ~= nil)
    Gui.state.sunbook_unlocked = not GameHasFlagRun("talesofkupoli_sunbook_unlocked")
    Gui.state.sunbook_page_src = unlocked_sbp[sunbook_page].page
    Gui.state.sunbook_page_scaleX = unlocked_sbp[sunbook_page].scaleX * sunbook_page_scalemult
    Gui.state.sunbook_page_scaleY = unlocked_sbp[sunbook_page].scaleY * sunbook_page_scalemult
end

function OnWorldPostUpdate()
    if EntityGetWithTag("player_unit")[1] ~= nil then
        Gui:Render()
    end
end

Gui:AddElement(gusgui.Elements.HLayout({
    id = "gui",
    margin = { top = 5, left = 50, },
    overrideZ = 10,
    children = {
        
    }
}))

Gui:AddElement(gusgui.Elements.HLayout({
    id = "moldosgui",
    margin = { right = 1, bottom = 1, },
    overrideZ  = 100000000,
    hidden = false,
    children = {
        gusgui.Elements.Text({
            id = "SoulsCountText",
            overrideZ = 12,
            value = "${soulscount} souls",
            padding = 1,
            drawBorder = false,
            drawBackground = false,
        }),
        gusgui.Elements.HLayoutForEach({
            id = "soulsgui",
            type = "foreach",
            stateVal = "soultypes",
            hidden = false,
            calculateEveryNFrames = -1,
            func = function(v)
                return gusgui.Elements.VLayout({
                    children = {
                        gusgui.Elements.Image({
                            src = "mods/tales_of_kupoli/files/entities/souls/sprites/soul_" .. v .. ".png",
                            scaleX = 0.75,
                            scaleY = 0.75,
                        }),
                        gusgui.Elements.Text({
                            value = Gui:StateValue("souls/" .. v),
                            margin = { left = 1, },
                        }),
                    }
                })
            end,
        }),
        gusgui.Elements.ImageButton({ -- open and close button
            id = "sunbook_openandclosebutton",
            src = "mods/tales_of_kupoli/files/sunbook/button_open.png",
            margin = { bottom = 1, },
            hidden = Gui:StateValue("sunbook_unlocked"),
            overrideZ  = 100000000,
            onClick = function()
                Gui.state.sunbook_open = not Gui.state.sunbook_open
            end,
        }),
    },
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "sunbook",
    horizontalAlign = 0.5,
    verticalAlign = 0.5,
    overrideWidth = Gui:ScreenWidth(),
    overrideHeight = Gui:ScreenHeight(),
    overrideZ  = 100000000,
    hidden = Gui:StateValue("sunbook_open"),
    children = {
        gusgui.Elements.VLayout({ -- actual book park
            id = "sunbook_book",
            horizontalAlign = 0.5,
            verticalAlign = 0.5,
            hidden = false,
            children = {
                gusgui.Elements.Image({ -- pages
                    id = "sunbookpage",
                    src = Gui:StateValue("sunbook_page_src"),
                    scaleX = Gui:StateValue("sunbook_page_scaleX"),
                    scaleY = Gui:StateValue("sunbook_page_scaleY")
                }),
                gusgui.Elements.HLayout({ -- prev and next buttons
                    id = "sunbook_buttons",
                    children = {
                        gusgui.Elements.ImageButton({ -- prev button
                            id = "sunbook_button_prev",
                            src = "mods/tales_of_kupoli/files/sunbook/button_prev.png",
                            visible = Gui:StateValue("sunbook_prev_visible"),
                            onClick = function(element)
                                sunbook_page = sunbook_page - 1
                            end,
                        }),
                        gusgui.Elements.Image({
                            id = "sunbook_button_spacing",
                            src = "mods/tales_of_kupoli/files/sunbook/button_space1.png",
                        }),
                        gusgui.Elements.ImageButton({ -- next button
                            id = "sunbook_button_next",
                            margin = { right = 1, },
                            src = "mods/tales_of_kupoli/files/sunbook/button_next.png",
                            visible = Gui:StateValue("sunbook_next_visible"),
                            onClick = function(element)
                                sunbook_page = sunbook_page + 1
                            end,
                        }),
                    },
                }),
            },
        })
    },
}))