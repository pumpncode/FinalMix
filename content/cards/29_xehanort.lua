SMODS.Joker {
    name = 'Master Xehanort',
    key = "xehanort",
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge("Organisation XIII", G.C.BLACK, G.C.WHITE, 1.0)
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,

    rarity = 2,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 1, y = 6 },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            last_played = "",
            mult = 0,
            mult_gain = 5,
        }
    },
    calculate = function(self, card, context)
        if context.press_play then
            card.ability.extra.last_played = G.GAME.last_hand_played
        end
        if context.joker_main then
            if card.ability.extra.last_played ~= context.scoring_name then
                SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            else
                if card.ability.extra.mult > 0 then
                    card.ability.extra.mult = 0
                    SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
                end
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}
