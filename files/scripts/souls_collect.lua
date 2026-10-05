dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 6, "player_unit")

if #targets > 0 then
    local player = targets[1]
    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
    if comp_soul ~= nil then
        local soul = ComponentGetValue2(comp_soul, "value_string")
        SoulsPrint("You have acquired a " .. SoulNameCheck(soul) .. " soul!", "say_soul")
        EditSoulCounts({[soul] = 1}, player)
        local on_reap_comps = EntityGetComponent(player, "LuaComponent", "souls_execute_on_reap") or {}
        if #on_reap_comps > 0 then
            for i = 1, #on_reap_comps do
                local comp_on_reap = on_reap_comps[i]
                dofile_once(ComponentGetValue2(comp_on_reap, "script_source_file")).on_reap(player, 1)
            end
        end
        EntityKill(this)
    end
end