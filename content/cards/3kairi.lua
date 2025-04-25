SMODS.Joker {
	key = 'kairi',
	loc_txt = {
		name = 'Kairi',
		text = {
			"Earn {C:money}$1#{} at",
			"end of round per Joker",
			"{C:inactive}(Currently {C:money}$#1#{}{C:inactive})",
		}
	},
	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 2, y = 0 },
	cost = 4,
	config = {},
	loc_vars = function(self, info_queue, card)
		local joker_count = 0
		if G.jokers and G.jokers.cards then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then
					joker_count = joker_count + 1
				end
			end
		end
		return { vars = { joker_count } }
	end,

	calc_dollar_bonus = function(self, card)
		local joker_count = 0
		if G.jokers and G.jokers.cards then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then
					joker_count = joker_count + 1
				end
			end
		end
		return joker_count
	end

}
