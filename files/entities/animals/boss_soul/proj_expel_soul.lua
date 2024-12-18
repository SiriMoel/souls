dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity )
local x, y = EntityGetTransform( entity )

local comp_proj = EntityGetFirstComponent( entity, "ProjectileComponent" ) or 0
local projdamage = ComponentGetValue2( comp_proj, "damage" )
local expdamage = ComponentObjectGetValue( comp_proj, "config_explosion", "damage" )
local exprad = ComponentObjectGetValue( comp_proj, "config_explosion", "explosion_radius" )
local meleedamage = ComponentObjectGetValue( comp_proj, "damage_by_type", "melee" )
local icedamage = ComponentObjectGetValue( comp_proj, "damage_by_type", "ice" )
local poisondamage = ComponentObjectGetValue( comp_proj, "damage_by_type", "poison" )
local firedamage = ComponentObjectGetValue( comp_proj, "damage_by_type", "fire" )

local soul = GetRandomSoulType(false)

if soul == nil or soul == 0 or soul == "0" then

	ComponentSetValue2( comp_proj, "on_death_explode", false )
	ComponentSetValue2( comp_proj, "on_lifetime_out_explode", false )
	ComponentSetValue2( comp_proj, "collide_with_entities", false )
	ComponentSetValue2( comp_proj, "collide_with_world", false )
	ComponentSetValue2( comp_proj, "lifetime", 1 )

    EntityKill(entity)
else
	local comp_sprite = EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent")
	if comp_sprite ~= nil then
		ComponentSetValue2(comp_sprite, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".xml")
		EntityRefreshSprite(entity, comp_sprite)
	end

	local comp_particles = EntityGetFirstComponent(entity, "ParticleEmitterComponent") or 0

	--bat
	if soul == "bat" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2(comp_particles, "emitted_material_name", "spark_purple_bright")
		end)
	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="player_unit",
			homing_targeting_coeff=130.0,
			homing_velocity_multiplier=0.86,
		})
	
		projdamage = projdamage * 1.1
	
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	--fly
	if soul == "fly" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2(comp_particles, "emitted_material_name", "lava")
		end)
	
		EntityAddComponent2(entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/chaotic_arc.lua",
			execute_every_n_frame=2,
		} )
	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="player_unit",
			homing_targeting_coeff=130.0,
			homing_velocity_multiplier=0.86,
		})
	
		projdamage = projdamage + 0.4
		projdamage = projdamage * 1.2
	
		ComponentSetValue2( comp_proj, "damage", projdamage )
	end

	--friendly

	--gilded
	if soul == "gilded" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "gold")
		end)

		projdamage = projdamage + 0.5
		icedamage = icedamage + 0.3
		icedamage = icedamage * 2
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	--boss
	if soul == "boss" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "living_particles")
		end)

		projdamage = projdamage + 0.5
		icedamage = icedamage + 0.3
		icedamage = icedamage * 3
	
		ComponentObjectSetValue22(comp_proj, "damage_by_type", "ice", icedamage)
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	--mage
	if soul == "mage" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2(comp_particles, "emitted_material_name", "magic_liquid_mana_regeneration")
		end)
	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="player_unit",
			homing_targeting_coeff=15,
			detect_distance=300,
			homing_velocity_multiplier=1.0,
		} )
	
		projdamage = projdamage * 1.3
		
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	--orcs & zombie
	if soul == "orcs" or soul == "zombie" then
		EntityAddComponent2(entity, "SineWaveComponent", {
			_enabled=true,
			sinewave_freq=1.0,
			sinewave_m=0.6,
			lifetime=-1,
		} )
	
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "spark_green")
		end)
	
	end

	--slimes
	if soul == "slimes" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2(comp_particles, "emitted_material_name", "radioactive_liquid")
		end)
	
		icedamage = icedamage + 0.3
		icedamage = icedamage * 2
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
	end

	--spider
	if soul == "spider" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2(comp_particles, "emitted_material_name", "spark_purple")
		end)
	
		EntityAddComponent2(entity, "CellEaterComponent", {
			eat_probability=90,
			radius=1,
			ignored_material="rock_static_cursed",
			ignored_material_tag="[matter_eater_ignore_list]",
		})

		poisondamage = poisondamage + 0.15
		poisondamage = poisondamage * 1.1

		ComponentObjectSetValue2(comp_proj, "damage_by_type", "poison", poisondamage)
	end

	--worm
	if soul == "worm" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2( comp_particles, "emitted_material_name", "blood_worm")
		end)
	
		EntityAddComponent2(entity, "CellEaterComponent", {
			eat_probability=90,
			radius=4,
			ignored_material="",
			ignored_material_tag="",
		})

		meleedamage = meleedamage + 0.5
		meleedamage = meleedamage * 1.3
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", meleedamage)
	end

	--fungus
	if soul == "fungus" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "fungi")
		end)
	end

	--ghost
	if soul == "ghost" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "plasma_fading")
		end)

		EntityAddComponent2(entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/phasing_arc.lua",
			execute_every_n_frame=8,
		})
	
		icedamage = icedamage + 0.4
		--exprad = exprad * 1.5
	
		--ComponentObjectSetValue2( comp_proj, "config_explosion", "explosion_radius", exprad )
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "ice", icedamage)
	end

	--mage_corrupted
	if soul == "mage_corrupted" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "blood")
		end)
	
		EntityAddComponent2(entity, "HomingComponent", {
			target_tag="player_unit",
			homing_targeting_coeff=10,
			detect_distance=300,
			homing_velocity_multiplier=1.3,
		} )
	
		projdamage = projdamage * 1.4
		
		ComponentSetValue2(comp_proj, "damage", projdamage)
	end

	--ghost_whisp
	if soul == "ghost_whisp" then
		edit_component(entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2(comp_particles, "emitted_material_name", "fire")
		end)

		firedamage = firedamage + 0.4
		firedamage = firedamage * 1.4

		EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
			from_material_tag="burnable",
			to_material="fire",
			steps_per_frame=20,
			loop=1,
			is_circle=1,
			radius=20,
		})
	
		ComponentObjectSetValue2(comp_proj, "damage_by_type", "fire", firedamage)
	end
end