local table = table.Copy(table)
local net = table.Copy(net)
local timer = table.Copy(timer)
local debug = table.Copy(debug)

local function Punish(reason)
	net.Start("uAC_Ban")
	net.WriteString(reason)
	net.SendToServer()
end

local function RandomString()
	local randstr = " "
	local rand1 = math.random(6, 12)
	
	for i = 1, rand1 do
		local rand2 = math.random(80, 160)
		randstr = randstr .. tostring(rand2)
	end
	
	return randstr
end

local function CheckHooks()
	if GAMEMODE.Think then
		if string.Explode("/", debug.getinfo(GAMEMODE.Think).source)[1] != "@gamemodes" then
			Punish("GAMEMODE Hook Overriding")
		end
	end
	
	if GAMEMODE.HUDPaint then
		if string.Explode("/", debug.getinfo(GAMEMODE.HUDPaint).source)[1] != "@gamemodes" then
			Punish("GAMEMODE Hook Overriding")
		end
	end
	
	if GAMEMODE.CreateMove then
		if string.Explode("/", debug.getinfo(GAMEMODE.CreateMove).source)[1] != "@gamemodes" then
			Punish("GAMEMODE Hook Overriding")
		end
	end
end

timer.Create(RandomString(), 5, 0, CheckHooks)

local GoodModules = {
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
	if !table.HasValue(GoodModules, mod) then
		Punish("Bad Module: " .. mod)
		return
	end
	
	oldRequire(mod)
end

_G.require = newRequire

print("[uAC] Clientside loaded.")
