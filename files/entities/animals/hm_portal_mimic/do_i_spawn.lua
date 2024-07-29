dofile_once("mods/souls/files/scripts/utils.lua")

local portal = GetUpdatedEntityID()
local x, y = EntityGetTransform(portal)

--EntityAddTag(portal, "hm_portal")

--math.randomseed(x,x+GameGetFrameNum()) -- aaa why cant this do what i want it to do

SetRandomSeed( x, y + tonumber(StatsGetValue("world_seed")))

local doidoit = Random(1,150)

--doidoit = 2

if doidoit == 2 and EntityHasTag(portal, "can_spawn_mimic") then
    local comps = EntityGetAllComponents(portal)
    for i,v in ipairs(comps) do
        EntitySetComponentIsEnabled(portal, v, false)
    end
    EntityLoad("data/entities/animals/kupoli_hm_portal_mimic.xml", x, y)
    --EntityKill(portal)
end