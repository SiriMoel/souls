dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 6, "player_unit")

if #targets > 0 then
    local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
    if comp_soul ~= nil then
        local soul = ComponentGetValue2(comp_soul, "value_string")
        if tobool(GlobalsGetValue("souls.say_soul", "true")) == true then
            GamePrint("You have acquired a " .. SoulNameCheck(soul) .. " soul!")
        end
        AddSouls(soul, 1)
        if EntityHasTag(targets[1], "souls_anima_conduit") then
            local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(targets[1], "DamageModelComponent")
            if comp_damagemodel ~= nil then
                local hp = ComponentGetValue2(comp_damagemodel, "hp")
                local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
                -- heals 0.1% rounding up, stronger at lower max hp, weaker at higher max hp as you get more reaping spells
                hp = hp + math.ceil((max_hp * 0.001))
                if hp > max_hp then
                    hp = max_hp
                end
                ComponentSetValue2(comp_damagemodel, "hp", hp)
            end
        end
        if EntityHasTag(targets[1], "souls_reap_bullet") then
            local comp_controls = EntityGetFirstComponentIncludingDisabled(targets[1], "ControlsComponent")
            if comp_controls ~= nil then
                local tx, ty = ComponentGetValue2(comp_controls, "mMousePosition")
                local px, py = EntityGetTransform(targets[1])
                local vel_x = math.cos(0 - math.atan2(ty - py, tx - px)) * 1000.0
                local vel_y = 0 - math.sin(0 - math.atan2(ty - py, tx - px)) * 1000.0
                shoot_projectile(targets[1], "data/entities/projectiles/deck/bullet_heavy.xml", px, py, vel_x, vel_y)
            end
        end
        EntityKill(this)
    end
end