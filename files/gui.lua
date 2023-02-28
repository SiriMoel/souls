dofile_once("mods/moles_n_more/files/scripts/utils.lua")

local gusgui = dofile_once("mods/moles_n_more/lib/gusgui/Gui.lua")
local Gui = gusgui.Create()

local comp_brilliance = 0
local comp_brilliance_max = 0
local p_brilliance = 0
local p_brilliance_max = 0

function OnWorldPreUpdate()
    if PLAYER ~= nil then 
        comp_brilliance = EntityGetFirstComponentIncludingDisabled(PLAYER, "VariableStorageComponent", "brilliance_stored") or 0
        comp_brilliance_max = EntityGetFirstComponentIncludingDisabled(PLAYER, "VariableStorageComponent", "brilliance_max") or 0
        p_brilliance = ComponentGetValue2(comp_brilliance, "value_string")
        p_brilliance_max = ComponentGetValue2(comp_brilliance_max, "value_string")
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
    margin = { top = 5, left = 200, },
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