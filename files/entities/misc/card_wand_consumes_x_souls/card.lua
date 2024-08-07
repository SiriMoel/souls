dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    local player = GetPlayer()
    local wand = HeldItem(player)

    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type")
    if comp_whichsoul == nil then
        comp_whichsoul = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type",
            name="which_soul_type",
            value_string="0",
        })
    end
    local comp_whichsoulnumber = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type_number")
    if comp_whichsoulnumber == nil then
        comp_whichsoulnumber = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type_number",
            name="which_soul_type_number",
            value_int="1",
        })
    end
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    local whichsoul_number = ComponentGetValue2(comp_whichsoulnumber, "value_int")

    if whichsoul == "0" then
        whichsoul = "bat"
    else
        whichsoul_number = whichsoul_number + 1
        whichsoul = soul_types[whichsoul_number]
        if whichsoul == nil then
            whichsoul = "0"
            whichsoul_number = 0
        end
    end

    ComponentSetValue2(comp_whichsoul, "value_string", whichsoul)
    ComponentSetValue2(comp_whichsoulnumber, "value_int", whichsoul_number)
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
    GamePrint("Now consuming " .. SoulNameCheck(whichsoul) .. " souls on this wand.")
end