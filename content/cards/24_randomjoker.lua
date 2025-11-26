function KH.balance_percent(card, percent)
	local chip_mod = percent * hand_chips
	local mult_mod = percent * mult
	local average = (chip_mod + mult_mod) / 2
	hand_chips = hand_chips + (average - chip_mod)
	mult = mult + (average - mult_mod)

	update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
	card_eval_status_text(card, 'extra', nil, nil, nil, {
		message = (percent * 100) .. "% " .. localize('k_balanced'),
		colour = { 0.8, 0.45, 0.85, 1 },
		sound = 'gong'
	})

	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = (function()
			ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
			ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blockable = false,
				blocking = false,
				delay = 4.3,
				func = (function()
					ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
					ease_colour(G.C.UI_MULT, G.C.RED, 2)
					return true
				end)
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				blockable = false,
				blocking = false,
				no_delete = true,
				delay = 6.3,
				func = (function()
					G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2],
						G.C.BLUE[3],
						G.C.BLUE[4]
					G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3],
						G.C.RED
						[4]
					return true
				end)
			}))
			return true
		end)
	}))

	delay(0.6)
	return hand_chips, mult
end

SMODS.Joker {
	key = "randomjoker",

	loc_vars = function(self, info_queue, card)
		local r_percent = {}
		for i = card.ability.extra.min, card.ability.extra.max do
			r_percent[#r_percent + 1] = tostring(i)
		end
		loc_percent = '%'
		main_start = {
			{ n = G.UIT.T, config = { text = 'Balances ', colour = G.C.BLACK, scale = 0.32 } },
			{ n = G.UIT.O, config = { object = DynaText({ string = r_percent, colours = { G.C.PURPLE }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = '?', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent,
							loc_percent, loc_percent, loc_percent,
							{ string = '#', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent,
							{ string = '@', colour = G.C.RED },
							loc_percent, loc_percent, loc_percent },
						colours = { G.C.PURPLE },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0
					})
				}
			},

		}
		return { main_start = main_start }
	end,

	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 1, y = 5 },
	cost = 6,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,

	config = {
		extra = {
			percent = 0,
			min = 1,
			max = 25
		}
	},


	calculate = function(self, card, context)
		if context.final_scoring_step then
			card.ability.extra.percent = pseudorandom("j_kh_randomjoker", card.ability.extra.min, card.ability.extra.max)
			KH.balance_percent(card, (card.ability.extra.percent * 0.01))
		end
	end
}
