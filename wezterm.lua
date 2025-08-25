-- Init
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Save what OS we are on for later
local isMac = wezterm.target_triple:find("darwin")

function getModBasedOnOS(isMac)
	return isMac and "CMD" or "CTRL"
end

-- Starting window size
config.initial_cols = 120
config.initial_rows = 60

-- Font conf
config.font_size = isMac and 16 or 12
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })

-- Color scheme
config.color_scheme = "Gruvbox dark, hard (base16)"

-- Tab bar settings
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Wayland doesn't support window decorations yet, so force x on linux
config.enable_wayland = not isMac and false

-- (Ctrl || Cmd) + / for leader
config.leader = { key = [[\]], mods = getModBasedOnOS(isMac), timeout_milliseconds = 1000 }

config.keys = {
	-- Create tab
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

	-- Vertical split
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Horizontal split
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Kill tab
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },

	-- left, down, up, right pane navigation
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- Copy and paste
	{ key = "c", mods = getModBasedOnOS(isMac) .. "|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = getModBasedOnOS(isMac) .. "|SHIFT", action = act.PasteFrom("Clipboard") },
}

-- Navigate to tab #
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- Configure CMD vs CTRL behavior
-- On OSX, use CMD for all terminal based commands
-- On Linux, stick with the default CTRL
-- Ex: Kill process - OSX: CMD+C | Linux: CTRL+C
-- Heavily inspired by [this comment](https://github.com/wezterm/wezterm/discussions/2754#discussioncomment-4195055)
if isMac then
	local maps = {}
	local chars = [[`1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./]]
	for char in chars:gmatch(".") do
		for _, modifier in ipairs({ "CMD" }) do
			table.insert(config.keys, {
				key = char,
				mods = modifier,
				action = wezterm.action.SendKey({ key = char, mods = modifier:gsub("CMD", "CTRL") }),
			})
		end
	end
end

-- Finally, return the configuration to wezterm:
return config
