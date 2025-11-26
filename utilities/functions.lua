XIII = {
    funcs = {},
    REND = {}
}

-- Find position of card
function GetPos(card, area)
    for i, v in ipairs(area) do
        if v == card then
            return i
        end
    end
    return nil
end

-- Use Blockbuster API to see if cards are compatible with value manipulation or not
function CompatCheck(card, target)
    if not target or target == card then
        return false
    end

    for _, standard in pairs(Blockbuster.ValueManipulation.CompatStandards) do
        if standard.exempt_jokers and standard.exempt_jokers[target.config.center.key] then
            return false
        end
    end

    return true
end

-- Function to get a Joker by its key from a list of Jokers. (Donald)
function GetJokerByKey(jokers, key)
    for _, joker in ipairs(jokers) do
        if joker.config.center.key == key then
            return joker
        end
    end
    return nil
end

-- Function to find stuff with a specific prefix, used for Awakening Tarot and Kingdom Tag
function GetResourceWithPrefix(prefix)
    local results = {}
    for k, v in pairs(G.P_CENTERS) do
        if k:sub(1, #prefix) == prefix then
            table.insert(results, k)
        end
    end
    return results
end

-- Gets a random Poker Hand (Master Yen Sid)
function GetPokerHand()
    local poker_hands = {}
    local total_weight = 0
    for _, handname in ipairs(G.handlist) do
        if G.GAME.hands[handname].visible then
            local weight = G.GAME.hands[handname].played + 1
            total_weight = total_weight + weight
            poker_hands[#poker_hands + 1] = { handname, total_weight }
        end
    end

    local weight = pseudorandom("yensid") * total_weight
    local hand
    for _, h in ipairs(poker_hands) do
        if weight < h[2] then
            hand = h[1]
            break
        end
    end

    return hand
end

-- Gets most played Poker Hand
function MostPlayedHand()
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end
    return _handname
end

-- Reroll Button for "Help Wanted" Joker

-- Check if you have enough money to reroll
G.FUNCS.kh_can_reroll = function(e)
    local reroll_cost = 4
    local can_afford = to_big(G.GAME.dollars) >= to_big(reroll_cost)
    if can_afford then
        e.config.colour = G.C.RED
        e.config.button = 'kh_reroll'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

-- What the reroll button actually does
G.FUNCS.kh_reroll = function(e)
    local ref = e.config and e.config.ref_table
    local card = ref and ref[1]

    local reroll_cost = 4
    card.ability.current_task = nil

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            ease_dollars(-math.min(reroll_cost, G.GAME.dollars), true)
            return true
        end
    }))
end
