
local atlas_key = 'kh_atlas' -- Format: PREFIX_KEY
-- See end of file for notes
local atlas_path = 'collabs/kh_lc.png' -- Filename for the image in the asset folder
local atlas_path_hc = 'collabs/kh_hc.png' -- Filename for the high-contrast version of the texture, if existing

local suits = {'hearts', 'diamonds', 'spades'} -- Which suits to replace
local ranks = {'Jack', 'Queen', "King"} -- Which ranks to replace

local descriptions = {'Kingdom Hearts', 'Kingdom Hearts', 'Kingdom Hearts'} -- English-language description, in order of suits

-----------------------------------------------------------
-- You should only need to change things above this line --
-----------------------------------------------------------



SMODS.Atlas{  
    key = atlas_key..'_lc',
    px = 71,
    py = 95,
    path = atlas_path,
    prefix_config = {key = false}, -- See end of file for notes
}

if atlas_path_hc then
    SMODS.Atlas{  
        key = atlas_key..'_hc',
        px = 71,
        py = 95,
        path = atlas_path_hc,
        prefix_config = {key = false}, -- See end of file for notes
    }
end

for i, suit in ipairs(suits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = ranks,
        lc_atlas = atlas_key..'_lc',
        hc_atlas = (atlas_path_hc and atlas_key..'_hc') or atlas_key..'_lc',
        loc_txt = {
            ['en-us'] = descriptions[i]
        },
        posStyle = 'deck'
    }
end
