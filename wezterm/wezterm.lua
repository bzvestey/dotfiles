-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set the color scheme
-- config.color_scheme = 'Dark Ocean (terminal.sexy)'
-- config.color_scheme = 'Darcula (base16)'
config.color_scheme = 'Dark Violet (base16)'

-- Set the font
config.font = wezterm.font('CascadiaCode')
config.font_size = 12

-- and finally, return the configuration to wezterm
return config
