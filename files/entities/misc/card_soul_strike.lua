dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 15
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local x, y = EntityGetTransform(root)

local comp_soulstrike = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "soul_strike_amount") or 0
local soul_strike_amount = ComponentGetValue2(comp_soulstrike, "value_int")

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    if GetSoulsCount("all") > 0 then
        soul_strike_amount = soul_strike_amount + 1
        GamePrint("Soul consumed! Current count: " .. soul_strike_amount)
        ComponentSetValue2(comp_soulstrike, "value_int", soul_strike_amount)
        RemoveSouls(1)
    end
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end