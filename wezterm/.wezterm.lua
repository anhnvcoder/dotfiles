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

-- Generate a random seed based on memory address to avoid duplicates within the same second
local seed = os.time() + tonumber(tostring({}):sub(-5), 16)
math.randomseed(seed)
-- Call random a few times to discard the initial predictable values
math.random(); math.random(); math.random()

-- Function to scan the directory for images and pick a random one
local function get_random_bg()
	local dir = user_home .. "/dotfiles/wezterm/background/"
	local pattern = "ls " .. dir .. "*.jpg " .. dir .. "*.png " .. dir .. "*.jpeg " .. dir .. "*.webp 2>/dev/null"
	local handle = io.popen(pattern)
	local result = handle:read("*a")
	handle:close()

	local images = {}
	for file in string.gmatch(result, "[^\r\n]+") do
		table.insert(images, file)
	end

	if #images > 0 then
		return images[math.random(#images)]
	else
		return dir .. "gohan.jpg" -- Fallback image if folder is empty
	end
end

-- Listen for when a new WezTerm window is created or config is reloaded
wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  
  -- If this window hasn't been assigned a background override yet (e.g., new window via Cmd+N)
  if not overrides.window_background_image then
    overrides.window_background_image = get_random_bg()
    window:set_config_overrides(overrides)
  end
end)
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

-- 4-panel layout: split current pane into 4 equal quadrants
local function four_panel_layout(win, pane)
  local right = pane:split({ direction = "Right", size = 0.5 })
  pane:split({ direction = "Down", size = 0.5 })
  right:split({ direction = "Down", size = 0.5 })
end

config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action{ SendString = "\x1b\r" } },

  -- Shortcut to randomly change the background on the fly
  {
    key = "B",
    mods = "CMD|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      overrides.window_background_image = get_random_bg()
      window:set_config_overrides(overrides)
    end),
  },

  -- Split panes in 4 directions (CMD+OPT + hjkl)
  { key = "l", mods = "CMD|OPT", action = wezterm.action.SplitPane{ direction = "Right", size = { Percent = 50 } } },
  { key = "h", mods = "CMD|OPT", action = wezterm.action.SplitPane{ direction = "Left",  size = { Percent = 50 } } },
  { key = "j", mods = "CMD|OPT", action = wezterm.action.SplitPane{ direction = "Down",  size = { Percent = 50 } } },
  { key = "k", mods = "CMD|OPT", action = wezterm.action.SplitPane{ direction = "Up",    size = { Percent = 50 } } },

  -- 4-panel layout (CMD+4)
  { key = "4", mods = "CMD", action = wezterm.action_callback(four_panel_layout) },

  -- Navigate panes (CMD+SHIFT + hjkl)
  { key = "h", mods = "CMD|SHIFT", action = wezterm.action{ ActivatePaneDirection = "Left" } },
  { key = "l", mods = "CMD|SHIFT", action = wezterm.action{ ActivatePaneDirection = "Right" } },
  { key = "k", mods = "CMD|SHIFT", action = wezterm.action{ ActivatePaneDirection = "Up" } },
  { key = "j", mods = "CMD|SHIFT", action = wezterm.action{ ActivatePaneDirection = "Down" } },

  -- Resize panes (CMD+CTRL + hjkl)
  { key = "h", mods = "CMD|CTRL", action = wezterm.action{ AdjustPaneSize = { "Left",  5 } } },
  { key = "l", mods = "CMD|CTRL", action = wezterm.action{ AdjustPaneSize = { "Right", 5 } } },
  { key = "k", mods = "CMD|CTRL", action = wezterm.action{ AdjustPaneSize = { "Up",    5 } } },
  { key = "j", mods = "CMD|CTRL", action = wezterm.action{ AdjustPaneSize = { "Down",  5 } } },

  -- Close pane
  { key = "w", mods = "CMD", action = wezterm.action{ CloseCurrentPane = { confirm = true } } },
}

return config
