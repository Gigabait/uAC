util.AddNetworkString("uAC_Ban")
util.AddNetworkString("uAC_CheckVar")

uAC = {}

function uAC.Punish(ply, reason)
	if IsValid(ply) then
		ply:uBan(reason)
	end
end

function uAC.CheckVar(ply, var, val)
	if var != "sv_allowcslua" and var != "sv_cheats" then
		return
	end
	
	local sv_val = GetConVarString(var)
	
	if sv_val != val then
		uAC.Punish(ply, "CVar Forcing")
	end
end

net.Receive("uAC_Ban", function(len, ply)
	uAC.Punish(ply, net.ReadString())
end )

net.Receive("uAC_CheckVar", function(len, ply)
	uAC.CheckVar(ply, net.ReadString(), net.ReadString())
end )

print("[uAC] Serverside loaded.")
