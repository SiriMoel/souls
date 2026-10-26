dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")
local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame")
if comp_state ~= nil and comp_frame ~= nil then
    if InputIsMouseButtonDown(2) then
        local frame_last = ComponentGetValue2(comp_frame, "value_int")
        local frame = GameGetFrameNum()
        if frame >= frame_last + 30 then
            ComponentSetValue2(comp_frame, "value_int", frame)
            local state = ComponentGetValue2(comp_state, "value_bool")
            state = not state -- i wish flipbool() was real
            local root = EntityGetRootEntity(this)
            local comp_sprite = EntityGetFirstComponentIncludingDisabled(root, "SpriteComponent", "soul_mask_on") or EntityAddComponent2(root, "SpriteComponent", {
                _enabled = state,
                _tags = "soul_mask_on",
		        image_file = "mods/souls/files/entities/items/masks/sprite_on.xml",
		        z_index = -1.5,
            })
            ComponentSetValue2(comp_sprite, "image_file",  "mods/souls/files/entities/items/masks/sprite_on.xml")
            ComponentSetValue2(comp_sprite, "offset_x", 5)
            ComponentSetValue2(comp_sprite, "offset_y", 17)
            EntitySetComponentsWithTagEnabled(root, "soul_mask_on", state)
            EntitySetComponentsWithTagEnabled(this, "on", state)
            ComponentSetValue2(comp_state, "value_bool", state)
        end
    end
end