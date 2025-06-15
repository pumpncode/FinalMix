-- Function to get a Joker by its unique key from a list of Jokers.
local function getJokerByKey(jokers, key)
    for _, joker in ipairs(jokers) do
        if joker.config.center.key == key then
            return joker
        end
    end
    -- Return nil if no matching Joker is found
    return nil
end

SMODS.Joker {
    key = 'donald',
    loc_txt = {},

 
    loc_vars = function(self, info_queue, card)
        -- Fetch the key of the Joker that this card is currently copying
        local copied_joker_key = card.ability.extra.copied_joker_key
        -- Default name in case no Joker is copied
        local copied_name = "None"
        
        if G.jokers then
            -- Look for the Joker that matches the copied key
            local copied_joker = getJokerByKey(G.jokers.cards, copied_joker_key)
            -- If a match is found, update the copied_name
            if copied_joker then
                copied_name = copied_joker.config.center.name
            end
        end
        
        return {
			vars = {
				copied_name --1
			}
		}
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
        extra = { copied_joker_key = nil }  -- No Joker is copied at the start
    },

    -- Function to update the state of the Joker during the game
    update = function(self, card, dt)
        local copied_joker_key = card.ability.extra.copied_joker_key
        local is_compatible = false
        
        if G.jokers then
            local copied_joker = getJokerByKey(G.jokers.cards, copied_joker_key)
			
            if copied_joker then
                is_compatible = copied_joker.config.center.blueprint_compat
            end
        end
        
        card.ability.blueprint_compat = is_compatible and 'compatible' or 'incompatible'
    end,


    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
            
            local available_jokers = {}

            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    table.insert(available_jokers, joker)
                end
            end
            
            -- If there are available Jokers to choose from
            if #available_jokers > 0 then
                
                local random_joker = available_jokers[math.random(#available_jokers)]
                
                card.ability.extra.copied_joker_key = random_joker.config.center.key
                card:update()
                local is_compatible = random_joker.config.center.blueprint_compat

                return {
                    message = is_compatible and 'Copying!' or 'Incompatible!',
                    card = card,
                }

            else
                card.ability.extra.copied_joker_key = nil
            end

        end

        if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
            local copied_joker = getJokerByKey(G.jokers.cards, card.ability.extra.copied_joker_key)

            if copied_joker then
                -- trying to apply joker effect
                local success, effect = pcall(SMODS.blueprint_effect, card, copied_joker, context)
                -- If successful, apply effect
                if success and effect then return effect end

            end
        end
    end
}
