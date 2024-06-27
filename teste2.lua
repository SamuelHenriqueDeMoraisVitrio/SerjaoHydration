
local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")

local incrementa = hy.create_bridge("/FRBA")

incrementa.add_header("nome",hy.textId("num"))

local function main(rq)

  if "/FRBA" == rq.route then

    local num = rq.header["nome"]

    local numConvertido = tonumber(num) + 1

    return hy.replace_element_by_id("num",h1(tostring(numConvertido), {id="num"}).render())
  end
  return html(head(
          script(
                  hy.create_script()
          )
  ), body(
          h1("1", {id="num"}),
          button("incrementa valor", {onclick=incrementa.call()})
  )
  )
end

serjao.server(3000, main)