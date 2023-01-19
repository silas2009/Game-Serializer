local rs = game:GetService("ReplicatedStorage")
local createBlock = rs.RemoteFunctions.ScriptEditor.CreateBlock
local openScript = rs.RemoteFunctions.ScriptEditor.OpenScript
local saveScript = rs.RemoteFunctions.ScriptEditor.ScriptSaveRequested
local setValueInput = rs.RemoteFunctions.ScriptEditor.SetValueInput
local setVariableInput = rs.RemoteFunctions.ScriptEditor.SetVariableInput
local setOutputName = rs.RemoteFunctions.ScriptEditor.SetOutputName
local codeToTable = require(game.ReplicatedStorage.ScriptService)
local SerializeValues = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/ValueSerializer.lua"))()

local scripts = {}

for _,v in pairs(workspace:GetDescendants()) do
	if v:IsA("Script") and v.Name == "YEET" and v:GetAttribute("VisualSource") then
		pcall(function()
			local blockCodeData = codeToTable.loadScript(v:GetAttribute("VisualSource"))
			table.insert(scripts,blockCodeData)
		end)
		break
	end
end

function SetTableValues(tbl)
	for index, value in pairs(tbl) do
		if typeof(value) == "table" then
			SetTableValues(value)
		else
			local Function = SerializeValues[typeof(value)]
			if Function then
				tbl[index] = Function(value)
			else
				tbl[index] = value
			end
		end
	end
end
SetTableValues(scripts)
      
return scripts
