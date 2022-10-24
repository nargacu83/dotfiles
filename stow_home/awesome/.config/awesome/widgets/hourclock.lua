local wibox = require("wibox")

local hourclock = {
    widget = wibox.container.place,
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    {
        widget = wibox.container.place,
        {
            widget = wibox.widget.imagebox,
            image = os.getenv("HOME") .. "/.config/awesome/theme/icons/clock.svg",
            forced_width = 16,
            resize = true,
        },
    },
    {
        format = "%H:%M",
        widget = wibox.widget.textclock
    },
}

return hourclock
