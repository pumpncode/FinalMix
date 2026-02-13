SMODS.Joker {
    name = 'Axel',
    key = 'axel',
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    rarity = 3,
    atlas = 'KHJokers',
    pos = { x = 4, y = 2 },
    cost = 8,

    discovered = true,
    blueprint_compat = false,

    config = { extra = {} },

    update = function(self, card, dt)
        local condition = false
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    condition = true
                end
            end
        end
        if condition then
            if G.consumeables and G.consumeables.cards then
                for k, v in ipairs(G.consumeables.cards) do
                    if v.config.center.set == "Planet" and not v.xiii_flipped then
                        v:flip()
                        v.xiii_flipped = true
                    end
                end
            end
            if G.pack_cards and G.pack_cards.cards then
                for k, v in ipairs(G.pack_cards.cards) do
                    if v.config.center.set == "Planet" and not v.xiii_flipped then
                        v:flip()
                        v.xiii_flipped = true
                    end
                end
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        for _, v in pairs(G.GAME.hands) do
            v.xiii_og_chips = v.xiii_og_chips or v.l_chips
            v.xiii_og_mult  = v.xiii_og_mult or v.l_mult
            v.l_chips       = v.xiii_og_chips * 1.5
            v.l_mult        = v.xiii_og_mult * 1.5
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, v in pairs(G.GAME.hands) do
            if v.xiii_og_chips then
                v.l_chips = v.xiii_og_chips
                v.l_mult  = v.xiii_og_mult
            end
        end
        if G.consumeables and G.consumeables.cards then
            for k, v in ipairs(G.consumeables.cards) do
                if v.config.center.set == "Planet" and v.xiii_flipped then
                    v:flip()
                    v.xiii_flipped = false
                end
            end
        end
    end,
}
