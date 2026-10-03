dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 6, "player_unit")

if #targets > 0 then
    local player = targets[1]
    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
    if comp_soul ~= nil then
        local soul = ComponentGetValue2(comp_soul, "value_string")
        if GlobalsGetValue("souls.say_soul", "true") == "true" then
            GamePrint("You have acquired a " .. SoulNameCheck(soul) .. " soul!")
        end
        EditSoulCounts({[soul] = 1}, player)
        if EntityHasTag(player, "souls_anima_conduit") then
            AnimaConduit(player, 1)
        end
        EntityKill(this)
    end
end