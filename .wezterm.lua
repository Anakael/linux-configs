-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.default_prog = { '/usr/bin/fish' }

-- Appearance
config.window_close_confirmation = 'NeverPrompt'
config.font_size = 13.0
config.color_scheme = 'MaterialDarker'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.colors = {
    background = '#1d1f21',
}
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

-- Keys
local keys = {
    {
        key = 't',
        mods = 'CTRL',
        action = act.SpawnTab('CurrentPaneDomain'),
    },
    {
        key = 'w',
        mods = 'CTRL|ALT',
        action = act.CloseCurrentTab({ confirm = true }),
    },
}
for i = 1, 8 do
    table.insert(keys, {
        key = tostring(i),
        mods = 'CTRL',
        action = act({ ActivateTab = i - 1 }),
    })
end

config.keys = keys

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


return config
