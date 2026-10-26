function interacting(entity_who_interacted, entity_interacted, interactable_name)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    if not EntityHasTag(entity_who_interacted, "player_unit") then return end
    local comp_interactable = EntityGetFirstComponentIncludingDisabled(this, "InteractableComponent")
    if comp_interactable ~= nil then
        EntitySetComponentIsEnabled(this, comp_interactable, false)
    end
    EntitySetComponentsWithTagEnabled(this, "souls_boss_banshee_spawner", true)
end