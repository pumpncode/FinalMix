local function get_poker_hand()
  local poker_hands = {}
  local total_weight = 0
  for _, handname in ipairs(G.handlist) do
    if G.GAME.hands[handname].visible then
      local weight = G.GAME.hands[handname].played + 1
      total_weight = total_weight + weight
      poker_hands[#poker_hands + 1] = { handname, total_weight }
    end
  end

  local weight = pseudorandom("yensid") * total_weight
  local hand
  for _, h in ipairs(poker_hands) do
    if weight < h[2] then
      hand = h[1]
      break
    end
  end

  return hand
end


SMODS.Joker {
	key = 'disney',
	
	loc_txt = {
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1), -- 1
				card.ability.extra.odds,            -- 2
			}
		}
	end,

	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 0, y = 3 },
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = { 
			odds = 3
		}
	},
	
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable and  context.consumeable.ability.set == 'Tarot' and not context.blueprint then
			if pseudorandom('yensid' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra.odds then
				local hand = get_poker_hand()
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_level_up_ex"),
					colour = G.C.GREEN,
				})

				update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
					handname = localize(hand, "poker_hands"),
					chips = G.GAME.hands[hand].chips,
					mult = G.GAME.hands[hand].mult,
					level = G.GAME.hands[hand].level,
				})

				level_up_hand(card, hand)

				delay(0.1)
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = "", level = "" }
				)
			end
		end
	end		
}



--[[

local function create_consumable(joker, type, seed, key, message, color)
    --[[if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then -- checks space in consumable slots
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex") -- gives a "No Space!" message if there isn't any space
        })
        return
    end--
	
	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = "before",
        delay = 0.0,
        func = function()
            local card = create_card(type, G.consumeables, nil, key, seed)
            card:add_to_deck()
			card:set_edition("e_negative", true)
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
            return true
        end
    }))
	
    card_eval_status_text(joker, "extra", nil, nil, nil, {
        message = localize("k_plus_planet"),
        colour = G.C.SECONDARY_SET.Planet
    })
end
SMODS.Joker {
	key = 'disney',
	
	loc_txt = {
	},

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		return {
			vars = {
				(G.GAME.probabilities.normal or 1), -- 1
				card.ability.extra.odds,            -- 2
			}
		}
	end,

	rarity = 1,
	atlas = 'KHJokers',
	pos = { x = 0, y = 3 },
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	config = {
		extra = { 
			odds = 2
		}
	},
	
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable and  context.consumeable.ability.set == 'Tarot' and not context.blueprint then
			if pseudorandom('yensid' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra.odds then
				create_consumable(card, "Planet", "k_plus_planet")	
			end
		end
	end		
}
--]]
