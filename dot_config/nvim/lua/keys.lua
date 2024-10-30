--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<cr>]], {})

--- Toggle more plugins
map('n', '<leader>l', [[:IndentLinesToggle<CR>]], {})
map('n', '<leader>t', [[:TagbarToggle]], {})
map('n', '<leader>ff', [[:Telescope find_files hidden=true<CR>]], { noremap = true })
map('n', '<leader>fh', [[:Telescope help_tags hidden=true<CR>]], { noremap = true })
map('n', '<leader>fg', [[:Telescope live_grep hidden=true<CR>]], { noremap = true })
map('n', '<leader>fb', [[:Telescope buffers<CR>]], { noremap = true })
map('n', '<leader>cc', [[:Centerpad<CR>]], { noremap = true })

-- [[ Quality of Life ]]
map('n', '<leader>sv', [[:source $MYVIMRC<CR>]], { noremap = true })
map('n', '<leader>so', [[:luafile %]], { noremap = true })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- [[ Harpoon ]]
map('n', '<leader>hm', [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]], { noremap=true })
map('n', '<leader>hn', [[:lua require("harpoon.ui").nav_next()<CR>]], { noremap=true })
map('n', '<leader>hp', [[:lua require("harpoon.ui").nav_prev()<CR>]], { noremap=true })
map('n', '<leader>hh', [[:lua require("harpoon.mark").add_file()<CR>]], { noremap=true })

map('n', '<leader>h1', [[:lua require("harpoon.ui").nav_file(1)<CR>]], { noremap=true })
map('n', '<leader>h2', [[:lua require("harpoon.ui").nav_file(2)<CR>]], { noremap=true })
map('n', '<leader>h3', [[:lua require("harpoon.ui").nav_file(3)<CR>]], { noremap=true })
map('n', '<leader>h4', [[:lua require("harpoon.ui").nav_file(4)<CR>]], { noremap=true })

--[[ Floaterm ]]
vim.keymap.set('n', '<leader>ftk', [[:FloatermKill!<CR>]], { noremap=true })
vim.keymap.set('n', '<leader>fts', [[:FloatermShow<CR>]], { noremap=true })
vim.keymap.set('n', '<leader>fth', [[:FloatermHide<CR>]], { noremap=true })
vim.keymap.set('n', '<leader>ftp', [[:FloatermNew powershell<CR>]], { noremap=true })
vim.keymap.set('n', '<leader>ftn', [[:FloatermNext <CR>]], { noremap=true })


-- [[ LSP Mappings ]]
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end
