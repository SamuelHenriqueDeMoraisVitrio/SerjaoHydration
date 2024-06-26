
---@type HydrationElement[]
HYDRATION_FUNCTIONS = {}
HYDRATION_SIZE = 0
SCRIPT = ""
HYDRATION_MODULE = {}

HYDRATION_SCRIPT = "\nasync function hydration_perform(route,headers){\n     let result = await  fetch(route, {\n         headers: headers,\n         method:\"POST\"\n     })\n    let result_in_json = await  result.json()\n    result_in_json.forEach(e =>{\n        let action = e[\"func_name\"]\n        let args = e[\"args\"]\n        let evaluation = action +\"(args)\"\n        try  {\n            eval(evaluation)\n        }catch (error){\n            console.log(error)\n        }\n    })\n}"


---@param headders HydrationHeader[]
---@param headders_size number
---@return string
function Private_hdration_add_headers(headders,headders_size)
    local text = ""
     for i=1,headders_size do
          local current = headders[i]
          text = text.."\theaders['"..current.key.."'] ="..current.value..";\n"
     end
    return text
end


---@param id string
---@return string
HYDRATION_MODULE.inputId = function (id)
    return "document.getElementById('"..id.."').value"
end
---@param id string
---@return string
HYDRATION_MODULE.arg = function (name)
    return "args['"..name.."']"
end


HYDRATION_MODULE.create_bridge = function(route,name)
    local formatted_name =  name
    if name == nil then
        formatted_name = string.gsub(route,"/","")
        formatted_name = "hydration_func_"..formatted_name
    end
    local created = {
        route=route,
        name=formatted_name,
        headers={},
        headers_size =0
    }

    HYDRATION_SIZE = HYDRATION_SIZE +1
    HYDRATION_FUNCTIONS[HYDRATION_SIZE] = created

    created.add_header = function (key,value)
    	   created.headers_size  = created.headers_size+1
    	   local header = {key=key,value=value}
    	   created.headers[created.headers_size] = header
    	   return created
    end
   return created

end


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

---@type HydrationModule
return HYDRATION_MODULE



---@class HydrationHeader
---@field key string
---@field value string

---@class HydrationElement
---@field name string
---@field route string
---@field headers HydrationHeader[]
---@field headers_size number
---@field add_header fun(key:string, value:string):HydrationElement

---@class HydrationModule
---@field create_bridge fun(route:string,name:string | nil):HydrationElement
---@field inputid fun(id:string):string
---@field arg fun(id:string):string
---@field create_script fun():string"