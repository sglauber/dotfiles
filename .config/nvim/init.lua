local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").setup {
               -- fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = 'smart_case' },
                vimgrep_argument = { 'rg', '--smart-case' },
            }
        end,
        keys = {
            {
                "<Space>pf",
                function() require 'telescope.builtin'.find_files() end,
                desc = "Lists files in your current working directory, respects .gitignore"
            },
            {
                "<Space>fg",
                function () require 'telescope.builtin'.live_grep() end,
                desc = "Fuzzy search through the output of git ls-files command, respects .gitignore"
            },
            {
                "<C-p>",
                function () require 'telescope.builtin'.git_files() end,
                desc = "Fuzzy search through the output of git ls-files command, respects .gitignore"

            },
            {
                "<Space>ps",
                function () require 'telescope.builtin'.grep_string() end,
                desc = "Searches for the string under your cursor or selection in your current working directory"
            },
        }
    },
    {
        'rose-pine/neovim',
        lazy     = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        name     = "rosepine.nvim",
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme rose-pine]])
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        setup = function()
            require("nvim-treesitter.configs").setup {
                -- Other Treesitter configurations...
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false, -- Optional, can disable default highlighting
                },
            }
            vim.filetype.add({ pattern = { [".*/hypr/.*%.conf"] = "hyprlang" }, })
        end,
        config = function()
            vim.cmd([[TSUpdate]])
        end
    },
    {'ThePrimeagen/harpoon'},
    {'mbbill/undotree'},
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            lazy = true,
            config = false,
            init = function()
                -- Disable automatic setup, we are doing it manually
                vim.g.lsp_zero_extend_cmp = 0
                vim.g.lsp_zero_extend_lspconfig = 0
            end,
        },
        {
            'williamboman/mason.nvim',
            lazy = false,
            config = true,
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                {'L3MON4D3/LuaSnip'},
            },
            config = function()
                -- Here is where you configure the autocompletion settings.
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_cmp()

                -- And you can configure cmp even more, if you want to.
                local cmp = require('cmp')
                local cmp_action = lsp_zero.cmp_action()

                cmp.setup({
                    formatting = lsp_zero.cmp_format(),
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    })
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = {'LspInfo', 'LspInstall', 'LspStart'},
            event = {'BufReadPre', 'BufNewFile'},
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
                {'williamboman/mason-lspconfig.nvim'},
            },
            config = function()
                -- This is where all the LSP shenanigans will live
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_lspconfig()

                --- if you want to know more about lsp-zero and mason.nvim
                --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
                lsp_zero.on_attach(function(client, bufnr)
                    -- see :help lsp-zero-keybindings
                    -- to learn the available actions
                    lsp_zero.default_keymaps({buffer = bufnr})
                end)

                require('mason-lspconfig').setup({
                    ensure_installed = {},
                    handlers = {
                        lsp_zero.default_setup,
                        lua_ls = function()
                            -- (Optional) Configure lua language server for neovim
                            local lua_opts = lsp_zero.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end,
                    }
                })
            end
        }
    }
}

require("lazy").setup({ plugins }, opts)
require("lonen")
