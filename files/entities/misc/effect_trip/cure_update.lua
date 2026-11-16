dofile_once("mods/souls/files/scripts/souls.lua")

local effect = GetUpdatedEntityID()

local frame_now = GameGetFrameNum()

local comp_frame_created = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "frame_created")
local frame_created = ComponentGetValue2(comp_frame_created, "value_int")
if frame_created == 0 then
    frame_created = frame_now
    ComponentSetValue2(comp_frame_created, "value_int", frame_now)
end

if frame_now > frame_created + 540 then
    local frame_shifted = tonumber(GlobalsGetValue("souls.shifted_frame", "0"))
    if not frame_now > frame_shifted + 1800 then return end
    local root = EntityGetRootEntity(effect)
    if EntityHasTag(root, "player_unit") and not EntityHasTag(effect, "souls_effect_shifted") then
        GlobalsSetValue("souls.shifted_frame", tostring(frame_now))
        EntityAddTag(effect, "souls_effect_shifted")
        EntityRemoveIngestionStatusEffect(root, "SOULS_TRIP_CURE")
        local from, to = SoulShift(root)
        local x, y = EntityGetTransform(root)
        GamePlaySound("data/audio/Desktop/animals.bank", "animals/boss_centipede/shoot_clean_materials", x, y)
        local comps = EntityGetComponentIncludingDisabled(root, "VariableStorageComponent", "souls_shifted") or {}
        for i, comp in ipairs(comps) do
            EntityRemoveComponent(root, comp)
        end
        SoulsPrintImportant("The void stirs...", "All soul types have been restored!")
    end
end