
---@type HydrationElement[]
HYDRATION_FUNCTIONS = {}
HYDRATION_SIZE = 0
SCRIPT = ""
HYDRATION_MODULE = {}

HYDRATION_SCRIPT = "\nfunction Hydration_set_input_id(args){\n    document.getElementById(args.id).value = args.value\n}\nfunction Hydration_replace_element_by_id(args){\n    document.getElementById(args.id).innerHTML = args.value\n}\n  function hydration_generate_element_evaluation(element){\n    let action = element[\"func_name\"]\n    let args = element[\"args\"]\n    let evaluation = action +\"(args)\"\n      try  {\n        eval(evaluation)\n    }catch (error){\n        console.log(error)\n    }\n\n}\nasync function hydration_perform(route,headers){\n     let result = await  fetch(route, {\n         headers: headers,\n         method:\"POST\"\n     })\n\n    let result_in_json = await  result.json()\n    if(result_in_json.constructor===Object){\n        hydration_generate_element_evaluation(result_in_json)\n        return\n    }\n    if(result_in_json.constructor === Array){\n        result_in_json.forEach(e =>{\n            hydration_generate_element_evaluation(e)\n        })\n    }\n\n}"



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
    created.call  = function (args)
        if args then
            	return created.name.."("..args..")"
        end
        return created.name.."()"

    end

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

HYDRATION_MODULE.set_input_by_id = function (id,value)
	return {
	  func_name = "Hydration_set_input_id",
	  args={value=value,id=id}
	}
end
HYDRATION_MODULE.replace_element_by_id = function (id,value)
	return {
	  func_name = "Hydration_replace_element_by_id",
	  args={value=value,id=id}
	}
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

---@param id string
---@return string
HYDRATION_MODULE.textId = function (id)
    return "document.getElementById('"..id.."').innerText"
end


---@class HydrationHeader
---@field key string
---@field value string


---@class HydrationResponse
--_@field func_name string
---@field args table

---@class HydrationElement
---@field name string
---@field route string
---@field headers HydrationHeader[]
---@field headers_size number
---@field add_header fun(key:string, value:string):HydrationElement
---#field call fun(element:args):string


---@class HydrationModule
---@field create_bridge fun(route:string,name:string | nil):HydrationElement
---@field inputid fun(id:string):string
---@field arg fun(id:string):string
---@field create_script fun():string
---@field set_input_by_id fun(id:string,name:string):HydrationResponse
---@field Hydration_replace_element_by_id fun(id:string,name:string):HydrationResponse

---@type HydrationModule
return HYDRATION_MODULE