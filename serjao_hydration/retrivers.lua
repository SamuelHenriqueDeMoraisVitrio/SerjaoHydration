

---@param id string
---@return string
HYDRATION_MODULE.inputId = function (id)
    return "document.getElementById('"..id.."').value"
end