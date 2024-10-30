local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local mux = wezterm.mux

-- Config goes here

config.default_cwd = "C:\\Users\\adm16015577\\"
config.default_prog = {'C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\powershell.exe'}

-- Theme 
local colors_moon= require('lua/rose-pine-moon').colors()
local window_frame_moon = require('lua/rose-pine-moon').window_frame()

local colors_dawn= require('lua/rose-pine-dawn').colors()
local window_frame_dawn = require('lua/rose-pine-dawn').window_frame()

config.color_scheme = 'rose-pine-moon' -- Pre defined, colors for later use are also defined in /lua
config.colors=colors_moon
config.window_frame=window_frame_moon
config.window_background_opacity = .9
config.text_background_opacity = 1.0
--config.window_background_gradient = {
  --colors = { colors.background, colors.ansi[4] },
  --Specifices a Linear gradient starting in the top left corner.
  --orientation = { Linear = { angle = 45 } },
--}
config.font = wezterm.font 'FiraCode Nerd Font Mono'


-- Keys
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

wezterm.on('gui-startup', function(cmd)

end)


wezterm.on('toggle-theme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.colors_scheme then
    -- Disable the titlebar
    overrides.colors_scheme = 'rose-pine-dawn'
    overrides.colors=colors_dawn
    overrides.window_frame=window_frame_dawn
  else
    -- remove override and use globally configured value
    overrides.colors_scheme = nil
    overrides.colors=nil
    overrides.window_frame=nil
  end
  window:set_config_overrides(overrides)
end)

wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.5
    overrides.text_background_opacity = 0.5
  else
    overrides.window_background_opacity = nil
    overrides.text_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

config.keys = {
    {
        key = 'c',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = 'o',
        mods = 'LEADER',
        action = wezterm.action.EmitEvent'toggle-opacity'
    },
    {
        key = 'g',
        mods = 'LEADER',
        action = wezterm.action.EmitEvent'toggle-theme'
    }
}

return config

