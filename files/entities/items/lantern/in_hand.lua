dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)
local comp_controls = EntityGetFirstComponent(root, "ControlsComponent")
if comp_controls == nil then return end

local comp_button_was_down = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "button_was_down")
local button_was_down = ComponentGetValue2(comp_button_was_down, "value_int")

local button_down = ComponentGetValue2(comp_controls, "mButtonDownThrow")
local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

local frame_now = GameGetFrameNum()

local selected_soul

local soul_counts = SoulCounts(root)
local count = #soul_types
local dist = 25

for i = 1, count do
    local soul = soul_types[i]
    if soul_counts[soul] > 0 then
        local a = (i / count) * 2 * math.pi
        local draw_x = x + math.cos(a) * dist
        local draw_y = y + math.sin(a) * dist
        local path = "mods/souls/files/entities/souls/sprites/"
        if mouse_x > draw_x - 5 and mouse_x < draw_x + 5 and mouse_y > draw_y - 5 and mouse_y < draw_y + 5 then
            path = path .. "soul_" .. soul .. ".png"
            selected_soul = soul
        else
            path = path .. "silhouettes/soul_" .. soul .. ".png"
        end
        if button_down then
            GameCreateSpriteForXFrames(path, draw_x, draw_y, true, 0, 0, 1, false)
        end
    end
end

if button_down then
    button_was_down = 0
end

if button_was_down == 1 and selected_soul ~= nil then
    local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lantern_frame")
    local frame = ComponentGetValue2(comp_frame, "value_int")
    if frame_now > frame + 18 then
        ComponentSetValue2(comp_frame, "value_int", frame_now)
        if SpellUseSpecificSouls(root, {[selected_soul]=1}) then
            local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lantern_soul")
            ComponentSetValue2(comp_soul, "value_string", selected_soul)
            EntitySetComponentsWithTagEnabled(this, "lantern_on", true)
            -- set sprites to the selected soul
            -- change the lightcomponent colour to the selected soul
            SoulsPrint("A " .. soul_names[selected_soul] .. " was consumed to fuel the lantern.")
        else
            SoulsPrint("You do not have enough " .. soul_names[selected_soul] .. " souls for this. (1)")
        end
    end
else
    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lantern_soul")
    local lantern_soul = ComponentGetValue2(comp_soul, "value_string")
    if lantern_soul ~= "" then
        EntitySetComponentsWithTagEnabled(this, "lantern_on", true) 
    end
end

if button_down then
    ComponentSetValue2(comp_button_was_down, "value_int", 1)
else
    ComponentSetValue2(comp_button_was_down, "value_int", 0)
end