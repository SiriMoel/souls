local this = GetUpdatedEntityID(this)
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 30, "player_unit") or {}
if #targets > 0 then
    local player = targets[1]
    ConvertMaterialOnAreaInstantly(x-25, y-25, 50, 50, CellFactory_GetType("souls_haunt"), CellFactory_GetType("souls_soul_particles"), false, false)
    local targets2 = EntityGetInRadiusWithTag(x, y, 35, "souls_mat_haunt") or {}
    if #targets2 > 0 then
        for i = 1, #targets2 do
            EntityKill(targets2[i])
        end
    end
    EntityLoad("mods/souls/files/entities/misc/haunting/entity.xml", x, y - 16)
end
EntityKill(this)