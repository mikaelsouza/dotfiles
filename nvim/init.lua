-- map leader
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

require("lazy").setup(
    {
        {"folke/tokyonight.nvim"},
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
        {"vim-autoformat/vim-autoformat"}
    }
)

local lsp = require("lsp-zero")
lsp.preset({})
lsp.on_attach(
    function(_, bufnr)
        lsp.default_keymaps({buffer = bufnr})
    end
)
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").pyright.setup({})
require("lspconfig").lua_ls.setup(
    {
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
                    library = vim.api.nvim_get_runtime_file("", true)
                },
                telemetry = {
                    enable = true
                }
            }
        }
    }
)

lsp.setup()

vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight")
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = {"*.py", "*.rs", "*.lua"},
        group = vim.api.nvim_create_augroup("autoformat", {clear = true}),
        command = "Autoformat"
    }
)
