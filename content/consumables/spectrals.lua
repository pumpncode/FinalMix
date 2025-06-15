SMODS.Consumable {
    key = 'sorcerer',
    set = 'Spectral',
	atlas = "consumabels",
    pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
	
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'Uncommon', edition = 'e_negative' })
                card:juice_up(0.3, 0.5)


				G.hand:change_size(-1)
				delay(0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}


SMODS.Consumable {
    key = 'gummiship',
    set = 'Spectral',
	atlas = "consumabels",
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { 1 } }
    end,
	
    use = function(self, card, area, copier)
        local destructable_jokers = {}
        for i = 1, #G.jokers.cards do
            if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
                table.insert(destructable_jokers, G.jokers.cards[i])
            end
        end

        local joker_to_destroy = pseudorandom_element(destructable_jokers, pseudoseed('gummiship'))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        if joker_to_destroy then
            joker_to_destroy.getting_sliced = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.0,
                func = function()
                    G.hand:change_size(1)
                    return true
                end
            }))
        end

        delay(0.5)
    end,
    can_use = function(self, card)
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.eternal and not joker.getting_sliced then return true end
        end
        return false
    end
}
