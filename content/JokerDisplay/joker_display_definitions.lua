-- TODO: Half Face (TODO), Axel (N/A), Chip and Dale (N/A)

local jd_def = JokerDisplay.Definitions

jd_def["j_kh_kairi"] = { -- Cassette
    text = {
        { text = "" },
        {
            ref_table = "card.joker_display_values",
            ref_value = "localized_text",
            
        },
    },
    calc_function = function(card)
        local side = card.ability.extra.side
        card.joker_display_values.localized_text = side == "B" and "Dark Suits" or "Light Suits"
    end,
    
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] then
            text.children[1].config.colour = card.ability.extra.side == "B" and G.C.BLUE or G.C.SUITS.Diamonds
            text.children[2].config.colour = card.ability.extra.side == "B" and G.C.BLUE or G.C.SUITS.Diamonds
        end
        return false
    end
}

-- Sora
jd_def["j_kh_sora"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("Hearts", 'suits_plural')
    end
}




-- Roxas
jd_def["j_kh_roxas"] = {
    text = {
		{ text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
    },
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.ability.extra", ref_value = "discards_remaining" },
		{ text = "/" },
		{ ref_table = "card.ability.extra",        ref_value = "discards" },
		{ text = ")" },
	},
        
}





-- Riku
jd_def["j_kh_riku"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },

    },
    calc_function = function(card)
        local chips = card.ability.extra.chips or 0
        local mult = card.ability.extra.mult or 0

        -- Store values for display, add + sign if positive
        card.joker_display_values.chips = (chips >= 0 and "+" or "") .. tostring(chips)
        card.joker_display_values.mult = (mult >= 0 and "+" or "") .. tostring(mult)
    end
}

-- Moogle
jd_def["j_kh_moogle"] = {

    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "joker_count",
            scale = 0.40,
            colour = G.C.MONEY,
            newline = true
			}	
		},
		
	reminder_text = {
		{ text = "(Round)" }
	},
	
    calc_function = function(card)
		local joker_count = 0
		if G.jokers and G.jokers.cards then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then
					joker_count = joker_count + 1
				end
			end
		end
        card.joker_display_values.joker_count = string.format("+$%d", card.ability.extra.dollars * joker_count)
    end
}
--Axel
jd_def["j_kh_axel"] = {

    text = {
        { text = "X2 Joker Values", scale = 0.35, colour = G.C.PURPLE},
		},
		
	reminder_text = {
		{ text = "(boss blind)" }
	},
	
}

	
-- Donald
jd_def["j_kh_donald"] = {
    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "copied_name",
            --scale = 1.0,
            colour = G.C.ATTENTION,
            newline = true,
        }
    },
    reminder_text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "blueprint_status",
            scale = 0.35,
            colour = G.C.BLUE,
        }
    },
    calc_function = function(card)
        local copied_joker_key = card.ability.extra.copied_joker_key
        local copied_name = "[None]"
        local blueprint_status = ""

        if G.jokers then
            local function getJokerByKey(jokers, key)
                for _, joker in ipairs(jokers) do
                    if joker.config.center.key == key then
                        return joker
                    end
                end
                return nil
            end

            local copied_joker = getJokerByKey(G.jokers.cards, copied_joker_key)
            if copied_joker then
                copied_name = copied_joker.config.center.name or "Unknown"
                blueprint_status = copied_joker.config.center.blueprint_compat and "[compatible]" or "[incompatible]"
            else
                blueprint_status = ""
            end
        end

        card.joker_display_values.copied_name = copied_name
        card.joker_display_values.blueprint_status = blueprint_status
    end
}



-- Goofy
jd_def["j_kh_goofy"] = {
    text = {
        {
            ref_table = "card.joker_display_values",
            ref_value = "current_mult",
            scale = 0.40,
            colour = G.C.MULT,
            newline = true
        }
    },
    calc_function = function(card)
        local base_mult = card.ability.extra.mult or 0
        local wild_tally = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wild_tally = wild_tally + 1
                end
            end
        end

        local current_mult = base_mult * wild_tally
        card.joker_display_values.current_mult = string.format("+%d", current_mult)
    end
}




-- Mickey
jd_def["j_kh_mickey"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
		{ text = ", "},
		{
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            },
		},

    },

	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
		
    end,
}



-- Keyblade
jd_def["j_kh_keyblade"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }
	},
	reminder_text = {
		{ text = "(7)", scale = 0.35 },
	},
	calc_function = function(card)
		local _, _, scoring_hand = JokerDisplay.evaluate_hand()
		local keyblade_eval = #scoring_hand == 1 and scoring_hand[1]:get_id() == 7
		card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
		card.joker_display_values.count = keyblade_eval and 1 or 0
	end,
	style_function = function(card, text, reminder_text, extra)
		if text and text.children[1] and text.children[2] then
			text.children[1].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
				G.C.UI.TEXT_INACTIVE
			text.children[2].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
				G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}




-- Paopu Fruit
jd_def["j_kh_paopufruit"] = {

    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Diamonds"], 0.35) },
        { text = ")" }
    },
	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }

        card.joker_display_values.localized_text = localize("Diamonds", "suits_plural")
    end
}


--sea salt ice cream

jd_def["j_kh_sealsalt"] = {
    text = {
        { text = "(Blue Seal)", scale = 0.35, colour = G.C.SECONDARY_SET.Planet},
	},
}

-- Master Yen Sid
jd_def["j_kh_disney"] = {

	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
		
    end,
}

-- Nobody

jd_def["j_kh_nobody"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit_count" },
        { text = " suits", scale = 0.35, colour = G.C.PURPLE},
		{ text = ")" },
    },
    calc_function = function(card)
        local d = card.joker_display_values
        local extra = card.ability.extra or {}

        -- Default values
        d.chips = extra.chips or 0
        d.suit_count = 0

        -- Try to evaluate upcoming or last scoring hand
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        if scoring_hand then
            local suits = {}
            for _, v in ipairs(scoring_hand) do
                if v.base and v.base.suit then
                    suits[v.base.suit] = true
                end
            end

            local unique_suits = 0
            for _ in pairs(suits) do
                unique_suits = unique_suits + 1
            end

            d.suit_count = unique_suits
        end
    end
}

-- Bryce the Nobody
jd_def["j_kh_brycethenobody"] = {

    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
        { text = ")" }
    },
	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }

        card.joker_display_values.localized_text = localize("Hearts", "suits_plural")
    end
}
