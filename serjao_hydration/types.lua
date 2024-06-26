

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