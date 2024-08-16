local isStudio = game.PlaceId == 5846387555

if not isStudio then return end

local rs = game:GetService("ReplicatedStorage")
local ScriptService = rs.ScriptService
local compression = require(ScriptService.Compression)
local converter = require(ScriptService.LoadModules:FindFirstChild("0000000000000001"))
local remoteFunctions = rs:WaitForChild("RemoteFunctions",2)
local createBlock = remoteFunctions and remoteFunctions.ScriptEditor.CreateBlock
local openScript = remoteFunctions and remoteFunctions.ScriptEditor.OpenScript
local saveScript = remoteFunctions and remoteFunctions.ScriptEditor.ScriptSaveRequested
local setValueInput = remoteFunctions and remoteFunctions.ScriptEditor.SetValueInput
local setVariableInput = remoteFunctions and remoteFunctions.ScriptEditor.SetVariableInput
local setOutputName = remoteFunctions and remoteFunctions.ScriptEditor.SetOutputName
local setValueType = remoteFunctions and remoteFunctions.ScriptEditor.SetValueType

function codeToTable(Script)
	return converter(compression.decompress(Script))
end

return function(Object,ScriptString)
	local Script = codeToTable(ScriptString)
	Script.Object = Object
	openScript:InvokeServer(Script.Object)
	--setclipboard(stringify(Script.Blocks,_,false))
	for blockName,block in pairs(Script.Blocks) do
		createBlock:InvokeServer(Script.Object,block.Type,blockName)
		for InputName,InputData in pairs(block.Inputs) do
			if InputData.UseVariable then
				setVariableInput:InvokeServer(Script.Object,blockName,InputName,InputData.Variable)
			else
				setValueType:InvokeServer(Script.Object,blockName,InputName,InputData.ValueType)
				setValueInput:InvokeServer(Script.Object,blockName,InputName,InputData.Value)
			end
		end
		for OutputName,OutputValue in pairs(block.Outputs) do
			setOutputName:InvokeServer(Script.Object,blockName,OutputName,OutputValue)
		end
	end
	saveScript:InvokeServer(Script)
end
