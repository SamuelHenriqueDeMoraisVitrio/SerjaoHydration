

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
---@field inputid fun(id:string):string
---@field create_script fun():string