local cs_def = CardSleeves.Sleeve

cs_def {
    key        = 'kingdom',
    discovered = true,
    deck_buff  = 'b_kh_kingdom',
    atlas      = 'KHSleeves',
    pos        = { x = 0, y = 0 },

    loc_vars   = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_kh_kingdom" then
            key = self.key .. "_alt"
            self.config = { vouchers = { "v_overstock_plus" } }
            vars = { self.config.vouchers }
        else
            key = self.key
            self.config = { vouchers = { "v_overstock_norm" } }
            vars = { self.config.vouchers }
        end
        return { key = key, vars = vars }
    end,

    calculate  = function(self, sleeve, context)
    end
}

cs_def {
    key        = 'rechain',
    discovered = true,
    deck_buff  = 'b_kh_rechain',
    atlas      = 'KHSleeves',
    pos        = { x = 1, y = 0 },

    loc_vars   = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_kh_rechain" then
            key = self.key .. "_alt"
            self.config = { vouchers = { "v_reroll_surplus" } }
            vars = { self.config.vouchers }
        else
            key = self.key
            self.config = { vouchers = { "v_kh_moogleskip" } }
            vars = { self.config.vouchers }
        end
        return { key = key, vars = vars }
    end,

    calculate  = function(self, sleeve, context)
    end
}
