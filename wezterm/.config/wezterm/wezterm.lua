-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox dark, medium (base16)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12.0
config.enable_tab_bar = false
-- config.window_close_confirmation = 'NeverPrompt'
-- disable default keybindings
config.disable_default_key_bindings = false
config.audible_bell = "Disabled"
config.enable_wayland = false
-- config.front_end = "WebGpu"
config.front_end = "OpenGL"

config.keys = {
  { key = "Return", mods = "SHIFT|CTRL", action = wezterm.action.SpawnWindow },
  { key = "PageUp", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "PageUp", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  { key = "PageDown", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "PageDown", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  -- { key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
  -- { key = "V", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

-- and finally, return the configuration to wezterm
return config
