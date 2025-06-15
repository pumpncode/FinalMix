SMODS.Joker {
    key = 'riku',
    loc_txt = {},
    
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "kh_lightsuit", set = "Other"}
		info_queue[#info_queue+1] = {key = "kh_darksuit", set = "Other"}
        return {
            vars = {
                card.ability.extra.chips, --1
                card.ability.extra.mult, --2
				card.ability.extra.dark, --3
				card.ability.extra.light --4
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 4, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = {
        extra = { 
			chips = 0,
			mult = 0,
			dark = 2,
			light = 1
		}
    },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:is_suit('Clubs') or context.other_card:is_suit('Spades') then
					-- Gain Chips and Mult
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.dark
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.dark
				return {
					message = 'Upgraded!',
					colour = G.C.GREEN,
					card = card
				}
				

            elseif context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds') then
                --Reset Chips/Mult
				card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.light
				card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.light
			
				return {
					message = 'Nope!',
					colour = G.C.MONEY,
					card = card,
				}
			end
        end

        -- Show Chips/Mult underneath Joker
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}