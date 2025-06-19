# Vim Preferred settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set rnu")
vim.opt.clipboard:append('unnamedplus')

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- Highlight Groups
vim.cmd([[
  highlight TodoKeyword ctermfg=177 guifg=#cba6f7 cterm=bold gui=bold
  highlight ErrorKeyword ctermfg=177 guifg=#cba6f7 cterm=bold gui=bold
  highlight FixmeKeyword ctermfg=177 guifg=#cba6f7 cterm=bold gui=bold 
  highlight DoxygenTag ctermfg=177 guifg=#cba6f7 cterm=bold gui=bold
]])

-- Extend your autocommand
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("TodoKeyword", "\\<\\(TODO\\|XXX\\)\\>")
    vim.fn.matchadd("ErrorKeyword", "\\<ERROR\\>")
    vim.fn.matchadd("FixmeKeyword", "\\<FIXME\\>")
    -- Highlight Doxygen tags like @brief, @param, @return, etc.
    vim.fn.matchadd("DoxygenTag", "@\\w\\+")
  end,
})

-- File Text Wrapping
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html" },
  callback = function()
    vim.opt_local.textwidth = 90
  end,
})
