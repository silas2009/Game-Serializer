local module = {}

-- services --
local rs = game:GetService("ReplicatedStorage")

-- variables --
local isStudio = game.PlaceId == 5846387555
local remotes = rs:FindFirstChild("Remotes")

-- decompiling variables --
local ss = rs:FindFirstChild("ScriptService")
local zeros = "000000000000000"
local compression = {legacy=require(ss.Compression.Legacy),base93=require(ss.Compression.Base93),zlib=require(ss.Compression.Zlib)}
local converters = {
	require(ss.LoadModules:WaitForChild(zeros.."1")),
	require(ss.LoadModules:WaitForChild(zeros.."2")),
	require(ss.LoadModules:WaitForChild(zeros.."3"))
}

-- importing variables --
local scriptRemotes = isStudio and remotes.ScriptEditor
local createBlock = isStudio and scriptRemotes.CreateBlock
local openScript = isStudio and scriptRemotes.OpenScript
local saveScript = isStudio and scriptRemotes.ScriptSaveRequested
local setValueInput = isStudio and scriptRemotes.SetValueInput
local setVariableInput = isStudio and scriptRemotes.SetVariableInput
local setOutputName = isStudio and scriptRemotes.SetOutputName
local setValueType = isStudio and scriptRemotes.SetValueType

-- functions --
module.import = function(script,code)
	code.Object = script
	openScript:InvokeServer(script)
	for blockName,block in pairs(code.Blocks) do
		createBlock:InvokeServer(code.Object,block.Type,blockName)
		for InputName,InputData in pairs(block.Inputs) do
			if InputData.UseVariable then
				setVariableInput:InvokeServer(code.Object,blockName,InputName,InputData.Variable)
			else
				setValueType:InvokeServer(code.Object,blockName,InputName,InputData.ValueType)
				setValueInput:InvokeServer(code.Object,blockName,InputName,InputData.Value)
			end
		end
		for OutputName,OutputValue in pairs(block.Outputs) do
			setOutputName:InvokeServer(code.Object,blockName,OutputName,OutputValue)
		end
	end
	saveScript:InvokeServer(code)
end

module.decompile = function(script)
	if not script:IsA("Script") then return end
	if script:GetAttribute("IsReferenceModel") then return script:GetAttribute("ReferenceModel"),"ReferenceModel" end

	local source = script:GetAttribute("VisualSource")
	if not source then return end

	if string.sub(source, 1, 1) == '!' then
		source = compression.legacy.decompress(source)
	end
	if string.sub(source, 1, 16) == "0000000000000001" then
		return converters[1](source)
	end
	if string.sub(source, 1, 16) == "0000000000000002" then
		return converters[2](source)
	end
	if string.sub(source, 1, 18) == "\x1A0000000000000003\x1B" then
		source = string.sub(source, 19, -1)
		source = compression.base93.decode(source)
		source = compression.zlib.Deflate.Decompress(source)
		return converters[3](source)
	end

	return source,script.ClassName
end

return module
