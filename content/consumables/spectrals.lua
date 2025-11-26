SMODS.Consumable {
    key = "sorcerer",
    set = "Spectral",
    discovered = true,
    config = {
        max_highlighted = 1,
        extra = 'kh_luckyemblem',
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[(card.ability or self.config).extra]
        return { vars = { (card.ability or self.config).max_highlighted } }
    end,

    atlas = "KHConsumeables",
    pos = { x = 1, y = 0 },
    cost = 4,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                    return true
                end
            }))

            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}
SMODS.Consumable {
    key = "kingdom",
    set = "Spectral",
    discovered = true,
    config = {
        max_highlighted = 1,
        extra = 'kh_kingdom',
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[(card.ability or self.config).extra]
        return { vars = { (card.ability or self.config).max_highlighted } }
    end,

    atlas = "KHConsumeables",
    pos = { x = 3, y = 0 },
    cost = 4,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                    return true
                end
            }))

            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

SMODS.Consumable {
    key = 'gummiship',
    discovered = true,
    set = 'Spectral',
    atlas = "KHConsumeables",
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { 1 } }
    end,

    use = function(self, card, area, copier)
        local destructable_jokers = {}
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
                destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
            end
        end
        local joker_to_destroy = pseudorandom_element(destructable_jokers, 'kh_mickey')

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
            local rarity = joker_to_destroy.config.center.rarity
            if rarity == 1 then
                rarity = "Common"
            elseif rarity == 2 then
                rarity = "Uncommon"
            elseif rarity == 3 then
                rarity = "Rare"
            elseif rarity == 4 then
                rarity = "Legendary"
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        rarity = rarity
                    }
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.eternal and not joker.getting_sliced then return true end
        end
        return false
    end
}
