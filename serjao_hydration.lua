
---@type HydrationElement[]
HYDRATION_FUNCTIONS = {}
HYDRATION_SIZE = 0

HYDRATION_MODULE = {}



---@param headders HydrationHeader[]
---@param headders_size number
---@return string
function Private_hdration_add_headers(headders,headders_size)
    local text = ""
     for i=1,headders_size do
          local current = headders[i]

          text = text.."headers['"..current.key.."'] ="..current.value.."\n"
     end
    return text
end


HYDRATION_MODULE.create_hydration = function(name)
    local created = {
        name=name,
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
	local text = ""
	for i=1,HYDRATION_SIZE do
	    local current = HYDRATION_FUNCTIONS[i]

		text = text.."function "..current.name.."(args){\n"
		text = text.."let headers = {}\n"
        text = text..Private_hdration_add_headers(current.headers,current.headers_size)
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
---@field headers HydrationHeader[]
---@field headers_size number
---@field add_header fun(key:string, value:string):HydrationElement

---@class HydrationModule
---@field create_hydration fun(name:string):HydrationElement
---@field create_script fun():string