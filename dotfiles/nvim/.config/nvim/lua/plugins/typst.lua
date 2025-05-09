return {
    -- Add Typst preview plugin
    {
        "chomosuke/typst-preview.nvim",
        lazy = false,
        ft = "typst",
        config = function()
            require("typst-preview").setup({
                -- Set up the preview command
                open_cmd = nil, -- Use default system browser
                -- You can customize these options as needed
                debug = false,
                -- Set a different port if needed
                port = 0, -- Random port
            })

            -- Add Ctrl-P keybinding for preview
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "typst",
                callback = function()
                    -- Map Ctrl-P to toggle preview
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "n",
                        "<leader>tp",
                        "<cmd>TypstPreview<CR>",
                        { noremap = true, silent = true, desc = "Toggle Typst Preview" }
                    )
                end,
            })
        end,
        -- Ensure dependencies are installed
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },

    -- Add Typst syntax support
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
}
