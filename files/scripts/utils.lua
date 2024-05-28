dofile_once("data/scripts/lib/utilities.lua")

function flipbool(boolean) -- the real function flipbool()
    return not boolean
end

---@param bool boolean
---this is the greatest function of all time, it flips a boolean. true -> false and false -> true.
function flipboolean(bool) -- honestly quite incredible.
    if string.sub(tostring(bool), 1, 1) == "t" then
        bool = false
        return bool
    elseif string.sub(tostring(bool), 1, 1) == "f" then
        bool = true
        return bool
    end
end

function GetPlayer()
    local player = EntityGetWithTag("player_unit")[1]
    return player
end


function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function SetFileContent(toset, content)
    ModTextFileSetContent(toset, ModTextFileGetContent("mods/tales_of_kupoli/files/set/" .. content))
end

function IsInRadiusOf(xa, ya, xb, yb, radius) -- i dont think this works, isnt needed anyway.
    if xa - xb < radius and ya - yb < radius then
        return true
    end
    return false
end

---@param entity_id integer
---@param material_name string
---@return number
function GetAmountOfMaterialInInventory(entity_id, material_name) -- stolen from https://github.com/Priskip/purgatory
    local amount = 0
    local mat_inv_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent") or 0
    local count_per_material_type = ComponentGetValue2(mat_inv_comp, "count_per_material_type")

    for i,v in ipairs(count_per_material_type) do
        if v ~= 0 then
            if CellFactory_GetName(i - 1) == material_name then
                amount = v
            end
        end
    end

    return amount
end

function GiveBrilliance(comp, comp_max, amount)
    --[[local comp_amount = ComponentGetValue2(comp, "value_int")
    local comp_max_amount = ComponentGetValue2(comp_max, "value_int")
    comp_amount = comp_amount + amount
    if comp_amount > comp_max_amount then
        comp_amount = comp_max_amount
    end
    ComponentSetValue2(comp, "value_int", comp_amount)]]--
end

function TransferBrilliance(from_comp, to_comp, to_comp_max, amount)
    --[[local from_comp_amount = ComponentGetValue2(from_comp, "value_int")
    local to_comp_amount = ComponentGetValue2(to_comp, "value_int")
    local to_max = ComponentGetValue2(to_comp_max, "value_int")

    to_comp_amount = to_comp_amount + amount
    from_comp_amount = from_comp_amount - amount
    if to_comp_amount > to_comp_max then
        to_comp_amount = to_max
        --EntityInflictDamage(GetPlayer(), 10, "DAMAGE_PHYSICS_BODY_DAMAGED", "THE UNMATCHED POWER OF THE SUN", "DISINTERGRATED", 0, 0)
    end
    ComponentSetValue2(to_comp, "value_int", to_comp_amount)
    ComponentSetValue2(from_comp, "value_int", from_comp_amount)]]--
end

function weapon_rngstats(weapon, x, y, statsm)
    local ac = EntityGetComponent( weapon, "AbilityComponent" )[1]
    math.randomseed(x, y+GameGetFrameNum())
    if ac ~= nil then
        local sm = (math.random( 100, (statsm * 100) )) / 100

        local sm_rt = math.random(sm * 0.8, sm * 1.2)
        local sm_frw = math.random(sm * 0.8, sm * 1.2)
        local sm_mcs = math.random(sm * 0.8, sm * 1.2)
        local sm_mm = math.random(sm * 0.8, sm * 1.2)

        local acs = EntityGetComponentIncludingDisabled( weapon, "AbilityComponent" )

        if acs == nil then return end
        for i,ac in ipairs(acs) do
            local rt = tonumber( ComponentObjectGetValue( ac, "gun_config", "reload_time" ) ) -- reload time
            local frw = tonumber( ComponentObjectGetValue( ac, "gunaction_config", "fire_rate_wait" ) ) -- fire rate wait
            local mcs = tonumber( ComponentGetValue2( ac, "mana_charge_speed" ) ) -- mana charge speed
            local mm = tonumber( ComponentGetValue2( ac, "mana_max" ) ) -- mana max
            local cap = tonumber( ComponentObjectGetValue( ac, "gun_config", "deck_capacity" ) ) -- deck capacity 

            if GameHasFlagRun("kupoli_better_weapons") then
                rt = rt * 0.6
                frw = frw * 0.6
                mcs = mcs * 1.6
                mm = mm * 1.6
                cap = math.ceil(cap * 1.6)
            end

            rt = math.floor( ( rt / (sm_rt * 0.8) + 0.5 ) )
            frw = math.floor( ( frw / (sm_frw * 0.8) + 0.5 ) )
            mcs = math.floor( ( mcs * (sm_mcs * 0.7) + 0.5 ) )
            mm = math.floor( ( mm * (sm_mm * 0.7) + 0.5 ) )

            ComponentObjectSetValue( ac, "gun_config", "reload_time", tostring(rt) )
            ComponentObjectSetValue( ac, "gunaction_config", "fire_rate_wait", tostring(frw) )
            ComponentSetValue2( ac, "mana_charge_speed", mcs )
            ComponentSetValue2( ac, "mana_max", mm )
            ComponentObjectSetValue( ac, "gun_config", "deck_capacity", tostring(cap) )
        end
    end
