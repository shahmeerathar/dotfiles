local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font({ family = 'MesloLGS NF' })
config.font_size = 14
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font({ family = 'MesloLGS NF', weight = 'Bold' }),
  font_size = 14,
}

return config
