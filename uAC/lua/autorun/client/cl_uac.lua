local table = table.Copy(table)
local net = table.Copy(net)

local function Punish(reason)
	net.Start("uAC_Ban")
	net.WriteString(reason)
	net.SendToServer()
end

local goodModules = {
	"ai_schedule",
	"ai_task",
	"baseclass",
	"cleanup",
	"concommand",
	"constraint",
	"construct",
	"controlpanel",
	"cookie",
	"cvars",
	"draw",
	"drive",
	"duplicator",
	"effects",
	"gamemode",
	"halo",
	"hook",
	"http",
	"killicon",
	"list",
	"markup",
	"matproxy",
	"menubar",
	"notification",
	"numpad",
	"player_manager",
	"presets",
	"properties",
	"saverestore",
	"scripted_ents",
	"search",
	"spawnmenu",
	"team",
	"undo",
	"usermessage",
	"weapons",
	"widget"
}

local oldRequire = require

local function newRequire(mod)
	if !table.HasValue(goodModules, mod) then
		Punish("Bad Module: " .. mod)
		return
	end
	
	oldRequire(mod)
end

_G.require = newRequire

print("[uAC] Clientside loaded.")
