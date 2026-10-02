local this = GetUpdatedEntityID()
local comp_p = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "phylactery")
local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame")
if comp_p ~= nil and comp_frame ~= nil then
    if InputIsMouseButtonDown(2) then
        local frame_last = ComponentGetValue2(comp_frame, "value_int")
        local frame = GameGetFrameNum()
        if frame > frame_last + 12 then
            ComponentSetValue2(comp_frame, "value_int", frame)
            local success = SpellUseSouls(EntityGetWithTag("player_unit")[1], 1)
            if success then
                SpellUseSouls(EntityGetWithTag("player_unit")[1], 1)
                local x, y = EntityGetTransform(this)
                local amt = ComponentGetValue2(comp_p, "value_int")
                amt = amt + 3
                ComponentSetValue2(comp_p, "value_int", amt)
                GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y) -- placeholder probably
            else
                GamePrint("You do not have enough souls for this. (1)")
            end
        end
    end
end