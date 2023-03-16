dofile_once("mods/moles_n_more/files/scripts/utils.lua")
dofile_once("mods/moles_n_more/files/scripts/sunbook_pages.lua")

local gusgui = dofile_once("mods/moles_n_more/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_brilliance = 0
local comp_brilliance_max = 0
local p_brilliance = 0
local p_brilliance_max = 0

local sunbook_page = 1
local sunbook_open = false
local sunbook_prevbutton_shown = false
local sunbook_nextbutton_shown = false
local sunbook_page_scalemult = 2

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then 
        comp_brilliance = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_stored") or 0
        comp_brilliance_max = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0
        p_brilliance = ComponentGetValue2(comp_brilliance, "value_int")
        p_brilliance_max = ComponentGetValue2(comp_brilliance_max, "value_int")
        Gui.state.bbar = (p_brilliance / p_brilliance_max) * 100
        Gui.state.brilliance = p_brilliance
    end
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
        gusgui.Elements.ProgressBar({
            id = "BrillianceBar",
            width = 25,
            height = 5,
            overrideZ = 11,
            barColour = "yellow",
            value = Gui:StateValue("bbar"),
        }),
        gusgui.Elements.Text({
            id = "BrillianceText",
            overrideZ = 12,
            margin = { left = -25, },
            value = Gui:StateValue("brilliance"),
            padding = 1,
            drawBorder = false,
            drawBackground = false,
        }),
    }
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "sunbook",
    margin = { top = 50, left = 50, },
    overrideZ  = 100000000,
    hidden = true,
    onBeforeRender = function(element)
        if GameHasFlagRun("mnm_sunbook_unlocked") then
            element.config.hidden = false
        end
    end,
    children = {
        gusgui.Elements.ImageButton({ -- open and close button
            id = "sunbook_button",
            src = "mods/moles_n_more/files/sunbook_button.png",
            scaleX = 2,
            scaleY = 2,
            onClick = function(element)
                sunbook_open = flipbool(sunbook_open)
            end,
        }),
        gusgui.Elements.VLayout({ -- actual book park
            id = "sunbook_book",
            margin = { top = 50, },
            hidden = true,
            onBeforeRender = function(element)
                element.config.hidden = not sunbook_open
            end,
            children = {
                gusgui.Elements.Image({ -- pages
                    id = "sunbookpage",
                    src = "",
                    scaleX = 1,
                    scaleY = 1,
                    onBeforeRender = function(element)
                        element.config.src = sunbookpages[sunbook_page].page
                        element.config.scaleX = sunbookpages[sunbook_page].scaleX * sunbook_page_scalemult
                        element.config.scaleY = sunbookpages[sunbook_page].scaleY * sunbook_page_scalemult
                    end,
                }),
                gusgui.Elements.HLayout({ -- prev and next buttons
                    id = "sunbook_buttons",
                    children = {
                        gusgui.Elements.ImageButton({ -- prev button
                            id = "sunbook_button_prev",
                            src = "mods/moles_n_more/files/sunbook_button.png",
                            scaleX = 1,
                            scaleY = 1,
                            hidden = true,
                            onBeforeRender = function(element)
                                if sunbookpages[sunbook_page - 1] ~= nil then
                                    element.config.hidden = false
                                else
                                    element.config.hidden = true
                                end
                            end,
                            onClick = function(element)
                                sunbook_page = sunbook_page - 1
                            end,
                        }),
                        gusgui.Elements.ImageButton({ -- prev button
                            id = "sunbook_button_next",
                            src = "mods/moles_n_more/files/sunbook_button.png",
                            scaleX = 1,
                            scaleY = 1,
                            hidden = true,
                            onBeforeRender = function(element)
                                if sunbookpages[sunbook_page + 1] ~= nil then
                                    element.config.hidden = false
                                else
                                    element.config.hidden = true
                                end
                            end,
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