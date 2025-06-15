return {
    descriptions = {

		
        Back={

			b_kh_kingdom = {
				name = "Kingdom Deck",
				text = {
					"Kingdom Hearts Jokers are",
					"3X more likely to appear"
				},
			},	
		},
        Joker={
		


            j_kh_kairi_a = {
                name = 'Kairi',
                text = {
                    '{C:attention}Retrigger{} all played',
                    'cards with {C:diamonds}light suit{}'
                }
            },
            j_kh_kairi_b = {
                name= 'Naminé',
                text = {
					'{C:attention}Retrigger{} all played',
                    'cards with {C:spades}dark suit'
                    
                }
            },
            j_kh_kairi_extra = {
                text = {
                     '{C:inactive}Joker flips at end of round'
                }
            },

			
			j_kh_sora = {
				name = 'Sora',
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"For each scored {C:hearts}heart{} card, resets",
					"when {C:attention}Boss Blind{} is defeated.{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
					"{C:inactive,s:0.8}My Friends are my Power!",
				},
			},
			
			j_kh_riku = {
				name = 'Riku',
				text = {
					"Gains {C:chips}+#3#{} Chip and {C:mult}+#3#{} Mult",
					"for each scored {C:spades}Dark Suit{}",
					"Loses {C:chips}-#4#{} Chip and {C:mult}-#4#{} Mult",
					"for each scored {C:diamonds}Light Suit{}",
					"{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips, {C:mult}+#2#{}{C:inactive} Mult){}",
					"{C:inactive,s:0.8} Come to the darkness!"
				},
			},
			
			j_kh_moogle = {
				name = 'Moogle',
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"for each {C:attention}Joker{} card",
					"{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
					"{C:inactive,s:0.8} e"
				},
			},
			
			j_kh_roxas = {
				name = 'Roxas',
				text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "every {C:attention}#2#{} {C:inactive}[#3#]{} cards discarded",
                    "{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)",
					"{C:inactive,s:0.8}looks like my summer vacation is... over",
				
				},
			},
			
			j_kh_namine = {
				name = 'Naminé',
				text = {
					"{C:enhanced}Doubles{} values of leftmost {C:attention}Joker{}",
					"and applies a {C:spectral}Perishable{} sticker",
					"after defeating a {C:attention}boss blind",
					"{C:inactive}((Unstackable){}",
					"{C:inactive,s:0.8}It's me, Naminé",
				
				},
			},

			j_kh_axel = {
				name = 'Axel',
				text = {
					"{C:enhanced}Doubles{} values of leftmost {C:attention}Joker{}",
					"and applies a {C:spectral}Perishable{} sticker",
					"after defeating a {C:attention}boss blind",
					"{C:inactive,s:0.8}Got it Memorized?",
				
				},
			},

			--[[
			j_kh_axel = {
				name = 'Axel',
				text = {
					"Halves all {C:attention}listed{}",
					"{C:green,E:1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 2{}{C:inactive} -> {C:green}0.5 in 2{}{C:inactive}){} ",
					"{C:inactive,s:0.8}Got it Memorized?",
				
				},
			},
			--]]
			j_kh_donald = {
				name = 'Donald Duck',
				text = {
					"Copies the ability of a",
					"{C:attention}random Joker{} each round.",
					"{C:inactive}(Currently copying: {C:attention}#1#{C:inactive})",
					"{C:inactive,s:0.8}The Snowstorm can't get us here."
				},
			},
			
			j_kh_goofy = {
				name = "Goofy",
				text = {
					"Gives {C:mult}+#1#{} Mult",
					"for each {C:attention}wild{} card",
					"in your {C:attention}full deck{}",
					"{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive} Mult){}",
					"{C:inactive,s:0.8}Gawrsh... wait I'm a dog"
				},
			},
		
			j_kh_mickey = {
				name = 'Meeska Mooska',
				text = {
					"Every scored {C:attention}King{} has a",
					"{C:green}#1# in #2#{} chance to gain",
					"{C:chips}+#6#{} Chips and {X:mult,C:white}X#4#{} Mult",
					"{C:inactive}(Currently {C:chips}+#5#{C:inactive} Chips and {X:mult,C:white}X#3#{C:inactive} Mult )",
					"{C:inactive,s:0.8}Say Fellas, did somebody mention the Door to Darkness?"
				},
			},
			
			j_kh_disney = {
				name = 'Master Yen Sid',
				text = {
					"{C:green}#1# in #2#{} chance to",
					"upgrade level of a",
					"random {C:attention}poker hand{} when",
					"a {C:purple}Tarot{} card is used",
					"{C:inactive,s:0.8}Sora, do NOT dissappoint me.",
				},
			},			
		
			j_kh_nobody = {
				name = 'Nobody',
				text = {
					"Gains {C:chips}+#2#{} Chips per",
					"unique {C:attention}suit{} in played hand",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
					"{C:inactive,s:0.8} Nobody? Who's Nobody?",
				},
			},
		
			j_kh_keyblade = {
				name = 'Keyblade',
				text = {
					"If {C:attention}first hand{} of round is",
					"a single {C:attention}7{}, destroy it and",
					"create a {C:dark_edition}random {}{C:attention}Tag{}",
					"{C:inactive,s:0.8} May your heart be your guiding key",
				},
			},
			
			j_kh_sealsalt = {
				name = "Seal Salt Ice Cream",
				text = {
					"Cards with a {C:blue}Blue Seal{}",
					"trigger when {C:attention}scored",
					"{C:inactive,s:0.8} man, this is some good ice cream, huh?",
				},
			},

			j_kh_paopufruit = {
				name = 'Paopu Fruit',
				text = {
					"Retrigger all played {C:diamonds}Diamond{} cards",
					"{C:green}#1# in #2#{} chance this card is",
					"eaten at the end of the round",
					"{C:inactive,s:0.8} the winner gets to share a Paopu with Kairi."
				},
			},
			
			j_kh_xigbar = {
				name = "Half Face",
				text = {
					"Gives {C:chips}+#2#{} Chips for each",
					"{C:attention}face{} card in played hand",
					"that {C:attention}does not score{}",
					"{C:inactive,s:0.8}Me? I'm already half Xehanort"
				},
			},
			
			j_kh_brycethenobody = {
				name = "BryceTheNobody",
				text = {
                    "Every played {C:hearts}Heart{} card",
					"Has a {C:green}#2# in #3#{} chance",
                    "to permanently gain",
                    "{C:mult}+#1#{} Mult when scored",
					"{C:inactive,s:0.8}Glad i could help some people out"
				},
			},

			j_kh_chipanddale = {
				name = "Chip and Dale",
				text = {
                    "{C:attention}Sell{} this card",
					"to create a random",
                    "{C:green}Uncommon{} Joker",
					"{C:inactive,s:0.8}We got baaad news"
				},
			},


			
		},
		
		
        Other={

            kh_perishable = {
				name = "Perishable",
				text = {
					"Debuffed after",
					"{C:attention}5{} rounds",
				}
			},
			
			kh_unstackable = {
				name = "Unstackable",
				text = {
					"Cannot double a {C:attention}Joker{}",
					"That is {C:enhanced}perishable{}.",
				}
			},

			kh_lightsuit = {
				name = "Light Suit",
				text = {
					"{C:hearts}Hearts{} or {C:diamonds}Diamonds{}",
				}
			},

			kh_darksuit = {
				name = "Dark Suit",
				text = {
					"{C:spades}Spades{} or {C:clubs}Clubs{}",
				}
			},
			
			p_kh_khpack1 = {
				name = 'Kingdom Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:attention} Joker{} cards',
					"{C:inactive,s:0.8}It's Kingdom Hearts.",
				},
            },
			
			p_kh_khpack2 = {
				name = 'Kingdom Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:attention} Joker{} cards',
					"{C:inactive,s:0.8}It's Kingdom Hearts.",
				},
            },
			
			

		},
		
        Spectral={
		
		
			c_kh_sorcerer = {
				name = "Sorcerer",
				text = {
					"Creates a {C:dark_edition}Negative{} ",
					"{C:green}Uncommon{} {C:attention}Joker,{}",
					"{C:red}-1{} Hand Size"
				},
			},		
			
			c_kh_gummiship = {
				name = "Gummi Ship",
				text = {
					"Destroys a random",
					"{C:attention}Joker{} card,",
					"{C:green}+1{} Hand Size"
				},
			},		
		
		
		
		
		},
        Tarot={
		
			c_kh_rankedblade = {
				name = "Keyblade",
				text = {
					"Converts up to",
					"{C:attention}#1#{} selected cards",
					"into {C:dark_edition}random {}{C:attention}Ranks{}"
				},
			},		
		
		
		
		},

    },
	
	
	
	
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
		
        dictionary={	
            kh_a_side = 'Kairi',
            kh_b_side = 'Naminé',
			k_khpack = "Kingdom Pack",	
			k_khjokers_config_restart = "(requires restart)",
			k_khjokers_config_jokers = "Enable KH Jokers",
			k_khjokers_config_tarots = "Enable Tarot cards",
			k_khjokers_config_spectrals = "Enable Spectral cards",
			k_khjokers_config_booster = "Enable Booster Pack [WIP]",
			k_khjokers_incompatible = "Incompatible!",
			k_kh_spectral = '+1 Spectral',
			k_kh_compatible = "COMPATIBLE",
			k_kh_incompatible = "INCOMPATIBLE"
						
		},
		
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}