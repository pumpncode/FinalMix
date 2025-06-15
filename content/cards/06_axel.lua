-- set custom globals
XIII = {
    funcs = {
        --- Credit to Aikoyori for this function, and RenSnek for expanding it. Given a `table_in` (value table or card object) and a config table, modifies the values in `table_in` depending 
        --- on the `config` provided. `config` accepts these values:
        --- * `add`
        --- * `multiply`
        --- * `keywords`: list of specific values to change in `table_in`. If nil, change every value in `table_in`.
        --- * `unkeywords`: list of specific values to *not* change in `table_in`.
        --- * `x_protect`: if true (or not set), any X effects (Xmult, Xchips, etc.) whose value is currently 1 are not modified. If false, this check is bypassed - which may result in some unlisted values being 
        --- modified.
        --- * `reference`: initial values for the provided table. If nil, defaults to `table_in`.
        --- 
        --- This function scans all sub-tables for numeric values, so it's recommended to pass the card's ability table rather than the entire card object.
        ---@param table_in table|Card
        ---@param config table
        mod_card_values = function (table_in, config)
            if not config then config = {} end
            local add = config.add or 0
            local multiply = config.multiply or 1
            local keywords = config.keywords or {}
            local unkeyword = config.unkeywords or {}
            local x_protect = config.x_protect or true -- If true and a key starts with x_ and the value is 1, it won't multiply
            local reference = config.reference or table_in
            local function modify_values(table_in, ref)
                for k,v in pairs(table_in) do -- For key, value in the table
                    if type(v) == "number" then -- If it's a number
                        if (keywords[k] or (XIII.REND.table_true_size(keywords) < 1)) and not unkeyword[k] then -- If it's in the keywords, OR there's no keywords and it isn't in the unkeywords
                            if ref and ref[k] then -- If it exists in the reference
                                if not (x_protect and (XIII.REND.starts_with(k,"x_") or XIII.REND.starts_with(k,"h_x_")) and ref[k] == 1) then
                                    table_in[k] = (ref[k] + add) * multiply -- Set it to (reference's value + add) * multiply
                                end
                            end
                        end
                    elseif type(v) == "table" then -- If it's a table
                        modify_values(v, ref[k]) -- Recurse for values in the table
                    end
                end
            end
            if table_in == nil then
                return
            end
            modify_values(table_in, reference)
        end,

        --- Calls `mod_card_values` to multiply `card`'s values by `mult`, making sure to also modify the nominal value.
        ---@param card table|Card
        ---@param mult number
        xmult_playing_card = function(card, mult)
            local tablein = {
                nominal = card.base.nominal,
                ability = card.ability
            }

            XIII.funcs.mod_card_values(tablein, {multiply = mult})

            card.base.nominal = tablein.nominal
            card.ability = tablein.ability
        end,
    },
}

-- couple util funcs nabbed from https://github.com/RenSnek/Balatro-Rendoms :33 (nested into XIII to avoid compatibility issues)
XIII.REND = {}

--- Credit to RenSnek. Given a string `str` and a shorter string `start`, checks if the string's first `#start` characters are the same as `start`.
---@param str string
---@param start string
---@return boolean
XIII.REND.starts_with = function(str,start)
    return str:sub(1, #start) == start
end

--- Credit to RenSnek. Given a `table` and a `value`, returns true if `value` is found in `table`.
--[[
---@param table table
---@param value any
---@return boolean
XIII.REND.table_contains = function(table,value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end
--]]
--- Credit to RenSnek. Given a table, returns a more accurate estimate of its size than the `#` operator.
---@param table table
---@return number
XIII.REND.table_true_size = function(table)
    local n = 0
    for k,v in pairs(table) do
        n = n+1
    end
    return n
end


SMODS.Joker{
    key = 'axel',
    atlas = 'KHJokers',
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 2 },
    config = { 
        extra = {},
        multiplier = 2,
        exclude_list = { -- List of incompatible Jokers
            ["Shoot the Moon"] = true,
            ["Castle"] = true,
            ["Constellation"] = true,
            ["Flash Card"] = true,
            ["Obelisk"] = true,
            ["Runner"] = true,
            ["Square Joker"] = true,
            ["Spare Trousers"] = true,
            ["Vampire"] = true,
            ["Wee Joker"] = true,
            ["Yorick"] = true,
            ["Invisible Joker"] = true,
            ["Madness"] = true,
            ["Popcorn"] = true, 
            ["Rough Gem"] = true,
            ["Marble Joker"] = true, 
            ["Perkeo"] = true, 
            ["Blueprint"] = true, 
            ["Brainstorm"] = true, 
            ["Business Card"] = true,
            ["Astronomer"] = true,
            ["Oops! All 6s"] = true,
            ["Pareidolia"] = true,
            ["Riff Raff"] = true,
            ["j_kh_axel"] = true,
            ["j_kh_sealsalt"] = true
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "kh_perishable", set = "Other"}
        info_queue[#info_queue+1] = {key = "kh_unstackable", set = "Other"}

        if card.area and card.area == G.jokers then
            local target = G.jokers.cards[1]
            local compatible = target and target ~= card and not target.ability.perishable and not self.config.exclude_list[target.ability.name]
            -- Compatibility indicator UI element

            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { 
                                ref_table = card, 
                                align = "m", 
                                colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), 
                                r = 0.05, 
                                padding = 0.06 
                            },
                            nodes = {
                                { 
                                    n = G.UIT.T, 
                                    config = { 
                                        text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', 
                                        colour = G.C.UI.TEXT_LIGHT, 
                                        scale = 0.32 * 0.8 
                                    } 
                                },
                            }
                        }
                    }
                }
            }
            return { vars = {}, main_end = main_end }
        end

        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss  then
            
            local target = G.jokers.cards[1] -- makes target the leftmost joker
            if not target or target == card or target.ability.perishable then return end

            local is_excluded = self.config.exclude_list[target.ability.name]

            local unkeywords = {
                odds = true, Xmult_mod = true, mult_mod = true, chips_mod = true,
                extra = true, hand_add = true, discard_sub = true, h_mod = true,
                size = true, chip_mod = true, h_size = true, increase = true
            }

            XIII.funcs.mod_card_values(target.ability, {
                multiply = is_excluded and 1 or self.config.multiplier,
                x_protect = true,
                unkeywords = unkeywords
            })

            if not is_excluded and not target.ability.perishable then
                SMODS.Stickers["perishable"]:apply(target, true)
            end

            return {
                message = is_excluded and localize("k_khjokers_incompatible") or localize("k_upgrade_ex"),
                colour = is_excluded and G.C.RED or G.C.GREEN,
                card = card
            }
        end
    end
}