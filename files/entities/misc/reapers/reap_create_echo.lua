dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
if this == root then print("echoreap root is this???") return end
local players = EntityGetWithTag("player_unit") or {}
if #players > 0 then
    local player = players[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	if comp ~= nil then
		local wand = ComponentGetValue2(comp, "mActiveItem")
        local soul = WandSoulType(wand)
        EntityAddComponent2(root, "VariableStorageComponent", {
            _tags = "souls_echoreap_type",
            name = "souls_echoreap_type",
            value_string = soul
        })
    end
end