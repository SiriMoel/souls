dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 30
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    local entity_id = GetUpdatedEntityID()
            local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
            if controls_comp ~= nil then

                local character_data_comp = EntityGetFirstComponent(entity_id, "CharacterDataComponent")
                if character_data_comp ~= nil then

                    local caster = {
                        velocity = {x = 0, y = 0},
                        position = {x = 0, y = 0},
                    }
                    local mouse = {
                        position = {x = 0, y = 0},
                    }

                    caster.position.x,  caster.position.y   = EntityGetTransform(entity_id)
                    caster.velocity.x,  caster.velocity.y   = ComponentGetValueVector2(character_data_comp, "mVelocity")
                    mouse.position.x,   mouse.position.y    = ComponentGetValueVector2(controls_comp, "mMousePosition")

                    local offset = {
                        x = mouse.position.x - caster.position.x,
                        y = mouse.position.y - caster.position.y,
                    }
                    local force = {
                        x = 700,
                        y = 300,
                    }

                    local len = math.sqrt((offset.x ^ 2) + (offset.y ^ 2))
                    caster.velocity.x = caster.velocity.x + (offset.x / len * force.x)
                    caster.velocity.y = caster.velocity.y + (offset.y / len * force.y)

                    ComponentSetValue2(character_data_comp, "mVelocity", caster.velocity.x, caster.velocity.y)
                end
            end
    ComponentSetValue2(comp_ca, "value_string", tostring(ca))
    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end