dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card)
local parent = EntityGetParent(card)

if not EntityHasTag(root, "player_unit") then return end
if not EntityHasTag(parent, "soul_tome") then return end

local comp = EntityGetFirstComponentIncludingDisabled(parent, "VariableStorageComponent", "launcher_souls_loaded")
if comp == nil then return end

local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame")
local cooldown_frames = 10
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local frame_now = GameGetFrameNum()

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and frame_now >= cooldown_frame then
    ComponentSetValue2(comp_cd, "value_int", frame_now + cooldown_frames)
    local success, soul = SpellUseSouls(root, 1)
    if success then
        local amt = ComponentGetValue2(comp, "value_int")
        amt = amt + 1
        ComponentSetValue2(comp, "value_int", amt)
        if GlobalsGetValue("souls.say_consumed_soul", "true") == "true" then
		    local soul_name = GameTextGetTranslatedOrNot(soul_names[soul])
    		GamePrint("A " .. soul_name .. " soul was loaded. (Now: " .. amt .. ")")
        end
        local x, y = EntityGetTransform(root)
        GamePlaySound("data/audio/Desktop/animals.bank", "animals/shotgun_cock", x, y)
        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
    else
        GamePrint("You do not have enough souls for this. (1)")
    end
end