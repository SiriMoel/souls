dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function interacting()
    if not (GetSoulsCount("all") - GetSoulsCount("boss")) >= 10 then GamePrint("You do not have enough souls for this.") return end
    RemoveRandomSouls(10)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local frame = GameGetFrameNum()
    local player = GetPlayer()

    local enemy_count = tonumber(GlobalsGetValue("souls.amphitheatre_enemy_count"))

    local enemies = {
        { probability = 0.7, path = "data/entities/animals/wizard_dark.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_hearty.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_homing.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_neutral.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_poly.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_returner.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_swapper.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_tele.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_twitchy.xml" },
        { probability = 0.7, path = "data/entities/animals/wizard_weaken.xml" },
        { probability = 0.6, path = "data/entities/animals/moldos_puppet_master.xml" },
        { probability = 0.2, path = "data/entities/animals/moldos_soul_angry.xml" },
        { probability = 0.8, path = "data/entities/animals/scavenger_smg.xml" },
        { probability = 0.8, path = "data/entities/animals/scavenger_leader.xml" },
        { probability = 0.8, path = "data/entities/animals/scavenger_grenade.xml" },
        { probability = 0.7, path = "data/entities/animals/firemage.xml" },
        { probability = 0.1, path = "data/entities/animals/boss_alchemist/boss_alchemist.xml" },
        { probability = 0.1, path = "data/entities/animals/boss_limbs/boss_limbs.xml" },
    }

    local num = 1
    if enemy_count > 50 then
        enemy_count = 50
    end
    for i=1,enemy_count do
        num = num + 1
        local enemy = PickRandomFromTableWeighted(x + frame + num, y + frame + num, enemies) or {}
        x = x + math.random(-50, 50)
        y = y + math.random(-10, -2)
        enemy = EntityLoad(enemy.path, x, y)
        EntityAddTag(enemy, "souls_amphitheatre_enemy")
        EntityAddComponent2(enemy, "LuaComponent", {
            script_death = "mods/souls/files/scripts/reap.lua",
            execute_every_n_frame = "-1",
        })
    end
    
    GameAddFlagRun("souls.amphitheatre_active")
    
    GlobalsSetValue("souls.amphitheatre_enemy_count", tostring(enemy_count + 5))
    
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", false)
end