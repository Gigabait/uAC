local table = table.Copy(table)
local net = table.Copy(net)
local timer = table.Copy(timer)
local debug = table.Copy(debug)
local hook = table.Copy(hook)
local concommand = table.Copy(concommand)

local function Punish(reason)
	net.Start("uAC_Ban")
	net.WriteString(reason)
	net.SendToServer()
end

local function CheckVar(var, val)
	net.Start("uAC_CheckVar")
	net.WriteString(var)
	net.WriteString(val)
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

local BadContain = {
	"lenny",
	"ahack",
	"mapex",
}

local function CheckMain()
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
	
	for tbl,nope in pairs(hook.GetTable()) do
		for hk,nope2 in pairs(hook.GetTable()[tbl]) do
			for nope3,bad in pairs(BadContain) do
				if string.find(string.lower(hk), bad) then
					Punish("Bad Hook")
				end
			end
		end
	end
	
	for cmd,nope in pairs(concommand.GetTable()) do
		for nope2,bad in pairs(BadContain) do
			if string.find(string.lower(cmd), bad) then
				Punish("Bad Command")
			end
		end
	end
	
	if debug.getinfo(GetConVarString).source != "=[C]" then
		Punish("GCVS Detour")
	end
	
	if debug.getinfo(file.Read).source != "@lua/includes/extensions/file.lua" then
		Punish("FR Detour")
	end
	
	if debug.getinfo(file.Open).source != "=[C]" then
		Punish("FO Detour")
	end
	
	if debug.getinfo(debug.getregistry().Entity.FireBullets).source != "=[C]" then
		Punish("FB Detour")
	end
	
	CheckVar("sv_allowcslua", GetConVarString("sv_allowcslua"))
	CheckVar("sv_cheats", GetConVarString("sv_cheats"))
end

timer.Create(RandomString(), 5, 0, CheckMain)

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
