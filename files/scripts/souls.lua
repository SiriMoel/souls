dofile_once("mods/souls/files/scripts/utils.lua")

soul_types = {
    "bat",
    "fly",
    "friendly",
    "gilded",
    "mage",
    "orcs",
    "slimes",
    "spider",
    "zombie",
    "worm",
    "fungus",
    "ghost",
    "boss",
}

if ModIsEnabled("Apotheosis") then
    soul_types = {
        "bat",
        "fly",
        "friendly",
        "gilded",
        "mage",
        "orcs",
        "slimes",
        "spider",
        "zombie",
        "worm",
        "fungus",
        "ghost",
        "boss",
        "mage_corrupted",
        "ghost_whisp",
    }
end

-- Initialises the Souls mechanic, should only be ran once in init.lua
function SoulsInit()
    local player = GetPlayer()
    for i,v in ipairs(soul_types) do
        EntityAddComponent2(player, "VariableStorageComponent", {
            _tags="soulcount_" .. v,
            name="soulcount_" .. v,
            value_int=0,
        })
    end
end

-- Use this when printing the name of souls
function SoulNameCheck(string)
    if string == "mage_corrupted" then
        string = "corrupted mage"
    end
    if string == "ghost_whisp" then
        string = "whisp"
    end
    if string == "orcs" then
        string = "hiisi"
    end
    if string == "0" then
        string = "any"
    end
    return string
end

-- Adds souls, provide type and amount
function AddSouls(type, amount)
    local player = GetPlayer()
    local x, y = EntityGetTransform(player)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type)
    if comp == nil then return end
    local amt = ComponentGetValue2(comp, "value_int")
    if amt == -1 then return end
    ComponentSetValue2(comp, "value_int", amt + amount)
end

-- Removes a single soul
function RemoveSoul(type)
    local player = GetPlayer()
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    local amt = ComponentGetValue2(comp, "value_int")
    if amt == -1 then return end
    ComponentSetValue2(comp, "value_int", amt - 1)
end

-- Gets the amount of souls of a specific type, or "all" for all souls
---@return number
---@return boolean
function GetSoulsCount(type)
    local player = GetPlayer()
    local count = 0
    local inf = false
    if type == "all" then
        for i,v in ipairs(soul_types) do
            local amount = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0, "value_int") or 0
            if amount == -1 then
                amount = 99
                inf = true
            end
            count = count + amount
        end
    else
        count = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0, "value_int")
    end
    if count == -1 then return 99, true end
    return count, inf
end

function GetSoulsCountTrue(type) -- probably unecessary
    local player = GetPlayer()
    local count = 0
    local inf = false
    if type == "all" then
        for i,v in ipairs(soul_types) do
            local amount = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0, "value_int") or 0
            if amount == -1 then
                count = -1
                inf = true
                break
            end
            count = count + amount
        end
    else
        count = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0, "value_int")
    end
    return count, inf
end

function SetSoulsCount(type, count)
    local player = GetPlayer()
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0, "value_int", count)
end

-- Gets a random soul
function GetRandomSoul(includeboss)
    local player = GetPlayer()
    local whichtype = ""
    local whichtypes = {}
    for i,v in ipairs(soul_types) do
        if GetSoulsCount(v) > 0 then
            if includeboss == false then
                if whichtype == "boss" then
                    
                else
                    table.insert(whichtypes, v)
                end
            else
                table.insert(whichtypes, v)
            end
        end
    end
    if #whichtypes > 0 then
        whichtype = whichtypes[math.random(1, #whichtypes)]
    end
    return whichtype
end

-- GetRandomSoul() but for wands, used incase the wand is meant to only consume a specific soul type
function GetRandomSoulForWand(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type")
    if comp_whichsoul == nil then
        comp_whichsoul = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type",
            name="which_soul_type",
            value_string="0",
        })
    end
    local comp_whichsoulnumber = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type_number")
    if comp_whichsoulnumber == nil then
        comp_whichsoulnumber = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type_number",
            name="which_soul_type_number",
            value_int=1,
        })
    end
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        if (GetSoulsCount("all") - GetSoulsCount("boss")) > 0 then
            which_soul = GetRandomSoul(false)
        else
            return "0"
        end
    end
    if GetSoulsCount(which_soul) > 0 then
        return which_soul
    else
        return "0"
    end
end

