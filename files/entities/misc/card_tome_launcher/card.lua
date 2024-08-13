dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_sl = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "launcher_souls_loaded") or 0
local sl = tonumber(ComponentGetValue(comp_sl, "value_int"))

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    if DoesWandUseSpecificSoul(wand) then
        if GetSoulsCount(GetWandSoulType(wand)) >= 1 then
            RemoveSoul(GetWandSoulType(wand))
            sl = sl + 1
            GamePrint("Loaded soul! " .. "Current souls loaded: " .. sl)
        else
            GamePrint("You do not have enough souls for this.")
        end
    else
        if GetSoulsCount("all") >= 1 then
            RemoveRandomSouls(1)
            sl = sl + 1
            GamePrint("Loaded soul! " .. "Current souls loaded: " .. sl)
        else
            GamePrint("You do not have enough souls for this.")
        end
    end
    ComponentSetValue2(comp_sl, "value_int", sl)
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end