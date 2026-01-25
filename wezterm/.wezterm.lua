local wezterm = require("wezterm")
local config = wezterm.config_builder()
local os = require("os")
local brightness = 0.008

-- image setting
local user_home = os.getenv("HOME")

config.window_background_image_hsb = {
	-- Darken the background image by reducing it
	brightness = brightness,
	hue = 1.0,
	saturation = 0.8,
}

-- default background
local bg_image = user_home .. "/dotfiles/wezterm/background/gohan.jpg"

config.window_background_image = bg_image
-- end image setting

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 13

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.window_background_opacity = 0.9
config.macos_window_background_blur = 85
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
  {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
  -- Split panes
  {key="d", mods="CMD", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  {key="d", mods="CMD|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  -- Navigate panes (Cmd+Shift + hjkl)
  {key="h", mods="CMD|SHIFT", action=wezterm.action{ActivatePaneDirection="Left"}},
  {key="l", mods="CMD|SHIFT", action=wezterm.action{ActivatePaneDirection="Right"}},
  {key="k", mods="CMD|SHIFT", action=wezterm.action{ActivatePaneDirection="Up"}},
  {key="j", mods="CMD|SHIFT", action=wezterm.action{ActivatePaneDirection="Down"}},
  -- Resize panes (Cmd+Ctrl + hjkl)
  {key="h", mods="CMD|CTRL", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  {key="l", mods="CMD|CTRL", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
  {key="k", mods="CMD|CTRL", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  {key="j", mods="CMD|CTRL", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  -- Close pane
  {key="w", mods="CMD", action=wezterm.action{CloseCurrentPane={confirm=true}}},
}

return config
