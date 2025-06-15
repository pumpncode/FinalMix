function getResourceWithPrefix(prefix)
    local results = {}
    for k, v in pairs(G.P_CENTERS) do
        if k:sub(1, #prefix) == prefix then
            table.insert(results, k)
        end
    end
    return results
end

SMODS.Booster{
    key = "khpack1",                      
    group_key = "k_khpack",             
    atlas = 'boosters',
    pos = {x = 2, y = 0},
    weight = 0.1,                       
    cost = 4,
    config = {extra = 3, choose = 1},   
    discovered = true,
    
    loc_txt = {
    },

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.choose, card.ability.extra} }
    end,

    -- store a temporary pool per booster open session
	create_card = function(self, card, i)
		-- Only create a pool for the current booster opening
		if not card.kh_joker_pool then
			card.kh_joker_pool = {}
			for _, k in ipairs(getResourceWithPrefix("j_kh_")) do
				if k ~= "j_kh_nobody" then
					table.insert(card.kh_joker_pool, k)
				end
			end
			-- Shuffle the pool
			for j = #card.kh_joker_pool, 2, -1 do
				local k = math.random(j)
				card.kh_joker_pool[j], card.kh_joker_pool[k] = card.kh_joker_pool[k], card.kh_joker_pool[j]
			end
		end

		-- Fallback if somehow empty
		if #card.kh_joker_pool == 0 then
			return {
				set = "Joker",
				area = G.pack_cards,
				key = "j_joker"
			}
		end

		-- Pick and remove one from the pool
		local selected_key = table.remove(card.kh_joker_pool, 1)
		return {
			set = "Joker",
			area = G.pack_cards,
			key = selected_key
		}
	end

}


SMODS.Booster{
    key = "khpack2",                      
    group_key = "k_khpack",             
    atlas = 'boosters',
    pos = {x = 1, y = 0},
    weight = 0.1,                       
    cost = 4,
    config = {extra = 3, choose = 1},   
    discovered = true,
    
    loc_txt = {
    },

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.choose, card.ability.extra} }
    end,

    -- store a temporary pool per booster open session
	create_card = function(self, card, i)
		-- Only create a pool for the current booster opening
		if not card.kh_joker_pool then
			card.kh_joker_pool = {}
			for _, k in ipairs(getResourceWithPrefix("j_kh_")) do
				if k ~= "j_kh_nobody" then
					table.insert(card.kh_joker_pool, k)
				end
			end
			-- Shuffle the pool
			for j = #card.kh_joker_pool, 2, -1 do
				local k = math.random(j)
				card.kh_joker_pool[j], card.kh_joker_pool[k] = card.kh_joker_pool[k], card.kh_joker_pool[j]
			end
		end

		-- Fallback if somehow empty
		if #card.kh_joker_pool == 0 then
			return {
				set = "Joker",
				area = G.pack_cards,
				key = "j_joker"
			}
		end

		-- Pick and remove one from the pool
		local selected_key = table.remove(card.kh_joker_pool, 1)
		return {
			set = "Joker",
			area = G.pack_cards,
			key = selected_key
		}
	end

}


