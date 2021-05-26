local panel = {}

---------------------
-- All Permissions --
---------------------

-- Kick / Removes the user from the game
-- Ban / Prevents the user from ever entering the game
-- Shout / Creates an announcement for the entire server to view
-- Rejoin / Rejoins the user
-- Banlist / Allows the granted user to view bans
-- TpTo / Teleports to a user
-- TpBring / Teleports a user to you
-- ClearTools / Removes a users tools
-- Warn / Warns a user with a customized statement
-- Notify / Creates a notification above all user screens

panel.settings  = {
	Main = {
		["chatPrefix"] = ".",
		
		["groupId"] = 3353368,
		["moderator"] = {},
		["admin"] = {},
		["owner"] = {255},
		
		["moderatorUser"] = {},
		["adminUser"] = {},
		["ownerUser"] = {},
		
		["modPerms"] = {"Warn", "Shout", "Rejoin", "TpBring", "TpTo"},
		["adminPerms"] = {"Kick", "Ban", "Warn", "Shout", "Rejoin", "Banlist", "TpTo", "TpBring", "ClearTools"},
		["ownerPerms"] = {"Kick", "Ban", "Warn", "Shout", "Rejoin", "Banlist", "TpTo", "TpBring", "ClearTools"},
	},
	DiscordWebhook = {
		["enabled"] = false,
		["URL"] = "",
		["username"] = "",
	}
}

return panel