local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require('lazy').setup({
    --[[
        "vhyrro/luarocks.nvim",
        priority = 1001,
        config = true,
        opts = {
            "lua-utils"
        }
    },
    {
        "nvim-neorg/neorg",
        dependencies = {"luarocks.nvim"},
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = function()
            require('neorg').setup({

            })
        end,
    }, ]]--
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy='false',
        priority=1000,
        opts = {
            -- @usage 'auto'|'main'|'moon'|'dawn'
            variant = 'auto',
            -- @usage 'main'|'moon'|'dawn'
            dark_variant = 'moon',
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = false,
            disable_float_background = false,
            disable_italics = false,

            -- @usage string hex value or named color from rosepinetheme.com/palette
            groups = {
                background = 'base',
                background_nc = '_experimental_nc',
                panel = 'surface',
                panel_nc = 'base',
                border = 'highlight_med',
                comment = 'muted',
                link = 'iris',
                punctuation = 'subtle',

                error = 'love',
                hint = 'iris',
                info = 'foam',
                warn = 'gold',

                headings = {
                    h1 = 'iris',
                    h2 = 'foam',
                    h3 = 'rose',
                    h4 = 'gold',
                    h5 = 'pine',
                    h6 = 'foam',
                }
                -- or set all headings at once
                -- headings = 'subtle'
            },

            -- Change specific vim highlight groups
            -- https://github.com/rose-pine/neovim/wiki/Recipes
            highlight_groups = {
                ColorColumn = { bg = 'rose' },

                -- Blend colours against the "base" background
                CursorLine = { bg = 'foam', blend = 10 },
                StatusLine = { fg = 'love', bg = 'love', blend = 10 },

                -- By default each group adds to the existing config.
                -- If you only want to set what is written in this config exactly,
                -- you can set the inherit option:
                Search = { bg = 'gold', inherit = false },
            }
        },
        init=function()
            vim.cmd([[colorscheme rose-pine]])
        end
    },
    { "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "gc", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "gh", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "K",  function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            end)
            lsp.setup()
            vim.diagnostic.config { virtual_text = true }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "json",
                    "json5",
                    "markdown",
                    "vim",
                    "vimdoc",
                    "query",
                    "javascript",
                    "typescript",
                    "html"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
        end,
    },
    'ThePrimeagen/harpoon',
    {
        'christoomey/vim-tmux-navigator',
        lazy = false
    },
    {
        'rainbowhxch/beacon.nvim',
        lazy = false,
        opts = {
            enable = true,
            size = 40,
            fade = true,
            minimal_jump = 10,
            show_jumps = true,
            focus_gained = false,
            shrink = true,
            timeout = 300,
            ignore_buffers = {},
            ignore_filetypes = {},
        }
    },
    {
        'voldikss/vim-floaterm',                        -- Floating Terminal
        event = "VeryLazy",
        keys = {
            {"<leader>dnt",[[
                <cmd>FloatermNew! --autoclose=0 --position=bottomright --width=0.7 --disposable dotnet build<CR>
                powershell.exe <CR>
                Import-Module .\bin\Debug\netstandard2.0\PitRelMgmt.psd1 <CR>
            ]], desc="Dotnet Test Window"}
        },
        config = function()
            vim.g.floaterm_borderchars = {'─', "│", "─","│","╭", "╮", "╯", "╰"}
        end
    },
    'mhinz/vim-startify',
    {
        'nvim-lualine/lualine.nvim',                     -- statusline
         dependencies =
            {
                'kyazdani42/nvim-web-devicons',
                opt = true
            }
    },
    {                                               -- Fuzzy Finder
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {

    },
    'majutsushi/tagbar',                       -- code structure
    {
        "lukas-reineke/indent-blankline.nvim", -- lines showing nesting
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    'tpope/vim-fugitive',                      -- git integration
    'junegunn/gv.vim',                          -- commit history
    'windwp/nvim-autopairs',
    'psliwka/vim-smoothie',                      -- Smooth Scrolling
    'NvChad/nvim-colorizer.lua',
    'smithbm2316/centerpad.nvim',              -- Centering Buffer
    {                                              -- Surrounding editing
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    'mfussenegger/nvim-jdtls',
    {
        'christoomey/vim-tmux-navigator',
        lazy = false
    },

    -- Lazy.nvim
    {
      'xvzc/chezmoi.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require("chezmoi").setup {
            --  e.g. ~/.local/share/chezmoi/*
            edit = {
                watch = true,
            },
            notification = {
                on_watch = true,
            },
        }
      end
    },

})
