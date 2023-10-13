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
local sunbook_open = false
local sunbook_prevbutton_shown = false
local sunbook_nextbutton_shown = false
local sunbook_page_scalemult = 1

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then 
        comp_brilliance = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_stored") or 0
        comp_brilliance_max = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0
        p_brilliance = ComponentGetValue2(comp_brilliance, "value_int")
        p_brilliance_max = ComponentGetValue2(comp_brilliance_max, "value_int")
        Gui.state.bbar = (p_brilliance / p_brilliance_max) * 100
        Gui.state.brilliance = p_brilliance
        soulscount = GetSoulsCount("all")
        Gui.state.soulscount = soulscount
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
        --[[gusgui.Elements.ProgressBar({
            id = "BrillianceBar",
            width = 100,
            height = 10,
            overrideZ = 11,
            barColour = "white",
            --customBarColourPath = "mods/tales_of_kupoli/files/sunbook/brilliancebarcolour.png",
            value = Gui:StateValue("bbar"),
        }),
        gusgui.Elements.Text({
            id = "BrillianceText",
            overrideZ = 12,
            margin = { left = 1, top = -1, },
            value = Gui:StateValue("brilliance"),
            padding = 1,
            drawBorder = false,
            drawBackground = false,
        }),]]--
        gusgui.Elements.Text({
            id = "SoulsCountText",
            overrideZ = 12,
            margin = { left = 1, top = -1, },
            value = "${soulscount} souls",
            padding = 1,
            drawBorder = false,
            drawBackground = false,
        }),
    }
}))

Gui:AddElement(gusgui.Elements.VLayout({
    id = "sunbook_openandclosebutton",
    margin = { right = 1, bottom = 1, },
    overrideZ  = 100000000,
    hidden = true,
    onBeforeRender = function(element)
        if GameHasFlagRun("molething_sunbook_unlocked") then
            element.config.hidden = false
        end
    end,
    children = {
        gusgui.Elements.ImageButton({ -- open and close button
            id = "sunbook_button",
            src = "mods/tales_of_kupoli/files/sunbook/button.png",
            scaleX = 1,
            scaleY = 1,
            onClick = function(element)
                sunbook_open = flipbool(sunbook_open)
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
    hidden = true,
    onBeforeRender = function(element)
        if GameHasFlagRun("molething_sunbook_unlocked") then
            element.config.hidden = false
        end
    end,
    children = {
        gusgui.Elements.VLayout({ -- actual book park
            id = "sunbook_book",
            horizontalAlign = 0.5,
            verticalAlign = 0.5,
            hidden = true,
            onBeforeRender = function(element)
                element.config.hidden = not sunbook_open
            end,
            children = {
                gusgui.Elements.Image({ -- pages
                    id = "sunbookpage",
                    src = sunbookpages[sunbook_page].page,
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
                            src = "mods/tales_of_kupoli/files/sunbook/button.png",
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
                            src = "mods/tales_of_kupoli/files/sunbook/button.png",
                            margin = { left = 138, },
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