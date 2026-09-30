dofile_once("mods/souls/files/scripts/souls.lua")

soul_effects = {
	bat = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.bat)
	end,
	fly = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.fly)
	end,
	friendly = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.friendly)
	end,
	mage = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.mage)
	end,
	orcs = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.orcs)
	end,
	slimes = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.slimes)
	end,
	spider = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.spider)
	end,
	zombie = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.zombie)
	end,
	worm = function(this, comp_proj, comp_part)
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.worm)
	end,
	fungus = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.fungus)
	end,
	ghost = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.ghost)
	end,
	souls_void = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.souls_void)
	end,
	boss = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.boss)
	end,
	mage_corrupted = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.mage_corrupted)
	end,
	ghost_whisp = function(this, comp_proj, comp_part) 
		ComponentSetValue2(comp_part, "emitted_material_name", soul_sparks.ghost_whisp)
	end,
}

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local comp_proj = EntityGetFirstComponent(entity, "ProjectileComponent")

local player = GetPlayer()

local success, soul = SpellUseSouls(player, 1)

if not success or soul == nil then
	GamePrint("You do not have enough souls for this.")

	ComponentSetValue2(comp_proj,"on_death_explode", false)
	ComponentSetValue2(comp_proj, "on_lifetime_out_explode", false)
	ComponentSetValue2(comp_proj, "collide_with_entities", false)
	ComponentSetValue2(comp_proj, "collide_with_world", false)
	ComponentSetValue2(comp_proj, "lifetime", 1)

    EntityKill(entity)
else
	if GlobalsGetValue("souls.say_consumed_soul", "true") == "true" then
		local soul_name = GameTextGetTranslatedOrNot(soul_names[soul])
		GamePrint("A " .. soul_name .. " soul was consumed!")
	end

	--[[local who_shot = ComponentGetValue2(comp_proj, "mWhoShot")
	if who_shot == player then
		RemoveSoul(soul)
	end]]

	local comp_particles = EntityGetFirstComponent(entity, "ParticleEmitterComponent") or 0

	local func = soul_effects[soul]
	if func ~= nil then
		func(entity, comp_proj, comp_particles)
	end

	--[[

	-- bat
	if soul == "bat" then
		EntityAddComponent2(entity, "HomingComponent", {
			homing_targeting_coeff=130.0,
			homing_velocity_multiplier=0.86,
		})

		projdamage = projdamage * 1.1

		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	-- fly
	if soul == "fly" then	
		EntityAddComponent2(entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/chaotic_arc.lua",
			execute_every_n_frame=2,
		})
	
		EntityAddComponent2(entity, "HomingComponent", {
			homing_targeting_coeff=130.0,
			homing_velocity_multiplier=0.86,
		})
	
		projdamage = projdamage + 0.2
		projdamage = projdamage * 0.95
	
		ComponentSetValue2( comp_proj, "damage", projdamage )
	end

	-- friendly


	-- souls_void
	if soul == "souls_void" then
		projdamage = projdamage + 0.5
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		icedamage = icedamage + 0.3
		icedamage = icedamage * 2
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	-- mage
	if soul == "mage" then	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff=15,
			detect_distance=300,
			homing_velocity_multiplier=1.0,
		})
	
		projdamage = projdamage * 0.8
		expdamage = expdamage * 1.3
		exprad = exprad * 0.6
		
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	-- orcs and zombie
	if soul == "orcs" or soul == "zombie" then

		EntityAddComponent2(entity, "SineWaveComponent", {
			_enabled=true,
			sinewave_freq=1.0,
			sinewave_m=0.6,
			lifetime=-1,
		} )
	
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
	end

	-- slimes
	if soul == "slimes" then	
		poisondamage = poisondamage + 0.2
		poisondamage = poisondamage * 1.5
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "poison", poisondamage)
	end

	-- spider
	if soul == "spider" then	
		EntityAddComponent(entity, "CellEaterComponent", {
			eat_probability="90",
			radius="16",
			ignored_material="rock_static_cursed",
			ignored_material_tag="[matter_eater_ignore_list]",
		})

		meleedamage = meleedamage + 0.15
		meleedamage = meleedamage * 1.3

		ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", meleedamage)
	end

	-- worm
	if soul == "worm" then
		EntityAddComponent(entity, "CellEaterComponent", {
			eat_probability="90",
			radius="24",
			ignored_material="",
			ignored_material_tag="",
		})

		meleedamage = meleedamage + 0.3
		meleedamage = meleedamage * 1.3
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", meleedamage)
	end

	-- fungus
	if soul == "fungus" then
	
		expdamage = expdamage * 1.1
		exprad = exprad * 3
		
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
	end

	-- ghost
	if soul == "ghost" then
		EntityAddComponent2(entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/phasing_arc.lua",
			execute_every_n_frame=8,
		})
	
		icedamage = icedamage + 0.4
		exprad = exprad * 1.1
	
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
	end

	-- boss
	if soul == "boss" then
		projdamage = projdamage + 0.5
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		icedamage = icedamage + 0.6
		icedamage = icedamage * 2
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	-- mage_corrupted
	if soul == "mage_corrupted" then
		ComponentSetValue2(comp_particles, "emitted_material_name", "blood")
	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff=10,
			detect_distance=300,
			homing_velocity_multiplier=1.3,
		} )
	
		projdamage = projdamage * 1.4
		expdamage = expdamage * 1.4
		exprad = exprad * 0.75
		
		ComponentObjectSetValue2(comp_proj, "config_explosion", "damage", expdamage)
		ComponentObjectSetValue2(comp_proj, "config_explosion", "explosion_radius", exprad)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	-- ghost_whisp
	if soul == "ghost_whisp" then
		ComponentSetValue2(comp_particles, "emitted_material_name", "fire")

		firedamage = firedamage + 0.4
		firedamage = firedamage * 1.4

		EntityAddComponent(entity, "MagicConvertMaterialComponent", {
			from_material_tag="[burnable]",
			to_material="fire",
			steps_per_frame="20",
			loop="1",
			is_circle="1",
			radius="20",
		})
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "fire", firedamage)
	end]]
end