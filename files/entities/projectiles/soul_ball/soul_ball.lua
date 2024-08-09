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

local player = GetPlayer()
local wand = HeldItem(player)

local soul = GetRandomSoulForWand(wand)

if soul == nil or soul == 0 or soul == "0" then
	GamePrint("You have no souls.")

	ComponentSetValue2( comp_proj, "on_death_explode", false )
	ComponentSetValue2( comp_proj, "on_lifetime_out_explode", false )
	ComponentSetValue2( comp_proj, "collide_with_entities", false )
	ComponentSetValue2( comp_proj, "collide_with_world", false )
	ComponentSetValue2( comp_proj, "lifetime", 1 )

    EntityKill(entity)
else
	if ModSettingGet( "souls.say_consumed_soul" ) then
		GamePrint( "A " .. SoulNameCheck(soul) .. " soul has been consumed." )
	end

	RemoveSoul(soul)

	local comp_particles = EntityGetFirstComponent(entity, "ParticleEmitterComponent") or 0

    --bat
    if soul == "bat" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( comp_particles, "emitted_material_name", "spark_purple_bright" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			homing_targeting_coeff="130.0",
			homing_velocity_multiplier="0.86",
		} )
	
		projdamage = projdamage * 1.2
        speed_min = speed_min * 1.4
        speed_max = speed_max * 1.4
	
		ComponentSetValue2( comp, "damage", projdamage )
        ComponentSetValue2( comp, "speed_min", speed_min )
        ComponentSetValue2( comp, "speed_max", speed_max )
	end

    --fly
    if soul == "fly" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( comp_particles, "emitted_material_name", "lava" )
		end)
	
		EntityAddComponent( entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/chaotic_arc.lua",
			execute_every_n_frame="2",
		} )
	
		EntityAddComponent( entity, "HomingComponent", {
			homing_targeting_coeff="130.0",
			homing_velocity_multiplier="0.86",
		} )

		projdamage = projdamage + 0.2
		projdamage = projdamage * 1.4
        speed_min = speed_min * 1.2
        speed_max = speed_max * 1.2
        on_collision_die = true
	
		ComponentSetValue2( comp, "damage", projdamage )
        ComponentSetValue2( comp, "speed_min", speed_min )
        ComponentSetValue2( comp, "speed_max", speed_max )
        ComponentSetValue2( comp, "on_collision_die", on_collision_die)
	end

    --friendly

    --gilded
	if soul == "gilded" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "gold" )
		end)

		projdamage = projdamage + 0.2
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		icedamage = icedamage + 0.1
		icedamage = icedamage * 2
	
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
		ComponentSetValue2( comp, "damage", projdamage )
	end

	--boss
	if soul == "boss" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "living_partices" )
		end)

		projdamage = projdamage + 0.2
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		icedamage = icedamage + 0.1
		icedamage = icedamage * 3
	
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
		ComponentSetValue2( comp, "damage", projdamage )
	end

	--mage
	if soul == "mage" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( comp_particles, "emitted_material_name", "magic_liquid_mana_regeneration" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff="15",
			detect_distance="300",
			homing_velocity_multiplier="1.0",
		} )
	
		projdamage = projdamage * 1.3
		expdamage = expdamage * 1.3
		exprad = exprad * 0.6
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
		ComponentSetValue2( comp, "damage", projdamage )
	end

    --orcs & zombie
    if soul == "orcs" or soul == "zombie" then
	
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "spark_green" )
		end)
	
		expdamage = expdamage * 1.3
		exprad = exprad * 2
        on_collision_die = true
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
        ComponentSetValue2( comp, "on_collision_die", on_collision_die)
	end

    --slimes
    if soul == "slimes" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( comp_particles, "emitted_material_name", "radioactive_liquid" )
		end)
	
		icedamage = icedamage + 0.1
		icedamage = icedamage * 2
        bounces_left = bounces_left + 5
	
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
        ComponentSetValue2( comp, "bounces_left", bounces_left )
	end

    --spider
    if soul == "spider" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2( comp_particles, "emitted_material_name", "spark_purple" )
		end)
	
        expdamage = expdamage * 0.8
		exprad = exprad * 1.2
        projdamage = projdamage + 0.2

		ComponentSetValue2( comp, "damage", projdamage )
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )

		poisondamage = poisondamage + 0.15
		poisondamage = poisondamage * 1.3

		ComponentObjectSetValue( comp, "damage_by_type", "poison", poisondamage )
	end

    --worm
    if soul == "worm" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2( comp_particles, "emitted_material_name", "blood_worm" )
		end)
	
		EntityAddComponent( entity, "CellEaterComponent", {
			eat_probability="90",
			radius="24",
			ignored_material="",
			ignored_material_tag="",
		} )

		meleedamage = meleedamage + 0.1
		meleedamage = meleedamage * 1.3
        on_collision_die = true
	
		ComponentObjectSetValue( comp, "damage_by_type", "melee", meleedamage )
        ComponentSetValue2( comp, "on_collision_die", on_collision_die)
	end

    --fungus
    if soul == "fungus" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "fungi" )
		end)
	
		expdamage = expdamage * 1.5
		exprad = exprad * 10
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
	end

	--ghost
	if soul == "ghost" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "plasma_fading" )
		end)

		EntityAddComponent( entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/phasing_arc.lua",
			execute_every_n_frame="20",
		} )
		
		EntityAddComponent( entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/homing_area.lua",
			execute_every_n_frame="1",
		} )
	
		icedamage = icedamage + 0.2
		exprad = exprad * 1.5
	
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
	end

	--mage_corrupted
	if soul == "mage_corrupted" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "blood" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff="10",
			detect_distance="300",
			homing_velocity_multiplier="1.3",
		} )
	
		projdamage = projdamage * 1.4
		expdamage = expdamage * 1.4
		exprad = exprad * 0.75
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
		ComponentSetValue2( comp, "damage", projdamage )
	end

	--ghost_whisp
	if soul == "ghost_whisp" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( comp_particles, "emitted_material_name", "fire" )
		end)

		firedamage = firedamage + 0.1
		firedamage = firedamage * 1.4

		EntityAddComponent( entity, "MagicConvertMaterialComponent", {
			from_material_tag="burnable",
			to_material="fire",
			steps_per_frame=20,
			loop=1,
			is_circle=1,
			radius=20,
		})
	
		ComponentObjectSetValue( comp, "damage_by_type", "fire", firedamage )
	end
end