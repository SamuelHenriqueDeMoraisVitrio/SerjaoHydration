

local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")

local add_num = hy.create_hydration("teste")
add_num.add_header("teste","aaa")


io.open("teste.js","w"):write(hy.create_script())
