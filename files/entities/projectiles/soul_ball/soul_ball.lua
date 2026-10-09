dofile_once("mods/souls/files/scripts/souls.lua")

soul_effects = {
	bat = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.bat)
		EntityAddComponent2(this, "HomingComponent", {
			homing_targeting_coeff=110.0,
			homing_velocity_multiplier=1.2,
		})
		local damage_melee = ComponentObjectGetValue2(comp_proj, "damage_by_type", "melee")
		damage_melee = damage_melee + 0.8
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", damage_melee)
	end,
	fly = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.fly)
		local damage = ComponentGetValue2(comp_proj, "damage")
		damage = damage * 1.2
		ComponentSetValue2(comp_proj, "damage", damage)
		local comp_vel = EntityGetFirstComponent(this, "VelocityComponent")
		if comp_vel ~= nil then
			local air_friction = ComponentGetValue2(comp_vel, "air_friction")
			air_friction = air_friction - 3
			ComponentSetValue2(comp_vel, "air_friction", air_friction)
		end
	end,
	friendly = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.friendly)
	end,
	mage = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.mage)
		local damage = ComponentGetValue2(comp_proj, "damage")
		local expdamage = ComponentObjectGetValue2(comp_proj, "config_explosion", "damage")
		local exprad = ComponentObjectGetValue2(comp_proj, "config_explosion", "explosion_radius")
		damage = damage * 0.7
		expdamage = expdamage * 1.6
		exprad = exprad * 1.4
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", damage)
	end,
	orcs = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.orcs)
		local expdamage = ComponentObjectGetValue2(comp_proj, "config_explosion", "damage")
		local exprad = ComponentObjectGetValue2(comp_proj, "config_explosion", "explosion_radius")
		expdamage = expdamage * 0.8
		exprad = exprad * 1.7
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
	end,
	slimes = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.slimes)
		EntityAddComponent2(this, "SineWaveComponent", {
			_enabled=true,
			sinewave_freq=1.0,
			sinewave_m=0.6,
			lifetime=-1,
		})
		local damage_poison = ComponentObjectGetValue2(comp_proj, "damage_by_type", "poison")
		damage_poison = damage_poison + 0.4
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "poison", damage_poison)
		local bounces_left = ComponentGetValue2(comp_proj, "bounces_left")
		bounces_left = bounces_left + 5
		ComponentSetValue2(comp_proj, "bounces_left", bounces_left)
	end,
	spider = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.spider)
		EntityAddComponent2(this, "LuaComponent", {
			script_source_file="mods/souls/files/entities/projectiles/soul_blast/arc_spider.lua",
			execute_every_n_frame=2,
		})
	end,
	zombie = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.zombie)
		local expdamage = ComponentObjectGetValue2(comp_proj, "config_explosion", "damage")
		local exprad = ComponentObjectGetValue2(comp_proj, "config_explosion", "explosion_radius")
		expdamage = expdamage * 0.6
		exprad = exprad * 2
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
	end,
	worm = function(this, comp_proj, comp_part)
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.worm)
		EntityAddComponent2(this, "CellEaterComponent", {
			eat_probability=90,
			radius=12,
		})
		local damage_melee = ComponentObjectGetValue2(comp_proj, "damage_by_type", "melee")
		damage_melee = damage_melee + 0.8
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", damage_melee)
	end,
	fungus = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.fungus)
		local expdamage = ComponentObjectGetValue2(comp_proj, "config_explosion", "damage")
		local exprad = ComponentObjectGetValue2(comp_proj, "config_explosion", "explosion_radius")
		expdamage = expdamage * 0.5
		exprad = exprad * 3
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
	end,
	ghost = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.ghost)
		EntityAddComponent2(this, "LuaComponent", {
			script_source_file="mods/souls/files/entities/projectiles/soul_blast/arc_ghost.lua",
			execute_every_n_frame=30,
		})
		local damage = ComponentGetValue2(comp_proj, "damage")
		damage = damage * 1.35
		ComponentSetValue2(comp_proj, "damage", damage)
	end,
	souls_void = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.souls_void)
		local damage = ComponentGetValue2(comp_proj, "damage")
		damage = damage * 1.4
		ComponentSetValue2(comp_proj, "damage", damage)
		local damage_curse = ComponentObjectGetValue2(comp_proj, "damage_by_type", "curse")
		damage_curse = damage_curse + 0.8
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "curse", damage_curse)
	end,
	boss = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.boss)
		local damage = ComponentGetValue2(comp_proj, "damage")
		local damage_holy = ComponentObjectGetValue2(comp_proj, "damage_by_type", "holy")
		local damage_curse = ComponentObjectGetValue2(comp_proj, "damage_by_type", "curse")
		damage_holy = damage_holy + damage
		damage_curse = damage_curse + damage
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "holy", damage_holy)
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "curse", damage_curse)
		--ComponentSetValue2(comp_proj, "damage", 0)
		local bounces_left = ComponentGetValue2(comp_proj, "bounces_left")
		bounces_left = bounces_left + 30
		ComponentSetValue2(comp_proj, "bounces_left", bounces_left)
	end,
	mage_corrupted = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.mage_corrupted)
		local damage = ComponentGetValue2(comp_proj, "damage")
		local expdamage = ComponentObjectGetValue2(comp_proj, "config_explosion", "damage")
		local exprad = ComponentObjectGetValue2(comp_proj, "config_explosion", "explosion_radius")
		damage = damage * 1.3
		expdamage = expdamage * 1.3
		exprad = exprad * 0.7
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", damage)
	end,
	ghost_whisp = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.ghost_whisp)
		EntityAddComponent2(this, "LuaComponent", {
			script_source_file="mods/souls/files/entities/projectiles/soul_blast/arc_ghost.lua",
			execute_every_n_frame=30,
		})
		EntityAddComponent2(this, "LuaComponent", {
			script_source_file="mods/souls/files/entities/projectiles/soul_blast/arc_spider.lua",
			execute_every_n_frame=2,
		})
		local damage = ComponentGetValue2(comp_proj, "damage")
		damage = damage * 1.3
		ComponentSetValue2(comp_proj, "damage", damage)
		local damage_fire = ComponentObjectGetValue2(comp_proj, "damage_by_type", "fire")
		damage_fire = damage_fire + 1.2
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "fire", damage_fire)
		EntityAddComponent2(this, "MagicConvertMaterialComponent", {
			from_material_tag="[burnable]",
			to_material="fire",
			steps_per_frame=20,
			loop=true,
			is_circle=true,
			radius=20,
		})
	end,
}

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local comp_proj = EntityGetFirstComponent(entity, "ProjectileComponent")

local player = EntityGetWithTag("player_unit")[1]

local success, soul = SpellUseSouls(player, 1)

if not success or soul == nil then
	SoulsPrint("You do not have enough souls for this. (1)", "say_not_enough")

	ComponentSetValue2(comp_proj,"on_death_explode", false)
	ComponentSetValue2(comp_proj, "on_lifetime_out_explode", false)
	ComponentSetValue2(comp_proj, "collide_with_entities", false)
	ComponentSetValue2(comp_proj, "collide_with_world", false)
	ComponentSetValue2(comp_proj, "lifetime", 1)

    EntityKill(entity)
else
	SoulsPrint("A " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " soul was consumed!", "say_consumed_soul")

	local comp_particles = EntityGetFirstComponent(entity, "ParticleEmitterComponent") or 0

	local func = soul_effects[soul]
	if func ~= nil then
		func(entity, comp_proj, comp_particles)
	end
end