end

function GetMoney()
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    return money
end

function SetMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    ComponentSetValue2(comp_wallet, "money", amount)
end

function CanAfford(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    if money >= amount then
        return true
    else
        return false
    end
end

---@param spent boolean if the player's money_spent should be increased.
function ReduceMoney(amount, spent)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    local moneyspent = ComponentGetValue2(comp_wallet, "money_spent")
    if CanAfford(amount) == false then
        GamePrint("You cannot afford that.")
        return
    end
    money = money - amount
    ComponentSetValue2(comp_wallet, "money", money)
    if spent == true then
        moneyspent = moneyspent + amount
        ComponentSetValue2(comp_wallet, "money_spent", moneyspent)
    end
end

function AddMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    money = money + amount
    ComponentSetValue2(comp_wallet, "money", money)
end

-- copi code
--- ### Gets the current card entity.
--- ***
--- @param wand integer The wand to inspect, should match held wand. Use `current_wand(shooter)` to get.
--- @return integer|nil card The *Entity ID* of the card being played.
local current_card = function (wand)
    local wand_actions = EntityGetAllChildren(wand) or {}
    for j = 1, #wand_actions do
        local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
        if itemcomp then
            if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                return wand_actions[j]
            end
        end
    end
    return nil
end

function currentcard(wand) -- version of the copi code that makes my brain happy
    local wand_actions = EntityGetAllChildren(wand) or {}
    for i=1,#wand_actions do
        local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[i], "ItemComponent")
        if itemcomp then
            if ComponentGetValue2(itemcomp,"mItemUid") == current_action.inventoryitem_id then
                return wand_actions[i]
            end
        end
    end
end

function HeldItem(player)
    local comp_inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
    local held_item = ComponentGetValue2(inv_comp, "mActiveItem")
    return held_item
end

dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )


-- cardcost = tostring(math.max(40, cardcost + math.random(-4,4) * 10))

function generate_shop_item( x, y, cheap_item, biomeid_, is_stealable, costs_souls )
	-- this makes the shop items deterministic
	SetRandomSeed( x, y )

	local biomes =
	{
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 1,
		[5] = 1,
		[6] = 1,
		[7] = 2,
		[8] = 2,
		[9] = 2,
		[10] = 2,
		[11] = 2,
		[12] = 2,
		[13] = 3,
		[14] = 3,
		[15] = 3,
		[16] = 3,
		[17] = 4,
		[18] = 4,
		[19] = 4,
		[20] = 4,
		[21] = 5,
		[22] = 5,
		[23] = 5,
		[24] = 5,
		[25] = 6,
		[26] = 6,
		[27] = 6,
		[28] = 6,
		[29] = 6,
		[30] = 6,
		[31] = 6,
		[32] = 6,
		[33] = 6,
	}


	local biomepixel = math.floor(y / 512)
	local biomeid = biomes[biomepixel] or 0
	
	if (biomepixel > 35) then
		biomeid = 7
	end
	
	if (biomes[biomepixel] == nil) and (biomeid_ == nil) then
		print("Unable to find biomeid for chunk at depth " .. tostring(biomepixel))
	end
	
	if (biomeid_ ~= nil) then
		biomeid = biomeid_
	end

	if( is_stealable == nil ) then
		is_stealable = false
	end

	local item = ""
	local cardcost = 0

	-- Note( Petri ): Testing how much squaring the biomeid for prices affects things
	local level = biomeid
	biomeid = biomeid * biomeid

	item = GetRandomAction( x, y, level, 0 )
	cardcost = 0

	for i,thisitem in ipairs( actions ) do
		if ( string.lower( thisitem.id ) == string.lower( item ) ) then
			price = math.max(math.floor( ( (thisitem.price * 0.30) + (70 * biomeid) ) / 10 ) * 10, 10)
			cardcost = price
			
			if ( thisitem.spawn_requires_flag ~= nil ) then
				local flag = thisitem.spawn_requires_flag
				
				if ( HasFlagPersistent( flag ) == false ) then
					print( "Trying to spawn " .. tostring( thisitem.id ) .. " even though flag " .. tostring( flag ) .. " not set!!" )
				end
			end
		end
	end
	
	if( cheap_item ) then
		cardcost = 0.5 * cardcost
	end
	
	if ( biomeid >= 10 ) then
		price = price * 5.0
		cardcost = cardcost * 5.0
	end

	local eid = CreateItemActionEntity( item, x, y )

	if( cheap_item ) then
		EntityLoad( "data/entities/misc/sale_indicator.xml", x, y )
	end

	-- local x, y = EntityGetTransform( entity_id )
	-- SetRandomSeed( x, y )
	
	local offsetx = 6
	local text = tostring(cardcost)
	local textwidth = 0
	
	for i=1,#text do
		local l = string.sub( text, i, i )
		
		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	
	offsetx = textwidth * 0.5 - 0.5
	-- shop_item_pickup2.lua

    if cost_souls then
        
    else
        EntityAddComponent( eid, "SpriteComponent", { 
            _tags="shop_cost,enabled_in_world",
            image_file="data/fonts/font_pixel_white.xml", 
            is_text_sprite="1", 
            offset_x=tostring(offsetx), 
            offset_y="25", 
            update_transform="1" ,
            update_transform_rotation="0",
            text=tostring(cardcost),
            z_index="-1",
            } )
    
        local stealable_value = "0"
        if( is_stealable ) then 
            stealable_value = "1"
        end
        
        EntityAddComponent( eid, "ItemCostComponent", { 
            _tags="shop_cost,enabled_in_world", 
            cost=cardcost,
            stealable=stealable_value
        } )
            
        EntityAddComponent( eid, "LuaComponent", { 
            script_item_picked_up="data/scripts/items/shop_effect.lua",
        } )
    end
