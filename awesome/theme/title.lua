local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

client.connect_signal("request::titlebars", function(c)

	-- Button actions

    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

	-- Window controls

	if user.titlecontrols then
		controlstitle = wibox.widget {
			{
				awful.titlebar.widget.minimizebutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				awful.titlebar.widget.closebutton(c),
				spacing = dpi(14),
				widget = wibox.layout.fixed.horizontal
			},
			right = dpi(14),
			top = dpi(6),
			bottom = dpi(6),
			widget = wibox.container.margin
		}
	end

	-- Titlebar

    awful.titlebar(c, { size = dpi(20) } ).widget = {
		{
			awful.titlebar.widget.titlewidget(c), 
			left = dpi(15),
			buttons = buttons,
			widget = wibox.container.margin
		},
		{
			buttons = buttons,
			widget = wibox.container.background
		},
		controlstitle,
        layout = wibox.layout.align.horizontal
    }
end)
