local module = {}

local rs = game:GetService("ReplicatedStorage")
local createBlock = rs.RemoteFunctions.ScriptEditor.CreateBlock
local openScript = rs.RemoteFunctions.ScriptEditor.OpenScript
local saveScript = rs.RemoteFunctions.ScriptEditor.ScriptSaveRequested
local setValueInput = rs.RemoteFunctions.ScriptEditor.SetValueInput
local setVariableInput = rs.RemoteFunctions.ScriptEditor.SetVariableInput
local setOutputName = rs.RemoteFunctions.ScriptEditor.SetOutputName
local codeToTable = require(rs.ScriptService)
local DeserializeValues = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Values/ValueDeserializer.lua"))()
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

function module.deSerializeScript(Script)
	openScript:InvokeServer(Script.Object)

	for blockName,block in pairs(Script.Blocks) do
		createBlock:InvokeServer(Script.Object,block.Type,blockName)
		for InputName,InputData in pairs(block.Inputs) do
			if InputData.UseVariable then
				setVariableInput:InvokeServer(Script.Object,blockName,InputName,InputData.Variable)
			else
				if typeof(InputData.Value) == "table" and InputData.Value.Type then
					local Function = DeserializeValues[InputData.Value.Type]
					InputData.Value = Function(InputData.Value)
				end
				setValueInput:InvokeServer(Script.Object,blockName,InputName,InputData.Value)
			end
		end
		block.VisualPosition = DeserializeValues[block.VisualPosition.Type](block.VisualPosition)
		for OutputName,OutputValue in pairs(block.Outputs) do
			setOutputName:InvokeServer(Script.Object,blockName,OutputName,OutputValue)
		end
	end
	saveScript:InvokeServer(Script)
end

return module
