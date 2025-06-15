SMODS.Joker {
    key = 'nobody',

    loc_txt = {
    },

    loc_vars = function(self, info_queue, card)
        return {
			vars = {
				card.ability.extra.chips, --1
				card.ability.extra.bonuschips
			}
		}
    end,

    rarity = 4,
    atlas = 'KHJokers',
    pos = { x = 0, y = 1 },
	soul_pos = { x = 0, y = 2 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
	eternal = false,
    perishable_compat = true,

    config = {
        extra = {
            chips = 0,
            bonuschips = 13
        }
    },

    calculate = function(self, card, context)
        -- Only calculate new chips at the start of scoring
        if context.before and context.cardarea == G.jokers and not context.blueprint then --and G.GAME.current_round.hands_played == 0 then
                local suits = {}
                for _, v in ipairs(context.scoring_hand) do
                    suits[v.base.suit] = true
                end

                local unique_suits = 0
                for _ in pairs(suits) do
                    unique_suits = unique_suits + 1
                end

                local total_chips = unique_suits * card.ability.extra.bonuschips
                card.ability.extra.chips = card.ability.extra.chips + total_chips

                return {
                    message = '+'..total_chips,
                    colour = G.C.CHIPS
                }
            
        end

        -- Give chips when Joker is used
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}