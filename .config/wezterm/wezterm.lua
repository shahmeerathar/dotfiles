local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font({ family = 'MesloLGS NF' })
config.font_size = 14
config.window_background_opacity = 1
config.macos_window_background_blur = 20
config.window_decorations = 'TITLE | RESIZE'
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font({ family = 'MesloLGS NF', weight = 'Bold' }),
  font_size = 14,
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.initial_rows = 32
config.initial_cols = 120

config.window_close_confirmation = 'NeverPrompt' 

config.keys = {
    {
      key="LeftArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bb"}
    },
    {
      key="RightArrow",
      mods="OPT",
      action=wezterm.action{SendString="\x1bf"}
    }
}

config.alternate_buffer_wheel_scroll_speed = 1

config.max_fps = 120
return config
