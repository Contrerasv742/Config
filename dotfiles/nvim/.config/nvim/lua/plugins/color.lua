return {
    'norcalli/nvim-colorizer.lua',
    config = function()
        require('colorizer').setup({
            -- add any other filetypes you work with
            'css',
            'javascript',
            'html',
            'scss',
        }, {
            rgb = true,      -- #rgb hex codes
            rrggbb = true,   -- #rrggbb hex codes
            rrggbbaa = true, -- #rrggbbaa hex codes
            rgb_fn = true,   -- css rgb() and rgba() functions
            hsl_fn = true,   -- css hsl() and hsla() functions
            css = true,      -- enable all css features: rgb_fn, hsl_fn, names, rgb, rrggbb
            css_fn = true,   -- enable all css *functions*: rgb_fn, hsl_fn
        })
    end
}
