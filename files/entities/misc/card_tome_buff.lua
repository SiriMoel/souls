dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_buff") or 0
local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    ca = ca + 1
    if ca > 3 then
        ca = 1
    end
    if ca == 1 then
        GamePrint("Buffing with BESERK")
    end
    if ca == 2 then
        GamePrint("Buffing with AGILITY")
    end
    if ca == 3 then
        GamePrint("Buffing with MANA REGENERATION")
    end
    ComponentSetValue2(comp_ca, "value_string", tostring(ca))
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end