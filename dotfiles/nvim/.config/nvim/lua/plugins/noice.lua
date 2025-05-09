return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify", -- Optional but recommended
            opts = {
                background_colour = "#000000", -- Makes the background transparent
                timeout = 3000,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.60)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end,
                render = "default",
                stages = "fade_in_slide_out",
            },
        },
    },
    opts = {
        cmdline = {
            view = "cmdline_popup", -- Use a popup for the cmdline
            enabled = true,
            opts = { -- Options for the cmdline popup
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = "40%",
                    height = "auto",
                },
                border = {
                    style = "rounded",
                },
            },
        },
        -- Enable the preset for a cleaner command line experience
        presets = {
            bottom_search = false,     -- Set to false to use floating search
            command_palette = true,    -- Position cmdline and popupmenu together
            long_message_to_split = true,
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)
    end,
}
