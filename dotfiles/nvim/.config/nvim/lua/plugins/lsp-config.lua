return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "bashls",
                    "clangd",
                    "html",
                    "tailwindcss",
                    "tinymist",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")

            -- Configure Lua
            lspconfig.lua_ls.setup({ capabilities = capabilities })

            -- Configure Rust
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })

            -- Configure Bash
            lspconfig.bashls.setup({ capabilities = capabilities })

            -- Configure C/C++
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--fallback-style=llvm",
                    "--all-scopes-completion",
                },
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("compile_commands.json", "CMakeLists.txt", ".git")(fname) or vim.fn.getcwd()
                end,
            })

            -- Configure HTML
            lspconfig.html.setup({
                filetypes = { "html" },
                capabilities = capabilities,
            })

            -- Tailwind CSS LSP
            lspconfig.tailwindcss.setup({
                filetypes = { "html", "javascriptreact", "typescriptreact" },
                capabilities = capabilities, -- Add capabilities here
            })

            -- Configure Typst LSP
            lspconfig.tinymist.setup({
                capabilities = capabilities,
                filetypes = { "typst" },
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
                end,
            })

            -- Keybindings (unchanged)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
            vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
            vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
            vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
        end,
    },
}
