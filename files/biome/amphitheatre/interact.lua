dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    --[[local px, py = EntityGetTransform(entity_who_interacted)
    local spells = EntityGetInRadiusWithTag(px, py, 5, "card_action")
    local spells2 = {}
    for i,spell in ipairs(spells) do
        if EntityGetRootEntity(spell) == spell then
            table.insert(spells2, spell)
        end
    end
    if #spells2 > 0 then return end]]
    if not (GetSoulsCount("all") - GetSoulsCount("boss") >= 10) then GamePrint("You do not have enough souls for this.") return end
    for i=1,10 do
        local soul = GetRandomSoul(false)
        RemoveSoul(soul)
    end
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local frame = GameGetFrameNum()
    local player = GetPlayer()

    local enemy_count = tonumber(GlobalsGetValue("souls.amphitheatre_enemy_count"))

    local enemies = {
        { probability = 0.8, path = "data/entities/animals/wizard_dark.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_hearty.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_homing.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_neutral.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_poly.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_returner.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_swapper.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_tele.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_twitchy.xml" },
        { probability = 0.8, path = "data/entities/animals/wizard_weaken.xml" },
        { probability = 0.7, path = "data/entities/animals/moldos_puppet_master.xml" },
        { probability = 0.3, path = "data/entities/animals/moldos_soul_angry.xml" },
        { probability = 0.3, path = "data/entities/animals/moldos_soul_rogue.xml" },
        { probability = 0.9, path = "data/entities/animals/scavenger_smg.xml" },
        { probability = 0.9, path = "data/entities/animals/scavenger_leader.xml" },
        { probability = 0.9, path = "data/entities/animals/scavenger_grenade.xml" },
        { probability = 0.8, path = "data/entities/animals/firemage.xml" },
        { probability = 0.2, path = "data/entities/animals/boss_alchemist/boss_alchemist.xml" },
        { probability = 0.2, path = "data/entities/animals/boss_limbs/boss_limbs.xml" },
        { probability = 0.1, path = "data/entities/animals/boss_wizard/boss_wizard.xml" },
    }

    local num = 1
    if enemy_count > 30 then
        enemy_count = 30
    end
    for i=1,enemy_count do
        num = num + 1
        local enemy = PickRandomFromTableWeighted(x + frame + num, y + frame + num, enemies) or {}
        x = x + math.random(-50, 50)
        y = y + math.random(-10, -2)
        enemy = EntityLoad(enemy.path, x, y)
        EntityAddTag(enemy, "souls_amphitheatre_enemy")
        EntityAddComponent2(enemy, "LuaComponent", {
            script_death = "mods/souls/files/biome/amphitheatre/enemy_death.lua",
            execute_every_n_frame = -1,
        })
        local comp_genome = EntityGetFirstComponentIncludingDisabled(enemy, "GenomeDataComponent")
        if comp_genome ~= nil then
            local herd_id_number = ComponentGetValue2(comp_genome, "herd_id")
            local herd_id = HerdIdToString(herd_id_number)
            if herd_id ~= "boss" then
                herd_id = "mage"
                ComponentSetValue2(comp_genome, "herd_id", StringToHerdId(herd_id))
            end
        end
    end
    
    GameAddFlagRun("souls.amphitheatre_active")
    GamePrintImportant("WAVE STARTED!", "The Gods are entertained.", "mods/souls/files/souls_decoration.png")
    GlobalsSetValue("souls.amphitheatre_enemy_count", tostring(enemy_count + 3))
    EntitySetComponentsWithTagEnabled(this, "amphitheatre_interact", false)
end