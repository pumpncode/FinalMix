SMODS.Joker {
    key = "chipanddale",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
	pos = { x = 2, y = 3 },

	config = {
		 extra = {
			 creates = 1
		} 
	},

    loc_vars = function(self, info_queue, card)
    end,
	
    calculate = function(self, card, context)
        if context.selling_self and #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Uncommon',
                            --edition = 'e_negative'
                        }
                        G.GAME.joker_buffer = 0
                    return true
                end
            }))
  
        end
    end
}