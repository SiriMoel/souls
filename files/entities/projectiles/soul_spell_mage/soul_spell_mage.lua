local this = GetUpdatedEntityID()
local comp_proj = EntityGetFirstComponent(this, "ProjectileComponent")
if comp_proj ~= nil then
	ComponentSetValue2(comp_proj, "on_collision_die", false)
end