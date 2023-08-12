-- leader mapping
vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

-- lazy plugin setup
require("lazy").setup {
    {"rose-pine/neovim", name = "rose-pine"},
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            {"neovim/nvim-lspconfig"},
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"}
        }
    },
    {"vim-autoformat/vim-autoformat"},
    {"nvim-treesitter/nvim-treesitter"},
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            {"nvim-lua/plenary.nvim"}
        }
    }
}

-- plugins setup
local treesitter = require("nvim-treesitter")
treesitter.setup {
    ensure_installed = {"rust", "python", "lua", "vim", "vimdoc", "query", "c"},
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highliting = false
    }
}

local rosepine = require("rose-pine")
rosepine.setup {
    variant = "moon"
}

-- general keymappings
vim.keymap.set("n", "<leader>f", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- telescope keymappings
local tsin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", tsin.find_files, {})
vim.keymap.set("n", "<leader>p", tsin.live_grep, {})
vim.keymap.set("n", "<leader>b", tsin.buffers, {})
vim.keymap.set("n", "<leader>h", tsin.help_tags, {})
vim.keymap.set("n", "<leader>g", tsin.git_files, {})
vim.keymap.set("n", "<leader>c", tsin.vim_options, {})
vim.keymap.set("n", "<leader>t", tsin.treesitter, {})

-- lsp setup
local lsp = require("lsp-zero")
lsp.preset({})
lsp.on_attach(
    function(_, bufnr)
        lsp.default_keymaps({buffer = bufnr})
    end
)

-- used lsps
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").pyright.setup {}
require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            diagnostics = {
                globals = {
                    "vim",
                    "require"
                }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            telemetry = {
                enable = true
            }
        }
    }
}

-- enable lsp
lsp.setup {}

-- general options
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd.colorscheme("rose-pine")

-- auto commands
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = {"*.py", "*.rs", "*.lua"},
        group = vim.api.nvim_create_augroup("autoformat", {clear = true}),
        command = "Autoformat"
    }
)
