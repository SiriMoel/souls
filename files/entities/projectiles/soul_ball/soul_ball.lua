dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")


local entity = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity )
local x, y = EntityGetTransform( entity )

local soul = GetRandomSoul()

local comp = EntityGetFirstComponent( entity, "ProjectileComponent" ) or 0
local projdamage = ComponentGetValue2( comp, "damage" )
local on_collision_die = ComponentGetValue2( comp, "on_collision_die" )
local speed_min = ComponentGetValue2( comp, "speed_min" )
local speed_max = ComponentGetValue2( comp, "speed_max" )
local bounces_left = ComponentGetValue2( comp, "bounces_left" )
local expdamage = ComponentObjectGetValue( comp, "config_explosion", "damage" )
local exprad = ComponentObjectGetValue( comp, "config_explosion", "explosion_radius" )
local cursedamage = ComponentObjectGetValue( comp, "damage_by_type", "curse" )
local meleedamage = ComponentObjectGetValue( comp, "damage_by_type", "melee" )
local icedamage = ComponentObjectGetValue( comp, "damage_by_type", "ice" )

if soul == nil or soul == 0 then
	GamePrint("You have no souls.")

	local projcomp = EntityGetFirstComponent( entity, "ProjectileComponent" ) or 0

	ComponentSetValue2( projcomp, "on_death_explode", false )
	ComponentSetValue2( projcomp, "on_lifetime_out_explode", false )
	ComponentSetValue2( projcomp, "collide_with_entities", false )
	ComponentSetValue2( projcomp, "collide_with_world", false )
	ComponentSetValue2( projcomp, "lifetime", 1 )

    EntityKill(entity)
else
	if ModSettingGet( "tales_of_kupoli.say_consumed_soul" ) then
		GamePrint( "You have consumed a " .. soul .. " soul." )
	end
	
	RemoveSoul(soul)

    local particlecomp = EntityGetFirstComponent(entity, "ParticleEmitterComponent") or 0

    --bat
    if soul == "bat" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_purple_bright" )
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
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_red" )
		end)
	
		EntityAddComponent( entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/chaotic_arc.lua",
			execute_every_n_frame="2",
		} )
	
		EntityAddComponent( entity, "HomingComponent", {
			homing_targeting_coeff="130.0",
			homing_velocity_multiplier="0.86",
		} )
	
		projdamage = projdamage + 0.4
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
			ComponentSetValue2( particlecomp, "emitted_material_name", "gold" )
		end)
		
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/curse_wither_projectile.xml",
		} )
	
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/curse_wither_melee.xml",
		} )
	
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/curse_wither_explosion.xml",
		} )
	
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/curse_wither_electricity.xml",
		} )

        projdamage = projdamage * 1.3
	
		ComponentSetValue2( comp, "damage", projdamage )
	end

    --mage
    if soul == "mage" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)		
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_blue" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff="15",
			detect_distance="300",
			homing_velocity_multiplier="1.0",
		} )
	
		cursedamage = cursedamage + 0.4
		cursedamage = cursedamage * 2
	
		ComponentObjectSetValue( comp, "damage_by_type", "curse", cursedamage )
	end

    --orcs & zombie
    if soul == "orcs" or soul == "zombie" then
	
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_green" )
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
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_green_bright" )
		end)
	
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/gravity_field_enemy.xml",
		} )
	
		icedamage = icedamage + 0.5
		icedamage = icedamage * 2
        bounces_left = bounces_left + 5
	
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
        ComponentSetValue2( comp, "bounces_left", bounces_left )
	end

    --spider
    if soul == "spider" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_purple" )
		end)
	
		EntityAddComponent( entity, "HitEffectComponent", { 
			effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
			value_string="data/entities/misc/curse_init.xml",
		} )
	
        expdamage = expdamage * 1.3
		exprad = exprad * 1.2
        projdamage = projdamage + 0.4
		projdamage = projdamage * 1.5

	
		ComponentSetValue2( comp, "damage", projdamage )
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
	end

    --worm
    if soul == "worm" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)	
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_yellow" )
		end)
	
		EntityAddComponent( entity, "CellEaterComponent", {
			eat_probability="90",
			radius="24",
			ignored_material="",
			ignored_material_tag="",
		} )

		meleedamage = meleedamage + 0.3
		meleedamage = meleedamage * 1.3
        on_collision_die = true
	
		ComponentObjectSetValue( comp, "damage_by_type", "melee", meleedamage )
        ComponentSetValue2( comp, "on_collision_die", on_collision_die)
	end

    --fungi
    if soul == "fungi" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "fungi" )
		end)
	
		expdamage = expdamage * 1.5
		exprad = exprad * 10
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
	end
end