util.AddNetworkString("uAC_Ban")

uAC = {}

function uAC.Punish(ply, reason)
	if IsValid(ply) then
		ply:uBan(reason)
	end
end

net.Receive("uAC_Ban", function(len, ply)
	uAC.Punish(ply, net.ReadString())
end )

print("[uAC] Serverside loaded.")
