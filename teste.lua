

local serjao = require("serjao_berranteiro/serjao_berranteiro")
local hy = require("serjao_hydration")

local add_num = hy.create_hydration("teste","/aaa")
add_num.add_header("teste",hy.inputId("aaa"))
add_num.add_header("b",hy.arg("teste"))



io.open("test.js","w"):write(hy.create_script())
