local this = GetUpdatedEntityID()
local comp_life = EntityGetFirstComponent(this, "VariableStorageComponent", "frames_left")
local life = ComponentGetValue2(comp_life, "value_int") or 0
life = life - 1
ComponentSetValue2(comp_life, "value_int", life)
local comp_part = EntityGetFirstComponentIncludingDisabled(this, "ParticleEmitterComponent")
local radius = 60 * (life/180)
ComponentSetValue2(comp_part, "area_circle_radius", radius, radius)

if life <= 0 then
    local x, y = EntityGetTransform(this)
    local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_boss_to_revive")
    if comp == nil then print("Souls?") return end

    local path = ComponentGetValue2(comp, "value_string")
    local boss = EntityLoad(path, x, y)

    EntityAddTag(boss, "souls_revived_boss")

    if path == "data/entities/animals/boss_dragon.xml" then
        EntityAddComponent2(boss, "LuaComponent", { 
		    script_death = "data/scripts/animals/boss_dragon_death.lua",
		    execute_every_n_frame = -1,
	    })
    end

    local dmc = EntityGetFirstComponent(boss, "DamageModelComponent")
    if dmc ~= nil then
        local max_hp = ComponentGetValue2(dmc, "max_hp")
        local hp = ComponentGetValue2(dmc, "hp")
        max_hp = max_hp * 1.3
        hp = hp * 1.3
        ComponentSetValue2(dmc, "max_hp", max_hp)
        ComponentSetValue2(dmc, "hp", hp)
    end

    GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
    GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
    GameScreenshake(30)
    EntityKill(this)
end