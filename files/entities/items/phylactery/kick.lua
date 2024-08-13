dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick( entity_who_kicked )
    if entity_who_kicked == GetPlayer() then
        if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 10 then
            RemoveRandomSouls(10)
            local phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0"))
            GlobalsSetValue("souls_phylactery_points", tostring(phylactery_points + (1 * 10)))
            GamePrint("Souls deposited into Phylactery!")
            GameAddFlagRun("souls_phylactery_done") -- just incase it was spawned in :)
        end
    end
end