

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
---@field create_script fun():string