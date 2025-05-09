return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    -- Map 'mp' to open MarkdownPreview
    vim.keymap.set('n', 'mp', ':MarkdownPreview<CR>', {noremap = true, silent = true})
}
