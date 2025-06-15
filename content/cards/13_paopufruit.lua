SMODS.Joker {
	key = 'paopufruit',
	loc_txt = {},
	
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1), --1
				card.ability.extra.odds --2
			}
		}
	end,
	
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 2, y = 1 },
	cost = 6,
	unlocked = true,
    discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,

	config = {
		extra = { 
			repetitions = 1,
			odds = 7
		}
	},
	

	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then -- Checks that the cards that have been played, then checks to see if it's time to check for repetition.
			if context.other_card:is_suit("Diamonds") then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = card
				}
			end
		end
		
		-- Also, not context.repetition ensures it doesn't get called during repetitions.
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			if pseudorandom('paopu') < G.GAME.probabilities.normal / card.ability.extra.odds then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				-- Extinct/Survival Message
				return {
					message = 'Riku, NO!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end
}