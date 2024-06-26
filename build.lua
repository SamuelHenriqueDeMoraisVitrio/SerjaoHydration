


local dtw = require("luaDoTheWorld/luaDoTheWorld")

local final_text = ""

local lua_files,size = dtw.list_files_recursively("serjao_hydration",true)
local globals = ""

for i=1,size do
	local current = lua_files[i]
	local name = dtw.newPath(current).get_name()
	if name == "globals.lua" then
		globals = dtw.load_file(current)
	else
	    final_text = final_text.."\n"..dtw.load_file(current)
	end

end
local scritp_elements,size = dtw.list_files_recursively("scripts",true)
local script_content ='HYDRATION_SCRIPT = "'
for i =1,size do

    local content = dtw.load_file(scritp_elements[i])
    local formated_content = string.gsub(content,'"','\\"')
     formated_content = string.gsub(formated_content,'\n','\\n')

    script_content = script_content..formated_content
end
script_content = script_content..'"'
final_text = globals.."\n"..script_content.."\n"..final_text


final_text = final_text..'"'
dtw.write_file("serjao_hydration.lua",final_text)
