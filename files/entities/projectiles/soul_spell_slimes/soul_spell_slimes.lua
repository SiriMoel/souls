local this = GetUpdatedEntityID()
local amt = 0
local comps = EntityGetComponent(this, "ProjectileComponent")
if comps ~= nil then
    for _,comp in ipairs(comps) do
        amt = amt + ComponentGetValue2(comp, "damage")
        ComponentSetValue2(comp, "damage", 0)
        local damages = ComponentObjectGetMembers(comp, "damage_by_type")
        if damages ~= nil then
            for k,v in pairs(damages) do
                amt = amt + (v or 0)
                ComponentObjectSetValue2(comp, "damage_by_type", tostring(k), 0)
            end
        end
        amt = amt + (ComponentObjectGetValue2(comp, "config_explosion", "damage") or 0)
        ComponentObjectSetValue2(comp, "config_explosion", "damage", 0)
        local crit_chance = ComponentObjectGetValue2(comp, "damage_critical", "chance") or 0
        local crit_mult = ComponentObjectGetValue2(comp, "damage_critical", "damage_multiplier") or 1
        amt = amt * (1 + (crit_chance/100) * crit_mult)
	end
end
if amt > 0 then
	local comp_proj = EntityGetFirstComponent(this, "ProjectileComponent")
	if comp_proj ~= nil then
		ComponentSetValue2(comp_proj, "on_collision_die", false)
	end
	ComponentObjectSetValue2(comp_proj, "damage_by_type", "healing", -amt)
end