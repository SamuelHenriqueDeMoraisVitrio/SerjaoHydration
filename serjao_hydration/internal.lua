
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