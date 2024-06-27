

local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")



local increment = hy.create_bridge("/increment")
increment.add_header("num",hy.inputId("num"))
increment.add_header("acumulador",hy.textId("acumulador"))


---@param request Request
local function whatever_name(request)

    if request.route == "/increment" then
        local num = tonumber(request.header["num"])
        local acumulador = tonumber(request.header["acumulador"])
        return hy.replace_element_by_id("acumulador",h3(tostring(num+acumulador),{id="acumulador"}).render())
    end

    return body(
            script(hy.create_script()),
            serjao.fragment("<input value='0' id='num'>"),
            h3("0",{id="acumulador"}),
            button("increment ",{onclick=increment.call()})
    )
end

serjao.server(3000,4000, whatever_name)

