
local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")

local determinanum = hy.create_bridge("/determinanum")

determinanum.add_header("visor", hy.inputId("num"))
determinanum.add_header("botao", hy.arg("selectnum"))

local function main(rq)

  if "/determinanum" == rq.route then

    local visor = rq.header["visor"]
    local botao = rq.header["botao"]

    if visor == nil then
      return "input Não foi informado", 404
    end

    if botao == nil then
      return "botao Não foi informado", 404
    end

    local novoVisor = visor .. botao

    local novoInput = '<input id="num" value="' .. novoVisor .. '"/>'

    return hy.replace_element_by_id("num", novoInput)
  end
  return html(head(
                script(
                  hy.create_script()
                )
          ),
          body(
            serjao.fragment('<input id="num" value="0"/>'),
            button("1", {onclick=determinanum.call("{'selectnum': 1}")})
            )
          )
end

serjao.server(3000, main)