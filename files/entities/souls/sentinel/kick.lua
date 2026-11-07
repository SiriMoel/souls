dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    if not EntityHasTag(entity_who_kicked, "player_unit") then return end

    local c = EntityGetAllChildren(this) or {}
    for i, v in ipairs(c) do
        EntityKill(v)
    end

    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
    local soul = ComponentGetValue2(comp_soul, "value_float")

    local amt = math.floor(soul)
    EditSoulCounts({["friendly"]=amt}, entity_who_kicked)
    SoulsPrint(amt .. " " .. SoulNameCheck("friendly") .. " souls were reclaimed from the sentinel.", "say_soul")

    EntityKill(this)
end