dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/tome_upgrades.lua")

local this = GetUpdatedEntityID()
local parent = EntityGetParent(this)
local root = EntityGetRootEntity(this)

if EntityHasTag(parent, "soul_tome") and EntityHasTag(root, "player_unit") then
    local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
    local comp_upgrade = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "upgrade")
    local comp_frame_cd = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_cd")
    
    if comp_controls ~= nil and comp_upgrade ~= nil and comp_frame_cd ~= nil then
        local frame_now = GameGetFrameNum()

        local selecting = false
        local selected = ComponentGetValue2(comp_upgrade, "value_int") or 1
        
        local player_x, player_y = EntityGetTransform(root)
        local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

        local comp_sprite_upgrade_cost = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent", "tome_upgrade_cost")

        local tome_gui_open = GlobalsGetValue("souls.tome_gui_open", "0")

        local frame = tonumber(GlobalsGetValue("souls.tome_gui_frame", "0"))
        local frame_now = GameGetFrameNum()

        if frame_now > frame + 10 and ComponentGetValue2(comp_controls, "mButtonDownThrow") == true then
            if tome_gui_open == "0" then
                GlobalsSetValue("souls.tome_gui_open", "1")
            else
                GlobalsSetValue("souls.tome_gui_open", "0")
            end
            GlobalsSetValue("souls.tome_gui_frame", tostring(frame_now))
        end
    end
else
    GlobalsSetValue("souls.tome_gui_open", "0")
    GlobalsSetValue("souls.tome_gui_frame", tostring(GameGetFrameNum()))
end

local comp = EntityGetFirstComponentIncludingDisabled(this, "LuaComponent", "souls_tome_upgrade_fix")
if comp == nil then -- backward compatibility!!!
    EntityAddComponent2(this, "LuaComponent", {
        _tags = "souls_tome_upgrade_fix,enabled_in_world",
		script_source_file = "mods/souls/files/entities/items/tome2/card_upgrade_in_world.lua",
		execute_every_n_frame = 1
    })
    EntityAddComponent2(this, "LuaComponent", {
        _tags = "souls_tome_upgrade_fix,enabled_in_inventory",
		script_source_file = "mods/souls/files/entities/items/tome2/card_upgrade_in_inv.lua",
		execute_every_n_frame = 1
    })
end