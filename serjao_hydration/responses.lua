
HYDRATION_MODULE.set_input_by_id = function (id,value)
	return {
	  func_name = "Hydration_set_input_id",
	  args={value=value,id=id}
	}
end
HYDRATION_MODULE.replace_element_by_id = function (id,value)
	return {
	  func_name = "Hydration_replace_element_by_id",
	  args={value=value,id=id}
	}
end