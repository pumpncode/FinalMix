SMODS.Joker {
    key = 'xigbar',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,

    rarity = 1,
    atlas = 'KHJokers',
    pos = { x = 1, y = 2 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
			chips = 0,
            chips_gain = 130
        }
    },

	calculate = function(self, card, context)

        if context.cardarea == G.jokers and context.before and not context.blueprint then
            count = 0
            for k, v in ipairs(context.scoring_hand) do
                 v.scoring = true
            end

			for k, v in ipairs(context.full_hand) do
				if not v.scoring and v:is_face() then
					count = count + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end,
					}))
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = tostring(count),
				        colour = G.C.PURPLE,--G.C.DARK_EDITION,
					})
				end
			end

            for k, v in ipairs(context.scoring_hand) do
                 v.scoring = nil
            end
        end

		if context.joker_main then

			card.ability.extra.chips = count * card.ability.extra.chips_gain

			return {
				chips = card.ability.extra.chips
			}
		end
	end

}
--[[
local function non_scoring_face_cards(full_hand, scoring_hand)
    local non_scoring = {}
    local scoring_set = {}
	
    for _, card in ipairs(scoring_hand) do
        scoring_set[card] = true
    end

    for _, card in ipairs(full_hand) do
        if not scoring_set[card] and card:is_face() then
            table.insert(non_scoring, card)
        end
    end

    return non_scoring
end

SMODS.Joker {
    key = 'xigbar',
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
    end,

    rarity = 1,
    atlas = 'KHJokers',
    pos = { x = 1, y = 2 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
			chips = 0,
            chips_gain = 130
        }
    },

	calculate = function(self, card, context)
		if context.joker_main then
			local nonscoring_faces = non_scoring_face_cards(context.full_hand, context.scoring_hand)
			card.ability.extra.chips = #nonscoring_faces * card.ability.extra.chips_gain

			return {
				chips = card.ability.extra.chips
			}
		end
	end

}
--]]