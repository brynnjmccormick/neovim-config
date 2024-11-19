vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- vim.cmd("colorscheme rose-pine")

-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.keymap.set("n", "<leader>nn", ":Lexplore %:p:h<CR>")
vim.keymap.set("n", "<leader>na", ":Lexplore<CR>")
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0

-- Telescope keybinds. Moved here because my leader wasn't correct when it was in `plugins.lua`
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help flags' })
