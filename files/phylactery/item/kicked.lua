dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

function kick( entity_who_kicked )
    if entity_who_kicked == GetPlayer() then
        if GetSoulsCount("all") >= 10 then
            RemoveSouls(10)
            local phylactery_points = tonumber(GlobalsGetValue("kupoli_phylactery_points", "0"))
            GlobalsSetValue("kupoli_phylactery_points", tostring(phylactery_points + (5 * 10)))
            GamePrint("Souls deposited into Phylactery!")
            GameAddFlagRun("kupoli_phylactery_done") -- just incase it was spawned in :)
        end
    end
end