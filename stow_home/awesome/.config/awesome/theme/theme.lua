---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = {}

theme.font = "Inter Bold 10"

theme.bg_normal = "#1e1e2eBF"
theme.bg_focus = "#cba6f7ee"
theme.bg_urgent = "#f8f8f2"
theme.bg_occupied = "#313244"
theme.bg_minimize = "#313244"
theme.bg_systray = "#313244"
theme.systray_icon_spacing = 5

theme.fg_normal = "#ffffff"
theme.fg_focus = "#cdd6f4"
theme.fg_urgent = "#b4befe"
theme.fg_minimize = "#bac2de"

theme.taglist_shape_border_width = dpi(2)
theme.taglist_shape_border_color_focus = theme.bg_focus
theme.taglist_bg_empty = "#00000000"
theme.taglist_shape_border_color = theme.bg_occupied

theme.taglist_bg_normal = theme.bg_normal
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_bg_occupied = theme.bg_occupied
theme.taglist_bg_urgent = theme.bg_urgent

theme.tasklist_bg_normal = "#00000000"
theme.tasklist_bg_focus = "#00000000"
theme.tasklist_bg_occupied = "#00000000"
theme.tasklist_bg_urgent = "#00000000"
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = false

theme.gap_single_client = true
theme.useless_gap = dpi(2)
theme.border_width = dpi(1)
theme.border_normal = theme.bg_occupied
theme.border_focus = theme.bg_focus
theme.border_marked = theme.bg_urgent

theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.icon_theme = nil

return theme
