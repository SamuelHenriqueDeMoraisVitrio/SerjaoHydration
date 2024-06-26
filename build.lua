


local dtw = require("luaDoTheWorld/luaDoTheWorld")


local elements,size = dtw.list_files_recursively("serjao_hydration",true)
local globals = ""
local final_text = ""
for i=1,size do
	local current = elements[i]
	local name = dtw.newPath(current).get_name()
	if name == "globals.lua" then
		globals = dtw.load_file(current)
	else
	    final_text = final_text.."\n"..dtw.load_file(current)
	end

end
final_text = globals.."\n"..final_text
dtw.write_file("serjao_hydration.lua",final_text)