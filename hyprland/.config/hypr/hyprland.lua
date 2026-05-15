local local_end = require("hyprland_local")

hl.on("hyprland.start", function ()
  local cursor_theme = "volantes_cursors"
  local services = {
    "waybar",
    "hyprpaper",
    "hyprpolkitagent",
    "hypridle",
    "blueman-applet.service",
  }
  for _, service in ipairs(services) do
    hl.exec_cmd("systemctl --user start " .. service)
  end
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme \"" .. cursor_theme .. "\"")
  hl.exec_cmd("hyprctl setcursor " .. cursor_theme .. " 24")
  hl.exec_cmd("hyprlauncher --daemon")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

hl.config({
  general = {
    border_size = 1,
    gaps_in = 4,
    gaps_out = 8,
    gaps_workspaces = 16,
    col = {
      inactive_border = "#595959aa",
      active_border = {
        colors = { "#33ccffee", "#00ff99ee" },
        angle = 45
      },
    },
    layout = "dwindle",
    allow_tearing = true,
    -- modal_parent_blocking = true,
  },
  decoration = {
    rounding = 16,
    rounding_power = 2,
    dim_special = 0.2,
    blur = {
      enabled = true,
      size = 2,
      passes = 2,
      noise = 0,
      contrast = 0.8916,
      brightness = 0.8,
      vibrancy = 0.2,
      vibrancy_darkness = 0.5,
    },
    shadow = {
      enabled = true,
      range = 5,
      render_power = 2,
      color = "#1a1a1aee",
    },
    -- glow = {},
  },
  animations = {
    enabled = true,
    -- TODO
  },
  input = {
    kb_layout = "pl",
    kb_options = "caps:none",
    repeat_rate = 25,
    repeat_delay = 250,
    sensitivity = -0.4,
    accel_profile = "flat",
    follow_mouse = 1, -- Cursor movement will always change focus to the window under the cursor.
    follow_mouse_threshold = 10,
    focus_on_close = 1, -- focus will shift to the window under the cursor.\
    emulate_discrete_scroll = 1,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.5,
    }
  },
  gestures = {
    workspace_swipe_distance = 250,
    workspace_swipe_cancel_ratio = 0.1,
    workspace_swipe_forever = true,
  },
  group = {
    insert_after_current = false,
    -- groupbar = {}, -- TODO
  },
  misc = {
    focus_on_activate = true,
    enable_anr_dialog = false,
    close_special_on_empty = false,
  },
  binds = {
    scroll_event_delay = 0,
    hide_special_on_workspace_change = true,
  },
  xwayland = {
    force_zero_scaling = true,
  },
  render = {
    direct_scanout = 2,
    new_render_scheduling = true,
  },
  ecosystem = {
    no_donation_nag = true, -- already a hyperks enjoyer ;)
  },
  dwindle = {
    force_split = 0, -- split follows mouse
    preserve_split = true,
  }
})

hl.device({
  name = "pixa3854:00-093a:0274-touchpad",
  accel_profile = "adaptive",
  sensitivity = -0.2,
})
hl.device({
  name = "ven_04f3:00-04f3:311c-touchpad",
  accel_profile = "adaptive",
  sensitivity = -0.3,
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 1.2,  bezier = "quick",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "quick", style = "slidefade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "quick", style = "slidefade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

hl.gesture({fingers = 3, direction = "horizontal", action = "workspace"})
hl.gesture({fingers = 4, direction = "horizontal", action = "workspace"})

local terminal_cmd = "ghostty +new-window"

hl.bind("SUPER + R", hl.dsp.exec_cmd(terminal_cmd))
hl.bind("SUPER + return", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock --no-fade-in"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | hyprlauncher -m | cliphist decode | wl-copy"))
-- hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -z"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grimblast --notify --freeze --filetype png --openparentdir copysave area"))

-- windows
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + C", hl.dsp.window.kill())
hl.bind("SUPER + F", hl.dsp.window.float())
hl.bind("SUPER + I", hl.dsp.window.pin())
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + T", hl.dsp.layout("swapsplit"))
hl.bind("SUPER + S", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + A", hl.dsp.window.tag({tag = "keepaspectratio"}))

-- groups
hl.bind("SUPER + tab", hl.dsp.group.toggle())
hl.bind("SUPER + SHIFT + tab", hl.dsp.window.move({out_of_group = true}))
hl.bind("SUPER + CTRL + tab", hl.dsp.group.lock_active())
hl.bind("ALT + tab", hl.dsp.group.next())
hl.bind("ALT + SHIFT + tab", hl.dsp.group.prev())

-- focus
hl.bind("SUPER + left", hl.dsp.focus({direction = "l"}))
hl.bind("SUPER + right", hl.dsp.focus({direction = "r"}))
hl.bind("SUPER + up", hl.dsp.focus({direction = "u"}))
hl.bind("SUPER + down", hl.dsp.focus({direction = "d"}))

-- resize
local resize_step = 100
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({x = -resize_step, y = 0}))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({x = resize_step, y = 0}))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({x = 0, y = -resize_step}))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({x = 0, y = resize_step}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.layer_rule({
  name = "blur-bar",
  match = {
    namespace = "waybar"
  },
  blur = true,
})

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name = "keep-aspect-ratio",
  match = {
    tag = "keepaspectratio",
  },
  keep_aspect_ratio = true,
})

hl.window_rule({
  name = "float-bar-stuff",
  match = {
    class = "^(org.pulseaudio.pavucontrol|blueman-manager)$",
  },
  float = true,
  size = {"(monitor_w*0.4)", "(monitor_h*0.4)"},
  move = {"((monitor_w*1)-window_w-8)", "(40)"},
})

