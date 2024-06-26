  function hydration_generate_element_evaluation(element){
    let action = element["func_name"]
    let args = element["args"]
    let evaluation = action +"(args)"
    try  {
        eval(evaluation)
    }catch (error){
        console.log(error)
    }

}
async function hydration_perform(route,headers){
     let result = await  fetch(route, {
         headers: headers,
         method:"POST"
     })
    let result_in_json = await  result.json()

    if(result_in_json.constructor===Object){
        hydration_generate_element_evaluation(result_in_json)
        return
    }
    if(result_in_json.constructor === Array){
        result_in_json.forEach(e =>{
            hydration_generate_element_evaluation(e)
        })
    }

}