-- Does the provided wand use a specific soul type or can it use any soul?
function DoesWandUseSpecificSoul(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        return false
    else
        return true
    end
end

-- What soul type does the wand use? Returns "0" if the wand does not consume a specific soul type
function GetWandSoulType(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    return which_soul
end

-- Gets a random soul type
function GetRandomSoulType(includeboss)
    local type = soul_types[math.random(1, #soul_types)]
    if includeboss then
        return type
    else
        if type == "boss" then
            type = "orcs"
        end
        return type
    end
end

-- Adds random souls
function AddRandomSouls(amount, includegilded)
    for i=1,amount do
        local type = ""
        if includegilded then
            type = soul_types[math.random(1,soultypes)]
        else
            type = soul_types[math.random(1,soultypes)]
            if type == "gilded" then
                type = "orcs"
            end
        end
        AddSouls(type, 1)
    end
end

-- Removes random souls, does not include boss souls
function RemoveRandomSouls(amount)
    for i=1,amount do
        RemoveSoul(GetRandomSoul(false))
    end
end

function ConvertHerdIdToSoul(herd_id)
    if herd_id == "player" then
        herd_id = "friendly"
    end
    if herd_id == "ant" then
        herd_id = "fly"
    end
    if herd_id == "ghost_fairy" then
        herd_id = "ghost_whisp"
    end
    if herd_id == "helpless" then
        herd_id = "friendly"
    end
    if herd_id == "fire" then
        herd_id = "mage"
    end
    if herd_id == "ice" then
        herd_id = "mage"
    end
    if herd_id == "rat" then
        herd_id = "friendly"
    end
    if herd_id == "flower" then
        herd_id = "slimes"
    end
    if herd_id == "healer" then
        herd_id = "friendly"
    end
    if herd_id == "apparition" then
        herd_id = "friendly"
    end
    if herd_id == "mage_swapper" then
        herd_id = "mage"
    end
    return herd_id
end

-- Tales' reap.lua but a function
function ReapSoul(entity, amount, random)
    local x, y = EntityGetTransform(entity)
    if #EntityGetInRadiusWithTag(x, y, 500, "player_unit") < 1 then return end
    local comp_genome = EntityGetFirstComponentIncludingDisabled(entity, "GenomeDataComponent")
    local herd_id_number = 0
    local herd_id = ""
    local herd_id_old = ""
    if comp_genome ~= nil then
        herd_id_number = ComponentGetValue2(comp_genome, "herd_id")
        herd_id = HerdIdToString(herd_id_number)
        herd_id_old = herd_id
    end
    local player = GetPlayer()
    local ok = false
    local boss = false
    herd_id = ConvertHerdIdToSoul(herd_id)
    local boss_names = {
        "$animal_maggot_tiny",
        "$animal_fish_giga",
        "$animal_boss_alchemist",
        "$animal_boss_centipede",
        "$animal_boss_ghost",
        "$animal_boss_limbs",
        "$animal_boss_meat",
        "$animal_boss_pit",
        "$animal_boss_robot",
        "$animal_islandspirit",
        "$animal_boss_wizard",
        "$animal_boss_dragon",
        "$animal_moldos_boss_soul",
        "$enemy_apotheosis_boss_musical_ghost",
        "$enemy_apotheosis_boss_toxic_worm",
        "$creep_apotheosis_boss_fire_lukki_name",
        "$creep_apotheosis_boss_flesh_monster_name",
    }
    for i,v in ipairs(boss_names) do
        if EntityGetName(entity) == v then
            ok = true
            boss = true
        end
    end
    if EntityHasTag(entity, "boss") then
        boss = true
    end
    if table.contains(soul_types, herd_id) then
        ok = true
    end
    if table.contains(boss_names, EntityGetName(entity)) then
        ok = true
    end
    if ok then
        local gilded = false
        local frame = GameGetFrameNum()
        math.randomseed(x + frame, y + frame)
        if math.random(1,15) == 10 then
            herd_id = "gilded"
        end
        if random == true then
            herd_id = GetRandomSoulType(false)
            if herd_id == "gilded" then
                if math.random(1,15) == 10 then
                    herd_id = "gilded"
                else
                    herd_id = herd_id_old
                end
            end
        end
        if boss == true then
            herd_id = "boss"
        end
        local canreap = true
        for i,v in ipairs(GameGetAllInventoryItems(player) or {}) do
            if EntityHasTag(v, "souls_deny_reap") then
                canreap = false
                break
            end
        end
        if not canreap then return end
        if tobool(GlobalsGetValue("souls.collect_soul_from_entity", "true")) then
            for i=1,amount do
                local entity_soul = EntityLoad("mods/souls/files/entities/souls/_soul.xml", x + math.random(-2, 2), y + math.random(-2, 2))
                local comp_sprite = EntityGetFirstComponentIncludingDisabled(entity_soul, "SpriteComponent")
                local comp_soul = EntityGetFirstComponentIncludingDisabled(entity_soul, "VariableStorageComponent", "soul")
                if comp_sprite ~= nil then
                    ComponentSetValue2(comp_sprite, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. herd_id .. ".xml")
                    EntityRefreshSprite(entity_soul, comp_sprite)
                end
                if comp_soul ~= nil then
                    ComponentSetValue2(comp_soul, "value_string", herd_id)
                end
            end
        else
            if tobool(GlobalsGetValue("souls.say_soul", "true")) == true then
                if amount == 1 then
                    GamePrint("You have acquired a " .. SoulNameCheck(herd_id) .. " soul!")
                else
                    GamePrint("You have acquired " .. amount .. " " .. SoulNameCheck(herd_id) .. " souls!")
                end
            end
            AddSouls(herd_id, amount)
            if EntityHasTag(player, "souls_anima_conduit") then
                local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
                if comp_damagemodel ~= nil then
                    local hp = ComponentGetValue2(comp_damagemodel, "hp")
                    local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
                    -- heals 0.25% rounding up, stronger at lower max hp, weaker at higher max hp as you get more reaping spells
                    hp = hp + math.ceil((max_hp * 0.0025))
                    if hp > max_hp then
                        hp = max_hp
                    end
                    ComponentSetValue2(comp_damagemodel, "hp", hp)
                end
            end
            if EntityHasTag(player, "souls_reap_bullet") then
                local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
                if comp_controls ~= nil then
                    local tx, ty = ComponentGetValue2(comp_controls, "mMousePosition")
                    local px, py = EntityGetTransform(player)
                    local vel_x = math.cos(0 - math.atan2(ty - py, tx - px)) * 1000.0
                    local vel_y = 0 - math.sin(0 - math.atan2(ty - py, tx - px)) * 1000.0
                    shoot_projectile(player, "data/entities/projectiles/deck/bullet_heavy.xml", px, py, vel_x, vel_y)
                end
            end
        end
    end
end

function GetRandomSoul2(x, y, frame)
    math.randomseed(x + frame, y + frame)
    local whichtype = "0"
    local whichtypes = {}
    for i=1,#soul_types do
        if GetSoulsCount(soul_types[i]) > 0 then
            table.insert(whichtypes, soul_types[i])
        end
    end
    if #whichtypes > 0 then
        whichtype = whichtypes[math.random(1, #whichtypes)]
    end
    return whichtype
end

function GetRandomSoulForWand2(wand, x, y, frame)
    math.randomseed(x + frame, y + frame)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type")
    if comp_whichsoul == nil then
        comp_whichsoul = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type",
            name="which_soul_type",
            value_string="0",
        })
    end
    local comp_whichsoulnumber = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type_number")
    if comp_whichsoulnumber == nil then
        comp_whichsoulnumber = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type_number",
            name="which_soul_type_number",
            value_int=1,
        })
    end
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        if GetSoulsCount("all") > 0 then
            which_soul = GetRandomSoul2(x, y, frame)
        else
            return "0"
        end
    end
    if GetSoulsCount(which_soul) > 0 then
        return which_soul
    else
        return "0"
    end
end

function GenerateSoulShopItem(x, y, biomeid_)
    dofile("data/scripts/gun/gun_actions.lua")
    local biomes = {
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
	local level = biomeid
    local name = ""
	biomeid = biomeid * biomeid
	item = GetRandomAction( x, y, level, 0 )
	cardcost = 0
	for i,thisitem in ipairs( actions ) do
		if string.lower(thisitem.id) == string.lower(item) then
			price = math.ceil(math.max(thisitem.price / 20, 10))
            name = thisitem.name
		end
	end
    cardcost = price
	if biomeid >= 10 then
		price = price * 5.0
		cardcost = cardcost * 5.0
	end
	local card = CreateItemActionEntity(item, x, y)
    local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")
    if comp_item == nil then print("Souls - couldn't find ItemComponent") return end
    ComponentSetValue2(comp_item, "is_pickable", false)
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
    EntityAddComponent(card, "VariableStorageComponent", {
        _tags="soulcost,soulshopitem",
        name="soulcost",
        value_int=tostring(cardcost),
    })
    EntityAddComponent(card, "InteractableComponent", {
        _tags="soulshopitem,enabled_in_world",
        radius="10",
        ui_text="PURCHASE: " .. GameTextGetTranslatedOrNot(name) .. " [" .. tostring(cardcost) .. " souls]",
        name="",
    })
    EntityAddComponent(card, "LuaComponent", {
        _tags="soulshopitem,enabled_in_world",
        script_interacting="mods/souls/files/scripts/soulshopitem_interact.lua",
    })
    EntityAddComponent(card, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world,soulshopitem",
		image_file="data/fonts/font_pixel_white.xml",
		is_text_sprite="1",
		offset_x=tostring(offsetx),
		offset_y="25", 
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(cardcost),
		z_index="-1",
	})
    EntityAddComponent(card, "SpriteComponent", { 
		_tags="enabled_in_world,soulshopitem",
		image_file="mods/souls/files/entities/souls/sprites/card_soul.xml",
		offset_x="0",
		offset_y="0",
		update_transform="1" ,
		update_transform_rotation="0",
		z_index="-1",
	})
	return card
end