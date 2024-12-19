dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick( entity_who_kicked )
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    if this ~= root then return end
    if entity_who_kicked == GetPlayer() then
        if (GetSoulsCount("all") - GetSoulsCount("boss")) >= 10 then
            RemoveRandomSouls(10)
            local phylactery_points = tonumber(GlobalsGetValue("souls_phylactery_points", "0"))
            GlobalsSetValue("souls_phylactery_points", tostring(phylactery_points + (3 * 10)))
            GamePrintImportant("PHYLACTERY POWERED!", "It hums with energy.", "mods/souls/files/souls_decoration.png")
            GameAddFlagRun("souls_phylactery_done") -- just incase it was spawned in :)
        else
            GamePrint("You do not have enough souls for this.")
        end
    end
end