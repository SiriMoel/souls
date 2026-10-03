local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)
local parent = EntityGetParent(card)

if not EntityHasTag(root, "player_unit") then return end
if not EntityHasTag(parent, "soul_tome") then return end

local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame")
local cooldown_frames = 30
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local frame_now = GameGetFrameNum()

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and frame_now >= cooldown_frame then
    ComponentSetValue2(comp_cd, "value_int", frame_now + cooldown_frames)
    local comp_char_data = EntityGetFirstComponent(root, "CharacterDataComponent")    
    if comp_char_data ~= nil then
        local x, y = EntityGetTransform(root)
        local vel_x, vel_y = ComponentGetValueVector2(comp_char_data, "mVelocity")
        local mouse_x, mouse_y = ComponentGetValueVector2(comp_controls, "mMousePosition")
        local off_x, off_y = mouse_x - x, mouse_y - y
        local force = {x = 700, y = 300}
        local len = math.sqrt((off_x ^ 2) + (off_y ^ 2))
        vel_x = vel_x + (off_x / len * force.x)
        vel_y = vel_y + (off_y / len * force.y)
        ComponentSetValue2(comp_char_data, "mVelocity", vel_x, vel_y)
    end
end