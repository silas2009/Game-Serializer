local module = {}

-- services --
local rs = game:GetService("ReplicatedStorage")

-- variables --
local isStudio = game.PlaceId == 5846387555
local remoteFunctions = rs:FindFirstChild("remoteFunctions")

-- decompiling variables --
local ss = rs:FindFirstChild("ScriptService")
local compression = {legacy=require(ss.Compression.Legacy),base93=require(ss.Compression.Base93),zlib=require(ss.Compression.Zlib)}
local converters = {}
for _,v in pairs(ss.LoadModules:GetChildren()) do
	if v:IsA("ModuleScript") then
		converters[v.Name] = v -- require(v)
	end
end

-- importing variables --
local scriptRemoteFunctions = isStudio and remoteFunctions.ScriptEditor
local createBlock = isStudio and scriptRemoteFunctions.CreateBlock
local openScript = isStudio and scriptRemoteFunctions.OpenScript
local saveScript = isStudio and scriptRemoteFunctions.ScriptSaveRequested
local setValueInput = isStudio and scriptRemoteFunctions.SetValueInput
local setVariableInput = isStudio and scriptRemoteFunctions.SetVariableInput
local setOutputName = isStudio and scriptRemoteFunctions.SetOutputName
local setValueType = isStudio and scriptRemoteFunctions.SetValueType

-- functions --
module.import = function(script,code)
	openScript:InvokeServer(script)
	-- unfinished
end

module.decompile = function(script)
	if not script:IsA("Script") then return end
	if script:GetAttribute("IsReferenceModel") then return script:GetAttribute("ReferenceModel"),"ReferenceModel" end

	local source = script:GetAttribute("VisualSource")
	if not source then return end

	local converterVersion = source:sub(2,17)
	local compressor = compression.base93
	local converter

	if converters[converterVersion] then -- base93 scripts
		source = source:sub(19,#source)
		source = compression.zlib.Deflate.Decompress(compressor.decode(source))
	else -- legacy scripts
		compressor = compression.legacy
		source = compressor.decompress(source)
		converterVersion = source:sub(1,16)
	end

	converter = converters[converterVersion]
	return source,script.ClassName -- converter(source),script.ClassName
end

--[[local output = module.decompile(workspace.Scripte)
print(output)
for i,v in pairs(output.Blocks) do
	print(i,v)
end--]]

return module
