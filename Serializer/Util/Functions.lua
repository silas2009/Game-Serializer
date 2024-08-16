local module = {}

function module.convertId(assetId)
	local starts = {
		"http://www.roblox.com/asset?id="
	}
	for i,v in pairs(starts) do
		if string.sub(assetId,0,#v) == v then
			return "rbxassetid://" .. string.sub(assetId,#v+1,#assetId)
		end
	end
	return assetId
end

return module
