dofile_once("mods/souls/files/scripts/souls.lua")

function SoulShift(player)
    local soul_types = GetSoulTypes()
    local x, y = EntityGetTransform(player)
    local frame = GameGetFrameNum()
    SetRandomSeed(x + frame, y)

    local soul
    local to

    local comp_inv = EntityGetFirstComponent(player, "Inventory2Component")
    if comp_inv ~= nil then
        local active_item = ComponentGetValue2(comp_inv, "mActiveItem")
        if EntityHasTag(active_item, "wand") then
            local wand_soul = WandSoulType(active_item)
            if wand_soul ~= "any" and wand_soul ~= "boss" then
                if Random(1, 2) == 1 then
                    soul = wand_soul
                else
                    to = wand_soul
                end
            end
        end
    end

    local soul_i = Random(1, #soul_types - 1)
    soul = soul or soul_types[soul_i]

    local to_i = Random(1, #soul_types - 1)
    to = to or (soul ~= soul_types[to_i] and soul_types[to_i]) or soul_types[#soul_types - 2]

    local str_from = SoulNameCheck(soul)
    local str_to = SoulNameCheck(to)

    EntityAddComponent2(player, "VariableStorageComponent", {
        _tags = "souls_shifted",
        name = soul,
        value_string = to
    })

    SoulsPrintImportant("The void stirs...", str_from .. " souls have been transformed into " .. str_to .. " souls!")

    return soul, to
end

local effect = GetUpdatedEntityID()

local frame_now = GameGetFrameNum()

local comp_frame_created = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "frame_created")
local frame_created = ComponentGetValue2(comp_frame_created, "value_int")
if frame_created == 0 then
    frame_created = frame_now
    ComponentSetValue2(comp_frame_created, "value_int", frame_now)
end

--GamePrint(tostring(frame_created + 540 - frame_now))

if frame_now > frame_created + 540 then
    local frame_shifted = tonumber(GlobalsGetValue("souls.shifted_frame", "0"))
    if not (frame_now > frame_shifted + 1800) then return end
    local root = EntityGetRootEntity(effect)
    if EntityHasTag(root, "player_unit") and not EntityHasTag(effect, "souls_effect_shifted") then
        GlobalsSetValue("souls.shifted_frame", tostring(frame_now))
        EntityAddTag(effect, "souls_effect_shifted")
        EntityRemoveIngestionStatusEffect(root, "SOULS_TRIP_SOUL")
        local from, to = SoulShift(root)
        local x, y = EntityGetTransform(root)
        GamePlaySound("data/audio/Desktop/animals.bank", "animals/boss_centipede/shoot_clean_materials", x, y)
    end
end