local module = {}

local rs = game:GetService("ReplicatedStorage")
local codeToTable = require(rs.ScriptService)
local SerializeValues = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Values/ValueSerializer.lua"))()

function SerializeTableValues(tbl)
	for i,v in pairs(tbl) do
		if typeof(v) == "table" then
			SerializeTableValues(v)
		else
			local Function = SerializeValues[typeof(v)]
			if Function then
				tbl[i] = Function(v)
			else
				tbl[i] = v
			end
		end
	end
end

function module.serializeScript(Script)
	local blockCodeData = codeToTable.loadScript(Script:GetAttribute("VisualSource"))
	SerializeTableValues(blockCodeData)
	
	return blockCodeData
end

return module
