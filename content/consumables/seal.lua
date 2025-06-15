SMODS.Atlas {
    key = "seal_atlas",
    path = "modded_seal.png",
    px = 71,
    py = 95
}

SMODS.Seal {
    name = "luckyemblem",
    key = "luckyemblem",
    badge_colour = HEX("fab950"),
    atlas = "seal_atlas",
    pos = {x=0, y=0},
	config = {},
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Lucky Emblem',
        -- Tooltip description
        name = 'Lucky Emblem',
        text = {
                "cards with this seal are always drawn first!"
        }
    },
    
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end,

}


SMODS.Consumable {
    set = "Spectral",
    key = "honk",
	config = {
        -- How many cards can be selected.
        max_highlighted = 1,
        -- the key of the seal to change to
        extra = 'luckyemblem',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'Honk',
        text = {
            "Select {C:attention}#1#{} card to",
            "apply {C:attention}Lucky Seal{}"
        }
    },
    cost = 4,
    atlas = "KHJokers",
    pos = {x=0, y=0},
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}
--[[
SMODS.Atlas {
    key = "honk_atlas",
    path = "honk.png",
    px = 71,
    py = 95
}
--]]