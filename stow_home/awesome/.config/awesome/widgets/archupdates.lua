local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.archupdates")

local icon = {
    widget = wibox.widget.imagebox,
    image = os.getenv("HOME") .. "/.config/awesome/theme/icons/package.svg",
    forced_width = 16,
    forced_height = 16,
    resize = true,
}

local arch_updates = wibox.widget {
    widget = wibox.widget.textbox
}

local widget = {
    widget = wibox.container.place,
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    {
      widget = wibox.container.place,
      icon,
    },
    arch_updates
}

awesome.connect_signal("status::archupdates", function(count)
    -- Set visibility if there are updates
    local markup = count .. " MAJs"
    arch_updates.font = beautiful.font
    arch_updates.markup = markup
end)

return widget
