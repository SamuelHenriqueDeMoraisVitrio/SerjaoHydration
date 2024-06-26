

HYDRATION_MODULE.create_script = function()
	local text = HYDRATION_SCRIPT.."\n"
	for i=1,HYDRATION_SIZE do
	    local current = HYDRATION_FUNCTIONS[i]

		text = text.."async function "..current.name.."(args){\n"
		text = text.."let headers = {}\n"
        text = text..Private_hdration_add_headers(current.headers,current.headers_size)
        text = text.."await hydration_perform('"..current.route.."',headers);\n"
		text = text.."}\n"
	end

	return text
end
