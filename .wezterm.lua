local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'UDEV Gothic 35NFLG'

config.color_scheme = 'Solarized (light) (terminal.sexy)'

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#268bd2',
      fg_color = '#ffffff',
    },
    inactive_tab = {
      bg_color = '#ebe3d8',
      fg_color = '#6b7a83',
    },
    inactive_tab_hover = {
      bg_color = '#fbf6e4',
      fg_color = '#6b7a83',
    },
  new_tab = {
      bg_color = '#fbf6e4',
      fg_color = '#6b7a83',
  },
  },
}

config.window_frame = {
  active_titlebar_bg = '#ebe3d8',
  inactive_titlebar_bg = '#ebe3d8',
}

config.inactive_pane_hsb = {
  saturation = 0.95,
  brightness = 0.9,
}

config.keys = {
    { key = '+', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '+', mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '-', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '-', mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '-', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
    { key = '_', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '_', mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = 'd', mods = 'SUPER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = 'd', mods = 'SUPER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = 'w', mods = 'SUPER', action = wezterm.action.CloseCurrentPane { confirm = false}, },
    { key = 'h', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },  
}

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

return config