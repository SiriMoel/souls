dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 56

local t_w = EntityGetInRadiusWithTag( x, y, radius, "waterstone" )
local t_f = EntityGetInRadiusWithTag( x, y, radius, "brimstone" )
local t_a = EntityGetInRadiusWithTag( x, y, radius, "thunderstone" )
local t_e = EntityGetInRadiusWithTag( x, y, radius, "stonestone" )
local t_p = EntityGetInRadiusWithTag( x, y, radius, "poopstone" )

local w = (#t_w > 0)
local f = (#t_f > 0)
local a = (#t_a > 0)
local e = (#t_e > 0)
local p = (#t_p > 0)

local essences_list = ""
local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "sunbaby_essences_list" ) or 0
local comp2 = EntityGetFirstComponent( entity_id, "SpriteComponent", "sunbaby_sprite" ) or 0

local found = 0

function suninit(sun, bcount, bmax)
	EntityAddTag(sun, "sun")
	EntityAddComponent2(sun, "VariableStorageComponent", {
		_tags="sun_brilliance",
		name="sun_brilliance",
		value_int=bcount,
	})
	EntityAddComponent2(sun, "VariableStorageComponent", {
		_tags="sun_brilliance_max",
		name="sun_brilliance_max",
		value_int=bmax,
	})
	EntityAddComponent2(sun, "LuaComponent", {
		script_source_file="mods/tales_of_kupoli/files/entities/sun/eaten.lua",
		execute_every_n_frame=2,
	})
end
-- begreen
local mat1 = GetAmountOfMaterialInInventory(entity_id, "magic_liquid_hp_regeneration")
local mat2 = GetAmountOfMaterialInInventory(entity_id, "magic_liquid_hp_regeneration_unstable") * 2
local mattotal = mat1 + mat2
if mat1 ~= nil and mat2 ~= nil then
	if mattotal >= 50 and not begreen_confirmed then
		ComponentSetValue2( comp2, "image_file", "mods/tales_of_kupoli/files/entities/sun/sun_small_green.png" )
		EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
		begreen = true
		begreen_confirmed = true
		print("begreen")
	end
end

-- bered
local comp_sunkills = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "sunbaby_kills") or 0
local sunkills = ComponentGetValue2(comp_sunkills, "value_int")
if sunkills >= 30 and not bered_confirmed then
	ComponentSetValue2( comp2, "image_file", "mods/tales_of_kupoli/files/entities/sun/sun_small_red.png" )
	EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
	bered = true
	bered_confirmed = true
	print("bered")
end

-- essences
if ( comp ~= nil ) and ( comp2 ~= nil ) then
	essences_list = ComponentGetValue2( comp, "value_string" )

	if w then
		if ( string.find( essences_list, "water" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "water", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_purple.png" )
			essences_list = essences_list .. "water,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_w ) do
			EntityKill( v )
		end
	end
	
	if f then
		if ( string.find( essences_list, "fire" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "fire", true )
			EntitySetComponentsWithTagEnabled( entity_id, "fire_disable", false )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_red.png" )
			essences_list = essences_list .. "fire,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_f ) do
			EntityKill( v )
		end
	end
	
	if a then
		if ( string.find( essences_list, "air" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "air", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_blue.png" )
			essences_list = essences_list .. "air,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_a ) do
			EntityKill( v )
		end
	end
	
	if e then
		if ( string.find( essences_list, "earth" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "earth", true )
			EntitySetComponentsWithTagEnabled( entity_id, "earth_disable", false )
			local eid = EntityLoad( "data/entities/misc/loose_ground_permanent.xml", x, y )
			EntityAddChild( entity_id, eid )
			
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_green.png" )
			essences_list = essences_list .. "earth,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_e ) do
			EntityKill( v )
		end
	end
	
	if p then
		if ( string.find( essences_list, "poop" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "poop", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_orange.png" )
			essences_list = essences_list .. "poop,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_p ) do
			EntityKill( v )
		end
	end
	
	local ohno = false
	if ( string.find( essences_list, "water" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "fire" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "air" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "earth" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "poop" ) ~= nil ) then
		ohno = true
	end
	
	if ( found > 0 ) then
		EntitySetComponentsWithTagEnabled( entity_id, "sunbaby_stage_1", false )
	end
	
	if ( found > 2 ) then
		EntitySetComponentsWithTagEnabled( entity_id, "sunbaby_stage_2", false )
	end
	
	if ( found == 4 ) then
		if ohno and begreen and bered then
			EntityLoad("data/entities/animals/kupoli_bluesun_mimic.xml", x, y)
			--GamePrintImportant( "THE GLASSMAKER SEES YOU...", "" )
			--AddFlagPersistent( "progress_macrocosm" )
		elseif ohno == true then
            local sun = EntityLoad("data/entities/items/pickup/sun/newsun_dark.xml", x, y)
			--suninit(sun, 200, 250)
			GamePrintImportant( "The Dark Sun rises...", "" )
			AddFlagPersistent( "progress_darksun" )
        elseif begreen == true then
            local sun = EntityLoad("mods/tales_of_kupoli/files/entities/sun/newsun_green.xml", x, y)
			suninit(sun, 100, 300)
			GamePrintImportant( "The Vigorous Sun rises...", "" )
			AddFlagPersistent( "progress_greensun" )
		elseif bered == true then
			local sun = EntityLoad("mods/tales_of_kupoli/files/entities/sun/newsun_red.xml", x, y)
            suninit(sun, 100, 300)
			GamePrintImportant( "The Resurrecting Sun rises...", "" )
			AddFlagPersistent( "progress_redsun" )
		elseif beblue == true then
			GamePrintImportant( "hello mina", "" )
			AddFlagPersistent( "progress_bluesun" )
		else
            local sun = EntityLoad("data/entities/items/pickup/sun/newsun.xml", x, y)
            suninit(sun, 250, 500)
			GamePrintImportant( "The New Sun rises...", "" )
			AddFlagPersistent( "progress_sun" )
        end
		GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
		GameTriggerMusicEvent( "music/oneshot/dark_01", true, x, y )
		GameScreenshake( 80, x, y )
		EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
		EntityKill(entity_id)
	end
	
	ComponentSetValue2( comp, "value_string", essences_list )
end