SMODS.Joker {
	name = 'Meeska Mooska',
	key = 'mickey',
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge("Disney", G.C.BLUE, G.C.WHITE, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
			'mickey1')
		local numerator2, denominator2 = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra
			.odds2, 'mickey2')
		return {
			vars = {
				numerator, -- 1
				denominator, -- 2
				denominator2, --3
			}
		}
	end,

	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 3, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	config = {
		extra = {
			base = 1,
			odds = 2,
			odds2 = 4,
		}
	},

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local kings = 0
			local enhanced_cards = {}

			for _, scored_card in ipairs(context.scoring_hand) do
				if scored_card:get_id() == 13 then
					local enhancements = 0

					if SMODS.pseudorandom_probability(card, 'mickey', card.ability.extra.base, card.ability.extra.odds, 'mickey1') then
						scored_card:set_seal("Red", true)
						kings = kings + 1
						enhancements = enhancements + 1
					end

					if SMODS.pseudorandom_probability(card, 'mickey', card.ability.extra.base, card.ability.extra.odds2, 'mickey2') then
						scored_card:set_ability("m_steel", true)
						kings = kings + 1
						enhancements = enhancements + 1
					end

					if enhancements > 0 then
						table.insert(enhanced_cards, scored_card)
					end
				end
			end

			if #enhanced_cards > 0 then
				for i, enhanced_card in ipairs(enhanced_cards) do
					G.E_MANAGER:add_event(Event({
						func = function()
							enhanced_card:juice_up(0.3, 0.4)
							play_sound('card1', 0.8 + (i * 0.05), 0.8)
							return true
						end,
						delay = 0.1 * i
					}))
				end

				return {
					message = "Enhanced!",
					colour = G.C.FILTER
				}
			end
		end
	end
}
