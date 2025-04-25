SMODS.Joker {
    key = 'donald',
    
    loc_txt = {
        name = 'Donald',
        text = {
            "Copies the ability of a",
            "{C:attention}random Joker{} each round.",
            "{C:inactive}(Currently copying: {C:attention}#1#{C:inactive})"
        }
    },

    loc_vars = function(self, info_queue, card)
        local name = (card.ability.extra.joker and card.ability.extra.joker.config.center.name) or "None"
        return { vars = { name } }
    end,

    rarity = 3,
    atlas = 'KHJokers',
    pos = { x = 4, y = 0 },
    cost = 8,
	unlocked = true,
	discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = { joker = nil }
    },

    update = function(self, card, dt)
        -- Check blueprint compatibility of current copied joker
        if card.ability.extra.joker and card.ability.extra.joker.config.center.blueprint_compat then
            card.ability.blueprint_compat = 'compatible'
        else
            card.ability.blueprint_compat = 'incompatible'
        end
    end,

    calculate = function(self, card, context)
        -- Set new random Joker when setting Blind (new round)
        if context.setting_blind and not context.blueprint then
            if #G.jokers.cards > 1 then
                local other
                repeat
                    other = G.jokers.cards[math.random(#G.jokers.cards)]
                until other ~= card
                card.ability.extra.joker = other
                card:update()
				local is_compatible = other.config.center.blueprint_compat
				
                return {
                    message = is_compatible and 'Copying!' or 'Incompatible!',
                    card = card,
                }
            else
                card.ability.extra.joker = nil
            end
        end

        -- Apply copied effect
        if card.ability.extra.joker and not card.debuff then
            local ret = SMODS.blueprint_effect(card, card.ability.extra.joker, context)
            if ret then return ret end
        end
    end
}
