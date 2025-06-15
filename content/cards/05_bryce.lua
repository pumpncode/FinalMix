SMODS.Joker {
    key = 'brycethenobody',
    loc_txt = {},
    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 1, y = 3 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	
    config = { 
		extra = {
			mult = 3,
			odds = 2 
		} 
	},
	
    loc_vars = function(self, info_queue, card)
        return {
			vars = {
				card.ability.extra.mult, --1
				(G.GAME.probabilities.normal or 1), --2
				card.ability.extra.odds, --3
			} 
		}			
    end,
	
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Hearts") then
				if pseudorandom('bryce') < G.GAME.probabilities.normal / card.ability.extra.odds then
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
					return {
						extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
						card = card
					}
				end
			end
		end
    end
}