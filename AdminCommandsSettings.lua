-- This is a module Script file located in ServerScriptService --

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
		["manager"] = {},
		["owner"] = {255},

		["moderatorUser"] = {},
		["adminUser"] = {},
		["managerUser"] = {},
		["ownerUser"] = {},

		["modPerms"] = {"Warn", "Shout", "Rejoin", "TpBring", "TpTo"},
		["adminPerms"] = {"Kick", "Ban", "Warn", "Shout", "Rejoin", "Banlist", "TpTo", "TpBring", "ClearTools"},
		["managerPerms"] = {"Kick", "Ban", "PermBan", "UnBan", "Warn", "Shout", "Rejoin", "Banlist", "TpTo", "TpBring", "ClearTools"},
		["ownerPerms"] = {"Kick", "Ban", "PermBan", "UnBan", "Warn", "Shout", "Rejoin", "Banlist", "TpTo", "TpBring", "ClearTools"},
	},
	DiscordWebhook = {
		["enabled"] = true,
		["URL"] = "https://discord.com/api/webhooks/847241352596422706/8lAbXMT9UW2HrP9QZ_9orDMykfzl633vlP38NHgCDSwYqegXFWqtfXK9w21I16oASR4_",
	}
}

panel.commands = {
	TpTo = {
		["description"] = "Teleport to others.",
		["command"] = "tpto",
		["aliases"] = {"to", "tpmeto"},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	TpBring = {
		["description"] = "Bring others to you.",
		["command"] = "tpbring",
		["aliases"] = {"bring", "tptome"},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	ClearTools = {
		["description"] = "Remove a player's tools.",
		["command"] = "cleartools",
		["aliases"] = {"removetools", "clrtools"},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	Kick = {
		["description"] = "Remove a pleyer from the game.",
		["command"] = "kick",
		["aliases"] = {},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	Ban = {
		["description"] = "Ban a player from this server (not perm).",
		["command"] = "ban",
		["aliases"] = {},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	PermBan = {
		["description"] = "Ban a player from all servers on this game (perm).",
		["command"] = "permban",
		["aliases"] = {"pban", "permanentban", "permanentlyban"},
		["parameters"] = {"<player>"},
		["log"] = true
	},
	UnBan = {
		["description"] = "Revoke a ban of a player.",
		["command"] = "unban",
		["aliases"] = {"uban", "unpermban"},
		["parameters"] = {"<player>"},
		["log"] = true
	}
}

return panel