-- Init
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Save what OS we are on for later
local isMac = wezterm.target_triple:find("darwin")

-- Starting window size
config.initial_cols = 120
config.initial_rows = 60

-- Font conf
config.font_size = isMac and 16 or 12
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })

-- Color scheme
config.color_scheme = "Gruvbox dark, hard (base16)"

-- Hide tab bar - tmux does this for me
config.enable_tab_bar = false

-- Wayland doesn't support window decorations yet, so force x on linux
config.enable_wayland = not isMac and false

-- Configure CMD vs CTRL behavior
-- On OSX, use CMD for all terminal based commands
-- On Linux, stick with the default CTRL
-- Ex: Kill process - OSX: CMD+C | Linux: CTRL+C
-- Heavily inspired by [this comment](https://github.com/wezterm/wezterm/discussions/2754#discussioncomment-4195055)
if isMac then
	local maps = {}
	local chars = [[`1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./]]
	for char in chars:gmatch(".") do
		for _, modifier in ipairs({ "CMD", "CMD|SHIFT" }) do
			table.insert(maps, {
				key = char,
				mods = modifier,
				action = wezterm.action.SendKey({ key = char, mods = modifier:gsub("CMD", "CTRL") }),
			})
		end
	end

	config.keys = maps
end

-- Finally, return the configuration to wezterm:
return config
