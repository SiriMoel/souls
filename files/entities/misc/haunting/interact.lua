function interacting(entity_who_interacted, entity_interacted, interactable_name)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end
    local frame_now = GameGetFrameNum()
    local spawner = EntityLoad("mods/souls/files/entities/misc/haunting/spawner.xml", x, y - (21 + 5 * math.sin(frame_now / 60)))
    EntityKill(this)
end