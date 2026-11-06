local modes = {
    {
        mode = "melee",
        icon = "mods/souls/files/entities/souls/sentinel/mode_icons/melee.png",
    },
    {
        mode = "projectile",
        icon = "mods/souls/files/entities/souls/sentinel/mode_icons/projectile.png",
    },
    {
        mode = "connect",
        icon = "mods/souls/files/entities/souls/sentinel/mode_icons/connect.png",
    },
    {
        mode = "follow",
        icon = "mods/souls/files/entities/souls/sentinel/mode_icons/follow.png",
    },
}

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 28, "player_unit") or {}
if #targets == 0 then return end

local player = targets[1]

local comp_controls = EntityGetFirstComponent(player, "ControlsComponent")
if comp_controls == nil then return end

local button_down = ComponentGetValue2(comp_controls, "mButtonDownThrow")

if button_down then
    local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

    local comp_mode = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mode")
    local current_mode = ComponentGetValue2(comp_mode, "value_string")

    local draw_dist = 20

    for i, v in ipairs(modes) do
        local a = (i - 1) * math.pi / 2
        local draw_x = x + draw_dist * math.cos(a)
        local draw_y = y + draw_dist * math.sin(a)

        GameCreateSpriteForXFrames(v.icon, draw_x, draw_y, true, 0, 0, 1, true)

        if v.mode == current_mode then
            GameCreateSpriteForXFrames("mods/souls/files/entities/souls/sentinel/mode_icons/selected.png", draw_x, draw_y, true, 0, 0, 1, true)
        end

        if mouse_x > draw_x - 8 and mouse_x < draw_x + 8 and mouse_y > draw_y - 8 and mouse_y < draw_y + 8 then
            selected = v.mode
            ComponentSetValue2(comp_mode, "value_string", v.mode)
        end
    end
end