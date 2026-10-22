dofile_once("mods/souls/files/scripts/souls.lua")
soul_catalyst_products = {
    bat = "slime",
    fly = "lava",
    friendly = "magic_liquid_charm",
    mage = "magic_liquid_protection_all",
    orcs = "alcohol",
    slimes = "silver",
    spider = "magic_liquid",
    zombie = "gunpowder_unstable",
    worm = "souls_catalyst",
    fungus = "souls_soulocin",
    ghost = "souls_haunt",
    souls_void = "void_liquid",
    boss = "magic_liquid_hp_regeneration",
    mage_corrupted = "magic_liquid_protection_all",
    ghost_whisp = "apotheosis_blood_worm_centipede",
}
local this = GetUpdatedEntityID(this)
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 2, "player_unit") or {}
if #targets > 0 then
    local player = targets[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	if comp ~= nil then
		local wand = ComponentGetValue2(comp, "mActiveItem")
        local soul = WandSoulType(wand)
        if soul_catalyst_products[soul] ~= nil then
            if SpellUseSpecificSouls(player, {[tostring(soul)]=1}) then
                SoulsPrint("A " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " soul was consumed by the catalyst.", "say_consumed_soul")
                ConvertMaterialOnAreaInstantly(x-8, y-8, 16, 16, CellFactory_GetType("souls_soul_blood_1"), CellFactory_GetType(soul_catalyst_products[soul]), false, false)
                EntityLoad("mods/souls/files/entities/misc/soul_blood_fx.xml", x, y)
            end
        end
    end
end
EntityKill(this)