local function float_window(match, name)
  hl.window_rule({
    name = "float-" .. name,
    match = match,
    float = true,
  })
end

float_window({initial_title = "^(Yubico Authenticator)$"}, "yubico-authenticator")
float_window({class = "^(xdg-desktop-portal-gtk)$"}, "xdg-desktop-portal-gtk")
float_window({title = "Remmina Remote Desktop Client"}, "remmina-picker")

-- smart gaps (except special)
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0, rounding = 0 })

-- per monitor workspaces
local workspaces_per_monitor = 10
local wrap_around = false
local function create_workspaces(monitor)
  for i = 1, workspaces_per_monitor do
    hl.workspace_rule({
      workspace = tostring(monitor.id * workspaces_per_monitor + i),
      monitor = monitor.name,
      -- persistent = true,
      default = (i == 1),
    })
  end
end
for _, monitor in ipairs(hl.get_monitors()) do
  create_workspaces(monitor)
end
hl.on("monitor.added", create_workspaces)

local function get_active_monitor_id()
  local monitor = hl.get_active_monitor()
  return monitor and monitor.id or 0
end

local function get_relative_workspace_index(forwards)
  local current_workspace = hl.get_active_workspace()
  if not current_workspace then return nil end
  local index = current_workspace.id % workspaces_per_monitor
  if index == 0 then index = workspaces_per_monitor end
  -- yandere dev style /s
  if forwards then
    index = index + 1
    if index > workspaces_per_monitor then
      if wrap_around then
        index = 1
      else
        return nil
      end
    end
  else
    index = index - 1
    if index < 1 then
      if wrap_around then
        index = workspaces_per_monitor
      else
        return nil
      end
    end
  end
  return index
end

local function activate_workspace(number)
  return function ()
    local monitor_id = get_active_monitor_id()
    hl.dispatch(hl.dsp.focus({workspace = tostring(monitor_id * workspaces_per_monitor + number)}))
  end
end

local function move_to_workspace(number)
  return function ()
    local monitor_id = get_active_monitor_id()
    hl.dispatch(hl.dsp.window.move({workspace = tostring(monitor_id * workspaces_per_monitor + number), follow = true}))
  end
end

local function activate_workspace_relative(forwards)
  return function ()
    local monitor_id = get_active_monitor_id()
    local index = get_relative_workspace_index(forwards)
    if not index then return end
    hl.dispatch(hl.dsp.focus({workspace = tostring(monitor_id * workspaces_per_monitor + index)}))
  end
end

local function move_to_workspace_relative(forwards)
  return function ()
    local monitor_id = get_active_monitor_id()
    local index = get_relative_workspace_index(forwards)
    if not index then return end
    hl.dispatch(hl.dsp.window.move({workspace = tostring(monitor_id * workspaces_per_monitor + index), follow = true}))
  end
end

for i = 1, math.min(workspaces_per_monitor, 10) do
  local key = tostring(i % 10)
  hl.bind("SUPER + " .. key, activate_workspace(i))
  hl.bind("SUPER + SHIFT + " .. key, move_to_workspace(i))
end
hl.bind("SUPER + mouse_up", activate_workspace_relative(true))
hl.bind("SUPER + mouse_down", activate_workspace_relative(false))
hl.bind("SUPER + CTRL + right", activate_workspace_relative(true))
hl.bind("SUPER + CTRL + left", activate_workspace_relative(false))
hl.bind("SUPER + ALT + right", move_to_workspace_relative(true))
hl.bind("SUPER + ALT + left", move_to_workspace_relative(false))

-- per monitor special
local special_name = "magic"

local function toggle_special(force_close)
  local current_monitor = hl.get_active_monitor()
  if not current_monitor then return end
  local has_special = force_close or current_monitor.active_special_workspace ~= nil
  local monitors = hl.get_monitors()
  for _, monitor in ipairs(monitors) do
    -- toggle_special doesn't allow specifying the monitor, so we have to focus it first
    -- this will also close any existing special workspace on that monitor
    hl.dispatch(hl.dsp.focus({workspace = monitor.active_workspace}))
    if not has_special then
      hl.dispatch(hl.dsp.workspace.toggle_special(special_name .. tostring(monitor.id)))
    end
  end
  -- restore original focus
  hl.dispatch(hl.dsp.focus({monitor = current_monitor}))

  -- spawn terminal if the special workspace on the current monitor is empty
  local current_special = current_monitor.active_special_workspace
  if not has_special and current_special and current_special.windows == 0 then
    hl.dispatch(hl.dsp.exec_cmd(terminal_cmd, { workspace = current_special.id }))
  end
end

local function move_to_special()
  local current_monitor = hl.get_active_monitor()
  if not current_monitor then return end
  local special_workspace = current_monitor.active_special_workspace
  if special_workspace then return end
  local name = special_name .. tostring(current_monitor.id)
  hl.dispatch(hl.dsp.window.move({workspace = "special:" .. name, follow = false}))
  toggle_special(false)
end

local function move_out_of_special()
  hl.dispatch(hl.dsp.window.move({workspace = "+0", follow = false}))
  toggle_special(true)
end

hl.on('window.close', function(window)
  if not window.workspace or not window.workspace.special then
    return
  end
  local active_count = 0
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.active_special_workspace then
      active_count = active_count + monitor.active_special_workspace.windows
    end
  end
  if active_count <= 1 then
    toggle_special(true)
  end
end)

hl.bind("SUPER + grave", toggle_special)
hl.bind("SUPER + CTRL + grave", move_to_special)
hl.bind("SUPER + SHIFT + grave", move_out_of_special)

if type(local_end) == "function" then
  local_end()
end