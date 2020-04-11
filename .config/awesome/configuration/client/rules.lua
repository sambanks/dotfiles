local awful = require('awful')
local gears = require('gears')
local ruled = require("ruled")
local beautiful = require('beautiful')

local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
	-- All clients will match this rule.
	ruled.client.append_rule {
		id         = "global",
		rule       = { },
		properties = {
			focus     = awful.client.focus.filter,
			raise     = true,
			floating = false,
			maximized = false,
			above = false,
			below = false,
			ontop = false,
			sticky = false,
			maximized_horizontal = false,
			maximized_vertical = false,
			round_corners = true,
			keys = client_keys,
			buttons = client_buttons,
			screen    = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	}

	-- Dialogs
	ruled.client.append_rule {
		id         = "dialog",
		rule_any   = {
			type = { "dialog" },
			class = { "Wicd-client.py", "calendar.google.com" },
		},
		properties = {
			titlebars_enabled = true,
			floating = true,
			draw_backdrop = true,
			skip_decoration = true,
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, beautiful.client_radius)
					end,
			placement = awful.placement.centered
		}
	}

	-- Modals
	ruled.client.append_rule {
		id         = "dialog",
		rule_any   = {
			type = { "modal" },
		},
		properties = {
			titlebars_enabled = true,
			floating = true,
			draw_backdrop = true,
			skip_decoration = true,
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, beautiful.client_radius)
					end,
			placement = awful.placement.centered
		}
	}

	-- Utilities
	ruled.client.append_rule {
		id         = "utility",
		rule_any   = {
			type = { "utility", "splash" }
		},
		properties = {
			titlebars_enabled = false,
			floating = true,
			hide_titlebars = true,
			draw_backdrop = false,
			skip_decoration = true,
			placement = awful.placement.centered
		}
	}

	-- Splash
	ruled.client.append_rule {
		id         = "splash",
		rule_any   = {
			type = { "splash" }
		},
		properties = {
			titlebars_enabled = false,
			floating = true,
			hide_titlebars = true,
			draw_backdrop = false,
			skip_decoration = true,
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, beautiful.client_radius)
					end,
			placement = awful.placement.centered
		}
	}

	-- Hide titlebars
	ruled.client.append_rule {
		id        = "hide_titlebars",
		rule_any  = {
			class    = {
				"feh",
				"Mugshot",
				"Pulseeffects"
			},
		},
		properties = {
			skip_decoration = true,
			hide_titlebars = true,
			floating = true,
			ontop = true,
			placement = awful.placement.centered
		}
	}

	-- Instances
	ruled.client.append_rule {
		id       = "instances",
		rule_any = {
			instance    = {
				"file_progress",
				"Popup",
				"nm-connection-editor"
			},
		},
			properties = {
			skip_decoration = true,
			round_corners = true,
			ontop = true,
			floating = true,
			draw_backdrop = false,
			focus = awful.client.focus.filter,
			raise = true,
			keys = client_keys,
			buttons = client_buttons,
			placement = awful.placement.centered
		}
	}

end)
