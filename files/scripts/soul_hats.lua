soul_hats = {
    boss = {
        func = function()
            return HasFlagPersistent("souls_sotd_quest_done")
        end,
        hat = "mods/souls/files/ui_gfx/soul_crown.png",
        offset = -3,
    },
    --[[mage = {
        func = function()
            return HasFlagPersistent("souls_phylactery_activated")
        end,
        hat = "mods/souls/files/ui_gfx/soul_wizard_hat.png",
        offset = -6,
    },]]
    friendly = {
        func = function()
            return HasFlagPersistent("souls_tome_maxed")
        end,
        hat = "mods/souls/files/ui_gfx/soul_book.png",
        offset = 4,
    },
    --[[ghost = {
        func = function()
            return HasFlagPersistent("souls_banshee_slain")
        end,
        hat = "mods/souls/files/ui_gfx/soul_mask.png",
        offset = -2,
    }]]
}