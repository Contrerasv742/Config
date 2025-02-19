local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Match title bar to terminal background
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
    active_titlebar_bg = '#1e1e2e',    -- Match terminal background
    inactive_titlebar_bg = '#1e1e2e',
}

-- WSL and Theme
config.default_prog = {'wsl.exe', '--cd', '~'}
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.92

-- Use Fira Code font
config.font = wezterm.font('Fira Mono for Powerline', { weight = 'Regular' })
config.font_size = 10
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Tab Bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- Window
config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
}
config.window_close_confirmation = 'AlwaysPrompt'
config.scrollback_lines = 10000

-- Keys and Mouse
config.disable_default_key_bindings = false
config.mouse_bindings = {
    -- Right click paste
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
}

local act = wezterm.action

-- Disable just the pane management keys
config.keys = {
    { key = '"', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = '%', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'w', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'UpArrow', mods = 'CTRL', action = act.DisableDefaultAssignment },
    { key = 'DownArrow', mods = 'CTRL', action = act.DisableDefaultAssignment },
}

return config
