dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local parent = EntityGetParent(this)
local root = EntityGetRootEntity(this)

if EntityHasTag(parent, "soul_tome") and EntityHasTag(root, "player_unit") then
    local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
    local comp_frame_open = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_open")
    local comp_upgrade = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "upgrade")
    local comp_frame_cd = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_cd")
    --[[
        stats that can be upgraded:
            mana_max
            mana_charge_speed
            reload_time
            fire_rate_wait
            deck_capacity

        1) ???
            +mana_max
            +reload_time
        
        2) ???
            +mana_charge_speed
            -reload_time
            -fire_rate_wait

        3) ???
            +deck_capacity
            -mana_max
            +fire_rate_wait
    ]]
    if comp_controls ~= nil and comp_frame_open ~= nil and comp_upgrade ~= nil and comp_frame_cd ~= nil then
        local frame_now = GameGetFrameNum()
        local frame_open = ComponentGetValue2(comp_frame_open, "value_int")

        local selecting = false
        local selected = 1

        local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

        -- check whether the options would be hovered

        if ComponentGetValue2(comp_controls, "mButtonDownThrow") == true then

            -- draw the options

            ComponentSetValue2(comp_frame_open, "value_int", frame_open)
        elseif frame_open >= frame_now - 1 then
            -- set selected option
            if selecting then
                ComponentSetValue2(comp_upgrade, "value_int", selected)
            end
        end

        if ComponentGetValue2(comp_controls, "mButtonDownFire") == true then
            local frame_cd = ComponentGetValue2(comp_frame_cd, "value_int")
            if frame_cd < frame_now - 24 then
                GamePrint("Upgraded!")
                ComponentSetValue2(comp_frame_cd, "value_int", frame_now)
            end
        end
    end
end

--[[local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local tome = EntityGetWithTag("soul_tome")[1]
local comp_cu = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_upgrade") or 0
local cu = tonumber(ComponentGetValue(comp_cu, "value_string"))

local comp_cost = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "upgrade_cost") or 0
local cost = ComponentGetValue2(comp_cost, "value_int")

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    cu = cu + 1
    if cu > 5 then
        cu = 1
    end
    if cu == 5 then
        GamePrint("Now upgrading mana charge speed! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 4 then
        GamePrint("Now upgrading mana max! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 3 then
        GamePrint("Now upgrading cast delay! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 2 then
        GamePrint("Now upgrading recharge time! ".. "Upgrades cost " .. cost .. " souls.")
    elseif cu == 1 then
        GamePrint("Now upgrading capacity! ".. "Upgrades cost " .. cost .. " souls.")
    end
    ComponentSetValue2(comp_cu, "value_string", tostring(cu))
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end]]