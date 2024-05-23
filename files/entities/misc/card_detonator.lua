dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local x, y = EntityGetTransform(root)


if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    local targets = EntityGetWithTag("kupoli_detonator_proj")
    for i=1,#targets do
        EntityKill(targets[i])
        GamePrint("Boom!")
    end
end