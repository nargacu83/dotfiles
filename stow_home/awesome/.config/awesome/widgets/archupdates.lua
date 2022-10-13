local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.archupdates")

local arch_updates = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::archupdates", function(count)
    -- Set visibility if there are updates
    arch_updates.visible = count > 0
    arch_updates.font = beautiful.font
    local markup = count .. " MAJs"
    -- local markup = " MAJs"
    arch_updates.markup = markup
end)

return arch_updates
