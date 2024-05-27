dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)
local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "soul_kick_cd") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

if HeldItem(player) == EntityGetWithTag("kupoli_tome") then
    if ComponentGetValue2(comp_controls, "mButtonDownKick") and GameGetFrameNum() >= cooldown_frame then
        GamePrint("hi")
    
        if GetSoulsCount("all") > 0 then
            --[[if ComponentGetValue2(comp_controls, "mButtonDownRightClick") and not ComponentGetValue2(comp_controls, "mButtonDownLeftClick") then
                GamePrint("kick and right click")
                -- eat projectiles
                local targets = EntityGetInRadiusWithTag(x, y, 5, "projectile")
                EntityLoad("mods/tales_of_kupoli/files/entities/misc/soul_kick_rightclick.xml", x, y)
                for i,v in ipairs(targets) do
                    EntityKill(v)
                end

                RemoveSouls(1)
            end]]

            local targets = EntityGetInRadiusWithTag(x, y, 5, "projectile")
            EntityLoad("mods/tales_of_kupoli/files/entities/misc/soul_kick_rightclick.xml", x, y)
            for i,v in ipairs(targets) do
                EntityKill(v)
            end

            RemoveSouls(1)
            
            --[[if ComponentGetValue2(comp_controls, "mButtonDownUp") and not ComponentGetValue2(comp_controls, "mButtonDownRightClick") then
                GamePrint("kick and up")
                -- mark nearby enemies to drop souls
                local mark_radius = 100
                local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )
                if #targets > 0 then
                    for i,target in ipairs(targets) do
                        if ( EntityHasTag( target_id, "reap_marked" ) == false ) then

                            EntityAddComponent( target_id, "LuaComponent",
                            {
                                script_death = "mods/tales_of_kupoli/files/scripts/reap.lua",
                                execute_every_n_frame = "-1",
                            } )
                
                            EntityAddTag( target_id, "reap_marked")
                        end
                
                        if EntityHasTag(target_id, "reap_marked_fx") == false then
                            local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/particles/marked_particles.xml", x, y)
                            EntityAddChild(target_id, effect_id)
                            EntityAddTag(target_id, "reap_marked_fx")
                        end
                    end
                end

                RemoveSouls(1)
            end]]--
        end
    
        ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
    end
end