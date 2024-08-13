dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/sunbook_pages.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local gusgui = dofile_once("mods/souls/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_brilliance = 0
local comp_brilliance_max = 0
local p_brilliance = 0
local p_brilliance_max = 0
local soulscount = 0
local held_item = 0
local phylactery_points = 0

Gui.state.souls = {}
Gui.state.sunbook_open = true
Gui.state.sunbook_unlocked = false
Gui.state.tome_gui_hidden = true
Gui.state.totalsoulscount = 0

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        soulscount = GetSoulsCount("all")
        Gui.state.soulscount = soulscount

        phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0")) or 0
        Gui.state.phylacterypoints = phylactery_points

        Gui.state.soultypes = soul_types

        for _,value in ipairs(soul_types) do
            Gui.state.souls[value] = GetSoulsCount(value)
        end
    end

    Gui.state.show_phylactery_points = not GameHasFlagRun("souls_phylactery_done")
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
        --[[gusgui.Elements.Text({
            id = "SoulsCountText",
            overrideZ = 12,
            value = "${soulscount} souls",
            padding = 5,
            drawBorder = false,
            drawBackground = false,
        }),]]
        gusgui.Elements.VLayout({
            children = {
                gusgui.Elements.HLayout({
                    id = "soulstextgui",
                    children = {
                        gusgui.Elements.Text({
                            value = "Souls: ${soulscount}     ",
                        }),
                        gusgui.Elements.Text({
                            value = "Phylactery: ${phylacterypoints}",
                            hidden = Gui:StateValue("show_phylactery_points"),
                        }),
                    },
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
                                    src = "mods/souls/files/entities/souls/sprites/soul_" .. v .. ".png",
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
            },
        }),
    },
}))