end

function generate_shop_wand( x, y, cheap_item, biomeid_ )
	-- this makes the shop items deterministic
	SetRandomSeed( x, y )

	local biomes =
	{
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 1,
		[5] = 1,
		[6] = 1,
		[7] = 2,
		[8] = 2,
		[9] = 2,
		[10] = 2,
		[11] = 2,
		[12] = 2,
		[13] = 3,
		[14] = 3,
		[15] = 3,
		[16] = 3,
		[17] = 4,
		[18] = 4,
		[19] = 4,
		[20] = 4,
		[21] = 5,
		[22] = 5,
		[23] = 5,
		[24] = 5,
		[25] = 6,
		[26] = 6,
		[27] = 6,
		[28] = 6,
		[29] = 6,
		[30] = 6,
		[31] = 6,
		[32] = 6,
		[33] = 6,
	}


	local biomepixel = math.floor(y / 512)
	local biomeid = biomes[biomepixel] or 0
	
	if (biomes[biomepixel] == nil) then
		print("Unable to find biomeid for chunk at depth " .. tostring(biomepixel))
	end
	if (biomeid_ ~= nil) then
		biomeid = biomeid_
	end

	if( biomeid < 1 ) then biomeid = 1 end
	if( biomeid > 6 ) then biomeid = 6 end

	local item = "data/entities/items/"

	local r = Random(0,100)
	if( r <= 50 ) then 
		item = item .. "wand_level_0"
	else
		item = item .. "wand_unshuffle_0"
	end

	item = item .. tostring(biomeid) .. ".xml"

	
	-- Note( Petri ): Testing how much squaring the biomeid for prices affects things
	biomeid = (0.5 * biomeid) + ( 0.5 * biomeid * biomeid )
	local wandcost = ( 50 + biomeid * 210 ) + ( Random( -15, 15 ) * 10 )

	if( cheap_item ) then
		wandcost = 0.5 * wandcost
	end

	if( cheap_item ) then
		EntityLoad( "data/entities/misc/sale_indicator.xml", x, y )
	end
	
	local offsetx = 6
	local text = tostring(wandcost)
	local textwidth = 0
	
	for i=1,#text do
		local l = string.sub( text, i, i )
		
		if ( l ~= "1" ) then
			textwidth = textwidth + 6
		else
			textwidth = textwidth + 3
		end
	end
	
	offsetx = textwidth * 0.5 - 0.5

	-- local x, y = EntityGetTransform( entity_id )
	-- SetRandomSeed( x, y )
	local eid = EntityLoad( item, x, y )

	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml",
		is_text_sprite="1",
		offset_x=tostring(offsetx),
		offset_y="25",
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(wandcost),
		z_index="-1"
	} )

	EntityAddComponent( eid, "ItemCostComponent", { 
		_tags="shop_cost,enabled_in_world", 
		cost=wandcost,
		stealable="1"
	} )
		
	EntityAddComponent( eid, "LuaComponent", { 
		script_item_picked_up="data/scripts/items/shop_effect.lua"
	} )

end