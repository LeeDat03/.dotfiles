-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Pwsh
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- COLORSCHEME
config.color_scheme = "Monokai Pro Ristretto (Gogh)"

-- FONTS
config.font_size = 12
config.font = wezterm.font("MonaspiceAr Nerd Font", { weight = "Medium", stretch = "Normal" }) -- (AKA: MonaspiceAr NF, MonaspiceAr NF Medium)

-- TAB BAR
wezterm.on("format-tab-title", function(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	if cwd_uri then
		local cwd = cwd_uri.file_path or cwd_uri

		local folder_name = cwd:match("([^/\\]+)[/\\]?$") or "?"
		return " " .. folder_name .. " "
	end

	return " ? "
end)

config.colors = {
	tab_bar = {
		background = "#0b0022",
		active_tab = {
			bg_color = "#26A269",
			fg_color = " #ffffff",
			intensity = "Bold",
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#444444",
			fg_color = "#cccccc",
		},
	},
}

-- config.window_background_opacity = 0.9

-- WINDOW
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_frame = {
	active_titlebar_bg = "#272822",
	inactive_titlebar_bg = "#272822",

	active_titlebar_fg = "#f8f8f2",
	inactive_titlebar_fg = "#75715e",

	active_titlebar_border_bottom = "#272822",
	inactive_titlebar_border_bottom = "#272822",
}
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 100

-- KEYMAP
config.keys = {
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "`",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = "`", mods = "CTRL" }),
	},
}

return config
