local wibox = require("wibox")

local dateclock = {
    widget = wibox.container.place,
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    {
        widget = wibox.container.place,
        {
            widget = wibox.widget.imagebox,
            image = os.getenv("HOME") .. "/.config/awesome/theme/icons/calendar.svg",
            forced_width = 16,
            resize = true,
        },
    },
    {
        format = "%a %d %B",
        widget = wibox.widget.textclock
    },
}

return dateclock
