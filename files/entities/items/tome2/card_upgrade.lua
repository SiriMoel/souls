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

        if comp_sprite_upgrade_cost ~= nil then
            if ComponentGetValue2(comp_controls, "mButtonDownThrow") == true then
                EntitySetComponentIsEnabled(this, comp_sprite_upgrade_cost, true)

                local start_x, start_y = math.floor(player_x - (#tome_upgrades - 1) * 24), math.floor(player_y + 48)

                for i,v in ipairs(tome_upgrades) do
                    local draw_x, draw_y = start_x + (i - 1) * 48, start_y
                    GameCreateSpriteForXFrames("mods/souls/files/entities/items/tome2/upgrade_base.png", draw_x, draw_y, true, 0, 0, 1, 0)
                    GameCreateSpriteForXFrames(v.sprite, draw_x, draw_y, true, 0, 0, 1, 0)
                    if mouse_x > draw_x - 24 and mouse_x < draw_x + 24 and mouse_y > draw_y - 24 and mouse_y < draw_y + 24 then
                    selected = i
                        ComponentSetValue2(comp_upgrade, "value_int", i)
                    end
                    if i == selected then
                        GameCreateSpriteForXFrames("mods/souls/files/entities/items/tome2/upgrade_selected.png", draw_x, draw_y, true, 0, 0, 1, 0)
                        local comp_upgrade_count = EntityGetFirstComponentIncludingDisabled(parent, "VariableStorageComponent", "tome_upgrade_" .. selected)
                        if comp_upgrade_count ~= nil then
                            local upgrade_count = ComponentGetValue2(comp_upgrade_count, "value_int") or 0
                            local cost = tome_upgrades[selected].func_cost(upgrade_count) 
                            ComponentSetValue2(comp_sprite_upgrade_cost, "text", "Upgrade: " .. cost .. " souls")
                            EntityRefreshSprite(this, comp_sprite_upgrade_cost)
                        end
                    end
                end
            else
                EntitySetComponentIsEnabled(this, comp_sprite_upgrade_cost, false)
            end
        end

        if ComponentGetValue2(comp_controls, "mButtonDownFire") == true then
            local frame_cd = ComponentGetValue2(comp_frame_cd, "value_int")
            if frame_cd < frame_now - 24 then
                --GamePrint("Upgrading?")
                ComponentSetValue2(comp_frame_cd, "value_int", frame_now)
                local comp_upgrade_count = EntityGetFirstComponentIncludingDisabled(parent, "VariableStorageComponent", "tome_upgrade_" .. selected)
                if comp_upgrade_count ~= nil then
                    local upgrade_count = ComponentGetValue2(comp_upgrade_count, "value_int") or 0
                    local cost = tome_upgrades[selected].func_cost(upgrade_count)
                    if SoulCount("total", root) >= cost then
                        if SpellUseSouls(root, cost) then
                            tome_upgrades[selected].func_apply(parent)
                            ComponentSetValue2(comp_upgrade_count, "value_int", upgrade_count + 1)
                            local maxed = CheckIsTomeMaxed(parent)
                            if maxed then
                                if not GameHasFlagRun("souls_tome_maxed") then
                                    GameAddFlagRun("souls_tome_maxed")
                                end
                                if not HasFlagPersistent("souls_tome_maxed") then
                                    AddFlagPersistent("souls_tome_maxed")
                                end
                                SoulsPrintImportant("Tome maxed!", "It cannot be upgraded any further.")
                                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", player_x, player_y)
                                EntityKill(this)
                            else
                                GamePrint("Upgraded!")
                                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_light", player_x, player_y)
                            end
                        else
                            SoulsPrint("You do not have enough souls for this. (" .. cost .. ")")
                        end
                    else
                        SoulsPrint("You do not have enough souls for this. (" .. cost .. ")")
                    end
                end
            end
        end
    end
end