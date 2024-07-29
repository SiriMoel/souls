dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()

local comp_proj = EntityGetFirstComponentIncludingDisabled(entity, "ProjectileComponent") or 0
local lifetime = ComponentGetValue2(comp_proj, "lifetime")
local comp_tp = EntityGetFirstComponentIncludingDisabled(entity, "TeleportProjectileComponent") or 0

if lifetime <= 10 then
    --GamePrint("a")
    --EntitySetComponentIsEnabled(entity, comp_tp, false)
    --EntityRemoveComponent(entity, comp_tp)
end

--print(comp_tp)