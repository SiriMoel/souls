dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_cu = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_upgrade") or 0
local cu = tonumber(ComponentGetValue(comp_cu, "value_string"))

local comp_cost = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "upgrade_cost") or 0
local cost = ComponentGetValue2(comp_cost, "value_int")

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    cu = cu + 1
    if cu > 5 then
        cu = 1
    end
    if cu == 5 then
        GamePrint("Now upgrading mana charge speed! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 4 then
        GamePrint("Now upgrading mana max! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 3 then
        GamePrint("Now upgrading cast delay! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 2 then
        GamePrint("Now upgrading recharge time! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 1 then
        GamePrint("Now upgrading capacity! ".. "Upgrades cost " .. cost .. " souls.")
    end
    ComponentSetValue2(comp_cu, "value_string", tostring(cu))
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end