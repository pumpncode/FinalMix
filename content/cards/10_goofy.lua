SMODS.Joker {
    key = "goofy",
    loc_txt = {},

    loc_vars = function(self, info_queue, card)
        local wild_tally = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wild_tally = wild_tally + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * wild_tally
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 2, y = 2 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            mult = 7
        }
    },

    calculate = function(self, card, context)
        if context.joker_main and G.playing_cards then
            local wild_tally = 0
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wild_tally = wild_tally + 1
                end
            end
            return {
                mult = card.ability.extra.mult * wild_tally
            }
        end
    end
}
