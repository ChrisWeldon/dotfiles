-- [[ vars.lua ]]

local g = vim.g
g.t_co = 256
g.mouse=0

-- Update the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path
