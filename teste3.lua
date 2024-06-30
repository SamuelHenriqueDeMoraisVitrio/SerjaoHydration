
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

    if botao == "10" then
      return hy.replace_element_by_id("div", "<h1>" .. visor .. "</h1>")
    end

    local novoVisor = visor .. botao

    return hy.set_input_by_id("num", novoVisor)
  end
  return html(head(
                script(
                  hy.create_script()
                )
          ),
          body(
                  div({id="div"}),
                  serjao.fragment('<input id="num" value="0"/>'),
                  button("1", {onclick=determinanum.call("{'selectnum': 1}")}),
                  button("2", {onclick=determinanum.call("{'selectnum': 2}")}),
                  button("3", {onclick=determinanum.call("{'selectnum': 3}")}),
                  button("4", {onclick=determinanum.call("{'selectnum': 4}")}),
                  button("5", {onclick=determinanum.call("{'selectnum': 5}")}),
                  button("6", {onclick=determinanum.call("{'selectnum': 6}")}),
                  button("7", {onclick=determinanum.call("{'selectnum': 7}")}),
                  button("8", {onclick=determinanum.call("{'selectnum': 8}")}),
                  button("9", {onclick=determinanum.call("{'selectnum': 9}")}),
                  button("calc", {onclick=determinanum.call("{'selectnum': 10}")})
            )
          )
end

serjao.server(3000, main)