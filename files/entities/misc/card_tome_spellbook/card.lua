local card = GetUpdatedEntityID()
local tome = EntityGetParent(card)
if tome == nil or not EntityHasTag(tome, "soul_tome") then return end
local root = EntityGetRootEntity(card) -- player, right?
if not EntityHasTag(root, "player_unit") then return end
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 12
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")

local comp_ca = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_attack") or 0
local ca = tonumber(ComponentGetValue(comp_ca, "value_string"))

local comp_item = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent")

local x, y = EntityGetTransform(root)

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    ca = ca + 1
    if ca > 3 then
        ca = 1
    end
    if ca == 1 then -- tome shot
        GamePrint("Casting: " .. GameTextGetTranslatedOrNot("$souls_tome_spell_shot"))
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_shot.png")
    end
    if ca == 2 then -- tome seek
        GamePrint("Casting: " .. GameTextGetTranslatedOrNot("$souls_tome_spell_seek"))
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_seek.png")
    end
    if ca == 3 then -- tome bomb
        GamePrint("Casting: " .. GameTextGetTranslatedOrNot("$souls_tome_spell_bomb"))
        ComponentSetValue2(comp_item, "ui_sprite", "mods/souls/files/ui_gfx/gun_actions/tome_bomb.png")
    end
    ComponentSetValue2(comp_ca, "value_string", tostring(ca))
    ComponentSetValue2(comp_cd, "value_int", GameGetFrameNum() + cooldown_frames)
    GamePlaySound("data/audio/Desktop/misc.bank", "misc/telekinesis/grab_complete", x, y)
end