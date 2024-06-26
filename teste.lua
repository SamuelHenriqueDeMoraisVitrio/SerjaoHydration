

local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")



local increment = hy.create_bridge("/increment")
increment.add_header("num_val",hy.inputId("num"))


---@param request Request
local function whatever_name(request)

    if request.route ~= "/increment" then
        return body(
                h3("0",{id="num"}),
                button("increment ",{onclick=increment.call()})
        )
    end

  return "Hello Word", 400

end

serjao.server(3000,4000, whatever_name)

