dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/souldoor_rewards.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()
local player = GetPlayer()

local targets = EntityGetInRadiusWithTag(x, y, 500, "souls_amphitheatre_enemy") or {}

if #targets < 1 and GameHasFlagRun("souls.amphitheatre_active") then
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", true)
    GamePrintImportant("WAVE DEFEATED!", "The next wave will be harder.", "mods/souls/files/souls_decoration.png")
    local which = PickRandomFromTableWeighted(x + frame + tonumber(StatsGetValue("world_seed")), y + frame + tonumber(StatsGetValue("world_seed")), soul_spells) or { id = "LIGHT_BULLET" }
    CreateItemActionEntity(which.id, x, y)
    GameRemoveFlagRun("souls.amphitheatre_active")
end

if #targets < 1 then
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", true)
end