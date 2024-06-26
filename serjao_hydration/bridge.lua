

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
