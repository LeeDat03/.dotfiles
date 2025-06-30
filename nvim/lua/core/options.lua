vim.cmd("let g:netrw_liststyle = 3")
vim.g.have_nerd_font = true

-- No saved history
vim.opt.shada = ""

-- Turn off unused features in neovim for better performance
-- vim.opt.langmenu = "none"
--vim.g.loaded_netrwPlugin = 1
--vim.g.loaded_matchparen = 1
--vim.g.loaded_gzip = 1
--vim.g.loaded_tarPlugin = 1
--vim.g.loaded_zipPlugin = 1
--vim.g.loaded_matchit = 1

-- sync clipboard vim and os
vim.opt.clipboard = "unnamedplus"

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true
opt.linebreak = true
opt.textwidth = 80

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 10
opt.inccommand = "split"
