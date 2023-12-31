local awful = require("awful")
local mod = user.mod

-- Mouse 

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({

		-- Move

        awful.button({ mod }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),

		-- Resize

        awful.button({ mod }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),

    })
end)

-- Keys

awful.keyboard.append_global_keybindings({

	-- Awesome

	awful.key(
		{ mod, "Shift" }, "r", 
			awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
	awful.key(
		{ mod }, "z", function() 
			awful.layout.inc(1) 
		end,
 		{ description = "next layout", group = "awesome" }
	),
	awful.key(
		{ mod, "Shift" }, "z", function() 
			awful.layout.inc(-1) 
		end,
 		{ description = "previous layout", group = "awesome" }
	),
    awful.key(
		{ mod }, "Tab", function() 
			awful.client.focus.byidx(1) 
		end,
        { description = "next window", group = "awesome" }
    ),
    awful.key(
		{ mod, "Shift" }, "Tab", function() 
			awful.client.focus.byidx(-1) 
		end,
		{ description = "previous window", group = "awesome" }
    ),
	awful.key(
		{ mod }, "space", function() 
			awesome.emit_signal("widget::menu") 
		end,
		{ description = "show menu", group = "awesome" }
	),
    awful.key(
		{ mod }, "d", function() 
			awesome.emit_signal("widget::launcher")
		end,
        { description = "show launcher", group = "awesome" }
	),
    awful.key(
		{ mod, "Shift" }, "c", function() 
			awesome.emit_signal("widget::config")
		end,
        { description = "show config", group = "awesome" }
	),
    awful.key(
		{ mod }, "BackSpace", function()
			awful.util.spawn("awesome-client command lockscreen()")
		end,
        { description = "lockscreen", group = "awesome" }
	),

	-- Programs

	awful.key(
		{ mod }, "Return", function() 
			awful.spawn.with_shell(user.terminal) 
		end,
        { description = "open a terminal", group = "programs" }
	),
	  awful.key(
		{ mod }, "grave", function() 
			awful.util.spawn("librewolf https://github.com/p3nguin-kun/penguinRice/wiki/2.-Keybindings-and-commands")
		end,
        { description = "show keybindings list", group = "awesome" }
	),

	-- Screenshot

	awful.key(
		{ mod }, "Delete", function() 
			awful.util.spawn("xfce4-screenshooter") 
		end,
        { description = "screenshot", group = "screenshot" }
	),
	awful.key(
		{ }, "Print", function() 
			awful.util.spawn("xfce4-screenshooter") 
		end,
        { description = "screenshot", group = "screenshot" }
	),
	-- Volume

    awful.key(
		{ }, "XF86AudioRaiseVolume", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
			awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioLowerVolume", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
			awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioMute", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }
	),
  awful.key(
    { mod, "Control" }, "equal", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
			awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }
	),
  awful.key(
		{ mod, "Control" }, "minus", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
			awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }
	),
   awful.key(
		{ mod, "Control" }, "0", function() 
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }
	),

	-- Brightness

	awful.key(
		{ }, "XF86MonBrightnessUp", function() 
			awful.spawn.with_shell("brightnessctl s 5%+")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{ }, "XF86MonBrightnessDown", function() 
			awful.spawn.with_shell("brightnessctl s 5%-")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "lower brightness", group = "brightness" }
	),
	awful.key(
		{ mod, "Control" }, "bracketright", function() 
			awful.spawn.with_shell("brightnessctl s 5%+")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{ mod, "Control" }, "bracketleft", function() 
			awful.spawn.with_shell("brightnessctl s 5%-")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "lower brightness", group = "brightness" }
	),

	-- Tag

    awful.key {
        modifiers   = { mod },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { mod, "Control" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers = { mod, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag and follow",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
					tag:view_only()
                end
            end
        end,
    }

})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

		-- Client
	
		awful.key(
			{ mod }, "c", 
			function(c) 
				awful.placement.centered(c, { honor_workarea = true }) 
			end,
			{ description = "center window", group = "client" }
		),
        awful.key(
			{ mod }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }
		),
	    awful.key(
			{ mod }, "s", 
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
        	{ description = "toggle floating", group = "client" }
		),
	    awful.key(
			{ mod }, "n", 
			function(c)
				client.focus.minimized = true
			end,
        	{ description = "minimize", group = "client" }
		),
	    awful.key(
			{ mod }, "m", 
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
        	{ description = "toggle maximize", group = "client" }
		),
		awful.key(
			{ mod, "Shift" }, "q", function(c) 
				c:kill() 
			end,
 			{ description = "close", group = "client" }
		),
        -- Focus client by direction (hjkl keys)

        awful.key({ mod }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
            {description = "focus down", group = "client"}),
        awful.key({ mod }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
        awful.key({ mod }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
        awful.key({ mod }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),

    -- Focus client by direction (arrow keys)

       awful.key({ mod }, "Down",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
        awful.key({ mod }, "Up",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
        awful.key({ mod }, "Left",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
        awful.key({ mod }, "Right",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),
        -- Gaps
        awful.key({ mod, "Shift" }, "minus",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
        awful.key({ mod }, "minus",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),
    })
end)
