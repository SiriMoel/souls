dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/souls/files/scripts/souldoor_rewards.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()
local player = GetPlayer()

local targets = EntityGetInRadiusWithTag(x, y, 450, "souls_amphitheatre_enemy") or {}

if #targets == 0 and GameHasFlagRun("souls.amphitheatre_active") then
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", true)
    SoulsPrintImportant("WAVE DEFEATED!", "The next wave will be more difficult...", "amphitheatre")
    local which = PickRandomFromTableWeighted(x + frame + tonumber(StatsGetValue("world_seed")), y + frame + tonumber(StatsGetValue("world_seed")), soul_spells) or { id = "LIGHT_BULLET" }
    CreateItemActionEntity(which.id, x, y)
    GameRemoveFlagRun("souls.amphitheatre_active")
end

if #targets < 1 then
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", true)
end