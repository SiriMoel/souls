dofile_once("mods/souls/files/scripts/utils.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

SetRandomSeed(x, y + GameGetFrameNum())

EntityLoad( "data/entities/particles/treble_eye.xml", x+(math.random(-90,90)), y+(math.random(-15,-150)) )

if GameHasFlagRun("souls_spawn_soul_boss") and #EntityGetInRadiusWithTag(x, y, 250, "player_unit") > 0 then
    EntityLoad("data/entities/animals/moldos_boss_soul.xml", x, y)
    GameRemoveFlagRun("souls_spawn_soul_boss")
end