dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")


local entity = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity )
local x, y = EntityGetTransform( entity )

local soul = GetRandomSoul()

local comp = EntityGetFirstComponent( entity, "ProjectileComponent" ) or 0
local projdamage = ComponentGetValue2( comp, "damage" )
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
		GamePrint( "You have consumed a " .. SoulNameCheck(soul) .. " soul." )
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
	
		ComponentSetValue2( comp, "damage", projdamage )
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
	
		ComponentSetValue2( comp, "damage", projdamage )
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
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_white" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff="15",
			detect_distance="300",
			homing_velocity_multiplier="1.0",
		} )
	
		cursedamage = cursedamage + 0.3
		cursedamage = cursedamage * 2
	
		ComponentObjectSetValue( comp, "damage_by_type", "curse", cursedamage )
	end

	--orcs & zombie
	if soul == "orcs" or soul == "zombie" then
		EntityAddComponent( entity, "SineWaveComponent", {
			_enabled="1",
			sinewave_freq="1.0",
			sinewave_m="0.6",
			lifetime="-1",
		} )
	
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "spark_green" )
		end)
	
		expdamage = expdamage * 1.2
		exprad = exprad * 2
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
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
	
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
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
	
		EntityAddComponent( entity, "CellEaterComponent", { 
			eat_probability="90",
			radius="16",
			ignored_material="rock_static_cursed",
			ignored_material_tag="[matter_eater_ignore_list]",
		} )
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

		meleedamage = meleedamage + 0.5
		meleedamage = meleedamage * 1.3
	
		ComponentObjectSetValue( comp, "damage_by_type", "melee", meleedamage )
	end

	--fungi
	if soul == "fungi" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "fungi" )
		end)
	
		expdamage = expdamage * 1.1
		exprad = exprad * 3
		
		ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
		ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )
	end

	--ghost
	if soul == "ghost" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "plasma_fading" )
		end)

		EntityAddComponent( entity, "LuaComponent", {
			script_source_file="data/scripts/projectiles/phasing_arc.lua",
			execute_every_n_frame="8",
		} )
	
		cursedamage = cursedamage + 0.2
		cursedamage = cursedamage * 2
		icedamage = icedamage + 0.1
	
		ComponentObjectSetValue( comp, "damage_by_type", "curse", cursedamage )
		ComponentObjectSetValue( comp, "damage_by_type", "ice", icedamage )
	end

	--mage_corrupted
	if soul == "mage_corrupted" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "blood" )
		end)
	
		EntityAddComponent( entity, "HomingComponent", {
			target_tag="homing_target",
			homing_targeting_coeff="10",
			detect_distance="300",
			homing_velocity_multiplier="1.3",
		} )
	
		cursedamage = cursedamage + 0.4
		cursedamage = cursedamage * 2
	
		ComponentObjectSetValue( comp, "damage_by_type", "curse", cursedamage )
	end

	--ghost_whisp
	if soul == "ghost_whisp" then
		edit_component( entity, "ParticleEmitterComponent", function(comp3,vars)
			ComponentSetValue2( particlecomp, "emitted_material_name", "fire" )
		end)
	
		cursedamage = cursedamage + 0.1
		cursedamage = cursedamage * 2
		firedamage = firedamage + 0.4
		firedamage = firedamage * 0.2

		EntityAddComponent( entity, "MagicConvertMaterialComponent", {
			from_material_tag="burnable",
			to_material="fire",
			steps_per_frame=20,
			loop=1,
			is_circle=1,
			radius=20,
		})
	
		ComponentObjectSetValue( comp, "damage_by_type", "curse", cursedamage )
		ComponentObjectSetValue( comp, "damage_by_type", "fire", firedamage )
	end
end