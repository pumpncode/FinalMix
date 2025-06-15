function Card:set_rank(new_rank)
    local suit_prefix = string.sub(self.base.suit, 1, 1)..'_'
    
    -- Convert rank to number if it's a valid number string
    local rank_suffix = tonumber(new_rank) or new_rank

    -- Handle rank conversion manually for valid numbers (only if it's a number)
    if type(rank_suffix) == "number" then
        if rank_suffix == 10 then
            rank_suffix = 'T'
        elseif rank_suffix == 11 then
            rank_suffix = 'J'
        elseif rank_suffix == 12 then
            rank_suffix = 'Q'
        elseif rank_suffix == 13 then
            rank_suffix = 'K'
        elseif rank_suffix == 14 then
            rank_suffix = 'A'
        elseif rank_suffix < 10 then
            rank_suffix = tostring(rank_suffix)
        end
    end

    -- Set the base with the correct rank
    self:set_base(G.P_CARDS[suit_prefix..rank_suffix])
end


SMODS.Consumable({
    set = "Tarot",
    key = "rankedblade",
    config = {
        max_highlighted = 5,
    },
    loc_txt = {
    },
    loc_vars = function(self, info_queue, card)
        return {
			vars = {
				(card.ability or self.config).max_highlighted or 1
			}
		}
    end,
    atlas = "consumabels",
    pos = {x = 0, y = 0},
    cost = 4,
    discovered = true,

    use = function(self, card, area, copier)
	
        local ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}

        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted or 1) do
            local target_card = G.hand.highlighted[i]

            if target_card and target_card.set_edition then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))

                -- Apply random edition
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
					
                        -- Apply random rank using custom set_rank function
                        if target_card.set_rank then
                            local random_rank = ranks[math.random(#ranks)]
                            target_card:set_rank(random_rank)
                        end

                        return true
                    end
                }))

                delay(0.5)
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
})





----------------------------------------------
------------MOD CODE END----------------------
--[[
How can I add jokers randomly but only from a said mod ?
Cause I wanna make a tag that once skipped it adds a random joker from my mod
bepis = {"Yggdrasil","BSR"}[</>]
 — 10:38 am
local valid_pool = {}
local mod_id = "your mod id here"

for _,v in pairs(G.P_CENTER_POOLS.Joker) do
  if v.original_mod and v.original_mod.id == mod_id then valid_pool[#valid_pool+1] = v end
end

--valid_pool now only has jokers from your mod
Somethingcom515 {Seals On Every} — 10:39 am
What is the difference between center.mod and center.original_mod?
bepis = {"Yggdrasil","BSR"}[</>]
 — 10:39 am
i
dont know tbh
:3
Hellio — 10:39 am
Thank you alot and how do I use it with the add joker func
bepis = {"Yggdrasil","BSR"}[</>]
 — 10:41 am
local random_joker = pseudorandom_element(valid_pool, pseudoseed(":3"))
if random_joker then
  SMODS.add_card({key = random_joker.key})
end
--]]