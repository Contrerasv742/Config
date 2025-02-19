return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            null_ls.builtins.formatting.stylua,       -- Lua formatter
            null_ls.builtins.formatting.clang_format, -- C/C++ formatter
            null_ls.builtins.formatting.black,        -- Python formatter
            null_ls.builtins.diagnostics.pylint,      -- Python linter
            null_ls.builtins.diagnostics.verilator,   -- Verilog linter
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
