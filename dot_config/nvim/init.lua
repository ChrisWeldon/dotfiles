# WARNING! If you want to edit your nvimrc to effect all machines, edit .chezmoitemplates/nvim/init.lua-- [[init.lua]]

-- LEADER
-- Remap of leader keys
--

vim.g.mapleader = "'"
vim.g.localleader = "\\"

require("vars") -- VARIABLES: Defined in lua/vars.lua
require("opts") -- OPTIONS: Defined in lua/opt.lua
require("keys") -- KEYBINDINGS: Defined in lua/keys.lua
require("workflow") -- WORKFLOW: Things for specific workflows at work and home
require("plug-lazy") -- PLUGINS: Defined in lua/plug.lua

-- Powershell command configuring
local lsp_zero = require('lsp-zero')

require("mason").setup()
-- jdtls (java lang server) isnt really supported by mason, dunno why. Manually configured in file specific file
require("mason-lspconfig").setup({
    ensure_installed = {'tsserver','eslint', 'lua_ls', 'powershell_es', 'csharp_ls'},
    handlers = {
        lsp_zero.default_setup,
        -- handle language servers here
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        tsserver = function()
            -- setup tsserver however
            require('lspconfig').tsserver.setup({})
        end,
        csharp_ls = function()
            -- setup tsserver however
            require('lspconfig').csharp_ls.setup({})
        end,
        powershell_es = function()
            local PSES_BUNDLE_PATH = vim.fn.stdpath('data') .. "\\mason\\packages\\powershell-editor-services\\"
            local SESSION_TEMP_PATH = vim.fn.stdpath('cache')
            local powershell_es_command = "%s\\Start-EditorServices.ps1 -BundledModulesPath %s -LogPath %s\\logs.log -SessionDetailsPath %s\\session.json -FeatureFlags @() -AdditionalModules @() -HostName 'My Client' -HostProfileId 'myclient' -HostVersion 0.0.0 -LogLevel Normal"

            -- Windows Powershell and Powershell are slightly different. LSP involks the generic Powershell
            require("lspconfig").powershell_es.setup({
                bundle_path = PSES_BUNDLE_PATH,
                shell = 'powershell'
            })
        end,
    }
})


-- lua_ls used to be sumneko_lua

-- local cmp = require('cmp') -- for completion
vim.cmd([[colorscheme rose-pine]])

require("lualine").setup({
    options = {
        theme = "rose-pine",
    }
})

vim.cmd([[colorscheme rose-pine]])

require('telescope').load_extension('harpoon') -- not entirely sure why these need to integrate TODO
require('telescope').load_extension('chezmoi') -- handles searching through config file

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
    callback = function(ev)
        print("WATCHING THIS BUFFER")
        local bufnr = ev.buf
        local edit_watch = function()
            require("chezmoi.commands.__edit").watch(bufnr)
        end
        vim.schedule(edit_watch)
    end,
})

vim.cmd("highlight Beacon guibg=black ctermbg=15")

require("nvim-autopairs").setup({})
require("nvim-surround").setup({})
require("colorizer").setup({})
