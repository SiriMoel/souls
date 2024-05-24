dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 8
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local x, y = EntityGetTransform(root)

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    local targets = EntityGetWithTag("kupoli_detonator_proj")
    for i=1,#targets do
        local comp_proj = EntityGetFirstComponentIncludingDisabled(targets[i], "ProjectileComponent") or 0
        ComponentSetValue2(comp_proj, "on_lifetime_out_explode", true)
        ComponentSetValue2(comp_proj, "on_death_explode", true)
        EntityKill(targets[i])
        GamePrint("Boom!")
    end
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end

--GamePrint("hi")