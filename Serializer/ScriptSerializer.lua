local module = {}

local rs = game:GetService("ReplicatedStorage")
local createBlock
local openScript
local saveScript
local setValueInput
local setVariableInput
local setOutputName
if game.PlaceId == 5846387555 then
	createBlock = rs.RemoteFunctions.ScriptEditor.CreateBlock
	openScript = rs.RemoteFunctions.ScriptEditor.OpenScript
	saveScript = rs.RemoteFunctions.ScriptEditor.ScriptSaveRequested
	setValueInput = rs.RemoteFunctions.ScriptEditor.SetValueInput
	setVariableInput = rs.RemoteFunctions.ScriptEditor.SetVariableInput
	setOutputName = rs.RemoteFunctions.ScriptEditor.SetOutputName
end
local codeToTable = require(rs.ScriptService)

function module.deSerializeScript(Object,Script)
	Script = codeToTable.loadScript(Script)
	Script.Object = Object
	openScript:InvokeServer(Script.Object)
	
	for blockName,block in pairs(Script.Blocks) do
		createBlock:InvokeServer(Script.Object,block.Type,blockName)
		for InputName,InputData in pairs(block.Inputs) do
			if InputData.UseVariable then
				setVariableInput:InvokeServer(Script.Object,blockName,InputName,InputData.Variable)
			else
				setValueInput:InvokeServer(Script.Object,blockName,InputName,InputData.Value)
			end
		end
		for OutputName,OutputValue in pairs(block.Outputs) do
			setOutputName:InvokeServer(Script.Object,blockName,OutputName,OutputValue)
		end
	end
	saveScript:InvokeServer(Script)
end

return module
