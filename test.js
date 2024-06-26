
async function hydration_perform(route,headers){
     let result = await  fetch(route, {
         headers: headers,
         method:"POST"
     })
    let result_in_json = await  result.json()
    result_in_json.forEach(e =>{
        let action = e["func_name"]
        let args = e["args"]
        let evaluation = action +"(args)"
        try  {
            eval(evaluation)
        }catch (error){
            console.log(error)
        }
    })
}
async function hydration_func_teste(args){
let headers = {}
	headers['teste'] =document.getElementById('aaa').value;
	headers['b'] =args['teste'];
await hydration_perform('teste',headers);
}
