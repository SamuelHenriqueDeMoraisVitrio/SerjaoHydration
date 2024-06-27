

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