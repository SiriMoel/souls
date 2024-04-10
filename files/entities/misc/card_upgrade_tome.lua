dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_cu = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_upgrade") or 0
local cu = tonumber(ComponentGetValue(comp_cu, "value_string"))

if ComponentGetValue2(comp_control, "mButtonDownRightClick") == true then
    cu = cu + 1
    if cu > 3 then
        cu = 1
    end
    if cu == 4 then
        --GamePrint("Now upgrading defensive ability!")
    elseif cu == 3 then
        GamePrint("Now upgrading cast delay!")
    elseif cu == 2 then
        GamePrint("Now upgrading recharge time!")
    elseif cu == 1 then
        GamePrint("Now upgrading capacity!")
    end
    ComponentSetValue2(comp_cu, "value_string", tostring(cu))
end