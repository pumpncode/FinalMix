SMODS.Joker {
    name = 'Invitation',
    key = "invitation",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
            'j_kh_invitation')
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,

    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 2, y = 5 },

    discovered = true,
    blueprint_compat = false,

    config = {
        extra = {
            base = 1,
            odds = 4,
        }
    },

    calculate = function(self, card, context)
        if context.buying_card then
            if context.card.ability.set == 'Joker' then
                if SMODS.pseudorandom_probability(card, 'invitation', card.ability.extra.base, card.ability.extra.odds, 'j_kh_invitation') then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = "Negative!", colour = G.C.DARK_EDITION })
                    context.card:set_edition("e_negative", true)
                end
            end
        end
    end
}
