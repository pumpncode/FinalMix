local task_rewards = {

    play_face = function(card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Hand", colour = G.C.BLUE })

                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                ease_hands_played(1)

                return true
            end
        }))
        delay(0.6)
    end,

    shopping = function(card)
        G.E_MANAGER:add_event(Event({
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Shop slot", colour = G.C.BLUE })
                change_shop_size(1)
                return true
            end
        }))
    end,

    drawing = function(card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "+" .. tostring(1) .. " Hand Size", colour = G.C.BLUE })
                G.hand:change_size(1)
                return true
            end
        }))
        delay(0.6)
    end,

}

SMODS.Joker {
    key = 'helpwanted',
    name = "Help Wanted!",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "kh_play_face", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_drawing", set = "Other" }
        info_queue[#info_queue + 1] = { key = "kh_shopping", set = "Other" }
        local task_desc = "None"
        local reward_desc = "None"
        local prog = card.ability.progress

        if card.ability.current_task == "play_face" then
            task_desc = "Score 7 [" .. prog .. "]  face cards"
            reward_desc = "+1 Hand"
        elseif card.ability.current_task == "shopping" then
            task_desc = "Spend $20 [" .. prog .. "] in one shop"
            reward_desc = "+1 Shop Slot"
        elseif card.ability.current_task == "drawing" then
            task_desc = "Draw 20 [" .. prog .. "] cards in a single round"
            reward_desc = "+1 Hand Size"
        end

        return {
            vars = {
                task_desc,
                reward_desc
            }
        }
    end,

    rarity = 3,
    atlas = "KHJokers",
    pos = { x = 3, y = 4 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        current_task = nil,
        progress = 0,
        task_done = {},
    },

    calculate = function(self, card, context)
        local completed = card.ability.task_done

        if not card.ability.current_task then
            local task_pool = { "play_face", "shopping", "drawing" }


            local filtered_pool = {}
            for _, task in ipairs(task_pool) do
                if not completed[task] then
                    table.insert(filtered_pool, task)
                end
            end

            if #filtered_pool > 0 then
                card.ability.current_task = pseudorandom_element(filtered_pool, pseudoseed("tasks"))
                card.ability.progress = 0
            else
                card.ability.current_task = nil
            end

            if #filtered_pool <= 0 and not context.repetition then -- maybe also just throw $15 dollars in
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                ease_dollars(math.min(15, G.GAME.dollars), true)
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                -- Extinct Message
                SMODS.calculate_effect({ message = localize('kh_tasks_complete'), colour = G.C.FILTER }, card)
            end
        end


        if card.ability.current_task then
            local c = card.ability.current_task

            if c == "play_face" and card.ability.progress < 7 then
                if context.individual and context.cardarea == G.play and context.other_card:is_face() then
                    card.ability.progress = card.ability.progress + 1
                    SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
                end

                if card.ability.progress >= 7 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end

                    completed[task_key] = true
                    card.ability.task_done = completed

                    SMODS.calculate_effect({ message = localize('kh_complete'), colour = G.C.FILTER }, card)
                end
            end

            if c == "drawing" and card.ability.progress < 20 then
                if context.hand_drawn then
                    local drawn = #context.hand_drawn
                    card.ability.progress = card.ability.progress + drawn
                    SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
                end

                if card.ability.progress >= 20 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    task_rewards[task_key](card)

                    completed[task_key] = true
                    card.ability.task_done = completed

                    SMODS.calculate_effect({ message = localize('kh_complete'), colour = G.C.FILTER }, card)
                end

                if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                    card.ability.progress = 0
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    }
                end
            end
            if c == "shopping" then
                -- Buying a Joker
                if context.buying_card and context.card and context.card.cost then
                    card.ability.progress = card.ability.progress + context.card.cost
                    context.card.cost = 0
                end

                --Buying a booster pack
                if context.open_booster and context.card and context.card.cost then
                    card.ability.progress = card.ability.progress + context.card.cost
                    context.card.cost = 0
                end
                -- Buying a Voucher
                if context.buying_card and context.card and context.card.ability and context.card.ability.set == 'Voucher' and context.card.cost then
                    card.ability.progress = card.ability.progress + context.card.cost
                    context.card.cost = 0
                end

                -- Rerolling the shop
                if context.reroll_shop then
                    card.ability.progress = card.ability.progress + (G.GAME.current_round.reroll_cost - 1)
                end

                if card.ability.progress >= 20 then
                    local task_key = card.ability.current_task
                    card.ability.current_task = nil

                    if task_rewards[task_key] then
                        task_rewards[task_key](card)
                    end
                    card.ability.progress = 0

                    completed[task_key] = true
                    card.ability.task_done = completed

                    SMODS.calculate_effect({ message = localize('kh_complete'), colour = G.C.FILTER }, card)
                end
                -- Resetting after exit shop
                if context.ending_shop then
                    card.ability.progress = 0
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    }
                end
            end
        end
    end
}
